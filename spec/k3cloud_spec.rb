# frozen_string_literal: true

require "k3cloud"

RSpec.describe K3cloud do

  it "test query bill successful" do
    K3cloud.configure do |config|
      config.acct_id = ""
      config.user_name = ""
      config.app_id = ""
      config.app_secret = ""
      config.server_url = ""
    end

    data = {
      FormId: "PRD_MO",
      FieldKeys: "FMaterialId.FNumber, FNoStockInQty",
      FilterString: "FStatus not in (6, 7)"
    }
    result = K3cloud.execute_bill_query(data)

    expect(result).not_to be nil
  end
end
