# frozen_string_literal: true

require_relative "k3cloud/version"
require "logger"
require "k3cloud/configuration"
require "k3cloud/k3cloud_api"

module K3cloud
  class << self
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end

    def logger
      @logger ||= ::Logger.new($stderr)
      @logger.level = logger::DEBUG
    end
  end
end
