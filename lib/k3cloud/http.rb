# frozen_string_literal: true

require "k3cloud/errors/response_error"
require "net/http"
require "net/https"
require "uri"
require "json"

module K3cloud
  # HTTP Client
  class Http
    attr_accessor :url, :header, :body, :connect_timeout, :request_timeout, :status_code

    def initialize(url, header, body, connect_timeout = 120, request_timeout = 120)
      @url = url
      @header = header || {}
      @body = body
      @connect_timeout = connect_timeout
      @request_timeout = request_timeout
    end

    def post
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      # SSL/TLS configuration
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      http.open_timeout = @connect_timeout
      http.read_timeout = @request_timeout
      request = Net::HTTP::Post.new(uri.request_uri)
      request.initialize_http_header(@header)
      request["Content-Type"] = "application/json"
      request["User-Agent"] = generate_user_agent
      request.body = @body.is_a?(String) ? @body : @body.to_json

      response = http.request(request)
      @status_code = response.code.to_i
      raise K3cloud::ResponseError, "status: #{response.code}, desc: #{response.body}" if @status_code >= 400

      response.body
    rescue Errno::ETIMEDOUT, Net::OpenTimeout, Net::ReadTimeout => e
      raise K3cloud::ResponseError, "Request timed out: #{e.message}"
    rescue Net::HTTPServerError => e
      raise K3cloud::ResponseError, "Server error: #{e.message}"
    rescue => e
      raise K3cloud::ResponseError, "Unexpected error: #{e.message}"
    end

    private

    # Generate User-Agent string with client info
    def generate_user_agent
      "Kingdee/Ruby WebApi SDK(v#{K3cloud::VERSION}) (Ruby #{RUBY_VERSION}; #{RUBY_PLATFORM})"
    end
  end
end
