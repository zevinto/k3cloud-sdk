# frozen_string_literal: true

require_relative "k3cloud/version"
require "logger"
require "k3cloud/configuration"
require "k3cloud/k3cloud_api"
require "forwardable"

module K3cloud
  class << self
    extend Forwardable

    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end

    def logger
      @logger ||= ::Logger.new($stderr)
    end

    def api
      @api ||= K3cloud::K3cloudApi.new
    end

    def_delegators :api, :draft, :save, :batch_save, :submit, :audit, :un_audit, :view, :execute_bill_query, :delete,
                   :cancel_assign, :push, :execute_operation, :allocate, :cancel_allocate, :group_save, :query_group_info,
                   :group_delete, :attachment_upload, :attachment_download, :query_business_info, :get_sys_report_data,
                   :flex_save, :send_msg, :disassembly, :workflow_audit, :switch_org
  end
end
