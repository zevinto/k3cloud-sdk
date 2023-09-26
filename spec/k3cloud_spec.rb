# frozen_string_literal: true

require "k3cloud"

RSpec.describe K3cloud do

  it "test query bill successful" do
    K3cloud.configure do |config|
      config.acct_id = "63d9cc02a4b8c8"
      config.user_name = "Administrator"
      config.app_id = "256014_x39B29CL1pnX1U9P6ZXoQa0I2r4aRMPL"
      config.app_secret = "3630e28dad5249ac857abaa8f6844b91"
      config.server_url = "http://k3.yolanda.hk/K3Cloud/"
    end

    k3cloud_api = K3cloud::K3cloudApi.new
    data = {
      FormId: "PRD_MO",
      FieldKeys: "FMaterialId.FNumber, FNoStockInQty",
      FilterString: "FStatus not in (6, 7)"
    }
    result = k3cloud_api.execute_bill_query(data)

    expect(result).not_to be nil
  end
end
