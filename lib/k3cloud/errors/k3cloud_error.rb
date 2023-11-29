# frozen_string_literal: true

require "json"

module K3cloud
  class K3cloudError < StandardError
    attr_accessor :message, :inner_ex_wrapper, :inner_exception

    def initialize
      @message = nil
      @inner_ex_wrapper = nil
      @inner_exception = nil
      super
    end

    def self.parse(json)
      index = json.index("{")
      json = json[index..-1] if index >= 0

      parsed_json = JSON.parse(json)
      kd_error = K3cloudError.new
      kd_error.message = parsed_json["Message"]
      kd_error.inner_ex_wrapper = K3cloudError.parse(parsed_json["InnerExWrapper"].to_json)
      kd_error.inner_exception = K3cloudError.parse(parsed_json["InnerException"].to_json)
      kd_error
    rescue StandardError => e
      K3cloud.logger.error("k3cloud Failed to parse exception message: #{e.message}")
      nil
    end
  end
end
