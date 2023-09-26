# frozen_string_literal: true

require "net/http"
require "net/https"
require "uri"

module K3cloud
  # HTTP Client
  class Http
    attr_accessor :url, :header, :body, :connect_timeout, :request_timeout

    def initialize(url, header, body, connect_timeout, request_timeout)
      @url = url
      @header = header
      @body = body
      @connect_timeout = connect_timeout || 120
      @request_timeout = request_timeout || 120
    end

    def post
      uri = URI(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.open_timeout = @connect_timeout * 1000
      http.read_timeout = @request_timeout * 1000
      request = Net::HTTP::Post.new(uri)
      request.initialize_http_header(@header)
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "Kingdee/Ruby WebApi SDK"
      request.body = @body.to_json
      response = http.request(request)
      response.body
    rescue StandardError => e
      K3cloud.logger.warn "#{e.message} => K3cloud::HTTP.post('#{@url}')"
      nil
    end
  end
end
