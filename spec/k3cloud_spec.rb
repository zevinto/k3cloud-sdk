# frozen_string_literal: true

require "k3cloud"

RSpec.describe K3cloud do
  describe "#configure" do
    before do
      K3cloud.configure do |config|
        config.acct_id = ""
        config.user_name = ""
        config.app_id = ""
        config.app_secret = ""
        config.server_url = ""
      end
    end

    it "test single account" do
      data = {
        FormId: "PRD_MO",
        FieldKeys: "FMaterialId.FNumber, FNoStockInQty",
        FilterString: "FStatus not in (6, 7)"
      }
      result = K3cloud.execute_bill_query(data)
      expect(result).to be_a(Array)
    end
  end

  describe "#multi_configuration" do
    before do
      @config1 = K3cloud::Configuration.new do |c|
        c.acct_id = ""
        c.user_name = ""
        c.app_id = ""
        c.app_secret = ""
        c.server_url = ""
      end

      @config2 = K3cloud::Configuration.new do |c|
        c.acct_id = ""
        c.user_name = ""
        c.app_id = ""
        c.app_secret = ""
        c.server_url = ""
      end
    end
    it "test multi account" do
      K3cloud1 = K3cloud.new_api(@config1)
      K3cloud2 = K3cloud.new_api(@config2)
      data = {
        FormId: "PRD_MO",
        FieldKeys: "FMaterialId.FNumber, FNoStockInQty",
        FilterString: "FStatus not in (6, 7)"
      }
      result1 = K3cloud1.execute_bill_query(data)
      result2 = K3cloud2.execute_bill_query(data)

      expect(K3cloud1).not_to be K3cloud2
      expect(result1).to be_a(Array)
      expect(result2).to be_a(Array)
    end
  end
end
