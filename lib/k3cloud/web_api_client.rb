# frozen_string_literal: true

require "k3cloud/errors/k3cloud_error"
require "k3cloud/utils/md5_utils"
require "k3cloud/utils/base64_utils"
require "k3cloud/utils/const_define"
require "k3cloud/configuration"
require "k3cloud/http"

module K3cloud
  class WebApiClient
    attr_accessor :config

    def initialize(config = Configuration.default)
      @config = config
    end

    def execute(service_name, parameters)
      result = execute_json(service_name, parameters)
      if result.start_with?("response_error:")
        error = K3cloudError.parse(result)
        if error.nil?
          raise StandardError, result
        else
          message = error.inner_ex_wrapper.nil? ? error.message : "#{error.message} --> #{error.inner_ex_wrapper&.message}"
          raise StandardError, message
        end
      else
        begin
          json = JSON.parse(result)
          raise StandardError, json if result.include?(',"IsSuccess":false,')

          json
        rescue StandardError => e
          raise StandardError, "JSON parse error, response: [#{result}]", e
        end
      end
    end

    private

    def execute_json(service_name, parameters)
      url = @config.server_url
      if url.nil? || url.empty?
        url = "https://api.kingdee.com/galaxyapi/"
      else
        url = url.to_s.strip.chomp("/")
      end
      url = "#{url}/#{service_name}.common.kdsvc"
      K3cloud.logger.info("request_url: #{url}")

      header = build_header(url_path(url))
      body = { parameters: parameters }
      request = Http.new(url, header, body, @config.connect_timeout, @config.request_timeout)
      request.post
    end

    def url_path(url)
      if url.start_with?("http")
        index = url.index("/", 10)
        index > -1 ? url[index..-1] : url
      else
        url
      end
    end

    # @note: https://vip.kingdee.com/knowledge/specialDetail/229961573895771136?category=229964512944566016&id=423060878259269120&productLineId=1
    def build_header(url)
      header = {}
      if @config
        app_id_ary = @config.app_id.split("_")
        cookie_hd = app_id_ary[0]
        api_gw_sec = app_id_ary.size >= 2 ? decode_sec(app_id_ary[1]) : ""
        header[ConstDefine::X_API_CLIENT_ID] = cookie_hd
        header[ConstDefine::X_API_AUTH_VERSION] = "2.0"

        timestamps = Time.now.to_i.to_s
        header[ConstDefine::X_API_TIMESTAMP] = timestamps
        header[ConstDefine::X_API_NONCE] = timestamps
        header[ConstDefine::X_API_SIGN_HEADERS] = "X-Api-TimeStamp,X-Api-Nonce"

        url_path = CGI.escape(url.encode("UTF-8"))
        context = "POST\n#{url_path}\n\nx-api-nonce:#{timestamps}\nx-api-timestamp:#{timestamps}\n"
        api_signature = api_gw_sec == "" ? "" : MD5Utils.hash_mac(context, api_gw_sec)
        header[ConstDefine::X_API_SIGNATURE] = api_signature
        header[ConstDefine::X_KD_APP_KEY] = @config.app_id

        data = "#{@config.acct_id},#{@config.user_name},#{@config.lcid},#{@config.org_num}"
        app_data = Base64Utils.encoding_to_base64(data.bytes)
        header[ConstDefine::X_KD_APP_DATA] = app_data

        signature_data = "#{@config.app_id}#{data}"
        kd_signature = MD5Utils.hash_mac(signature_data, @config.app_secret)
        header[ConstDefine::X_KD_SIGNATURE] = kd_signature
      end
      header
    rescue StandardError => e
      K3cloud.logger.info("#{e.backtrace}")
      {}
    end

    def decode_sec(sec)
      buffer = Base64Utils.decoding_from_base64(sec)
      buffer = x_or_sec(buffer)
      Base64Utils.encoding_to_base64(buffer)
    end

    def x_or_sec(buffer)
      sec_key = "0054f397c6234378b09ca7d3e5debce7"
      pwd = sec_key.encode("UTF-8").bytes

      buffer.each_with_index do |byte, i|
        buffer[i] = byte ^ pwd[i % pwd.length]
      end
      buffer
    end
  end
end
