# frozen_string_literal: true

require "k3cloud/errors/response_error"
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
      @connect_timeout = connect_timeout || 2
      @request_timeout = request_timeout || 2
    end

    def post
      uri = URI(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.open_timeout = @connect_timeout * 60
      http.read_timeout = @request_timeout * 60
      request = Net::HTTP::Post.new(uri)
      request.initialize_http_header(@header)
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "Kingdee/Ruby WebApi SDK"
      request.body = @body.to_json
      max_retries = 5 # 最大重试次数
      retry_count = 0
      sleep_interval = 5 # 重试间隔时间，单位秒

      begin
        response = http.request(request)
        if response.code.to_i != 200 && response.code.to_i != 206
          raise K3cloud::ResponseError, "status: #{response.code}, desc: #{response.body}"
        end
        response.body
      rescue Errno::ETIMEDOUT, Net::OpenTimeout, Net::ReadTimeout => e
        K3cloud.logger.error("Request timed out: #{e.message}")
        if retry_count < max_retries
          retry_count += 1
          K3cloud.logger.info("Request timed out. Retrying #{retry_count}/#{max_retries} in #{sleep_interval} seconds...")
          sleep(sleep_interval)
          retry
        else
          raise K3cloud::ResponseError, "Request failed after #{max_retries} retries: #{e.message}, backtrace: #{e.backtrace}"
        end
      end
    end
  end
end
