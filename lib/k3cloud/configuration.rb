# frozen_string_literal: true

module K3cloud
  class Configuration
    # 服务Url地址(私有云必须配置金蝶云星空产品地址，K3Cloud/结尾。若为公有云则必须置空)
    attr_accessor :server_url

    # 账套ID(即数据中心id)
    attr_accessor :acct_id

    # 账套语系，默认2052
    # 2052: 简体中文
    # 1033: 英文
    # 3076: 繁体中文
    attr_accessor :lcid

    # 第三方系统登录授权的集成用户名称
    attr_accessor :user_name

    # 集成用户登录密码
    attr_accessor :password

    # 第三方系统登录授权的应用ID
    attr_accessor :app_id

    # 第三方系统登录授权的应用密钥
    attr_accessor :app_secret

    # 组织编码，启用多组织时配置对应的组织编码才有效
    attr_accessor :org_num

    attr_accessor :connect_timeout, :request_timeout

    def initialize(options = {})
      @acct_id          = options[:acct_id]
      @user_name        = options[:user_name]
      @password         = options[:password]
      @app_id           = options[:app_id]
      @app_secret       = options[:app_secret]
      @server_url       = options[:server_url]
      @org_num          = options[:org_num]
      @connect_timeout  = options[:connect_timeout]
      @request_timeout  = options[:request_timeout]

      yield(self) if block_given?
    end

    def self.default
      @@default ||= Configuration.new
    end
  end
end
