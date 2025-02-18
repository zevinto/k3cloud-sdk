# frozen_string_literal: true

require "k3cloud/web_api_client"

module K3cloud
  # k3cloud Api
  class K3cloudApi < WebApiClient
    # 暂存
    def draft(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Draft", [form_id, data])
    end

    # 保存
    def save(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Save", [form_id, data])
    end

    # 批量保存
    def batch_save(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.BatchSave", [form_id, data])
    end

    # 提交
    def submit(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Submit", [form_id, data])
    end

    # 审核
    def audit(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Audit", [form_id, data])
    end

    # 反审核
    def un_audit(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.UnAudit", [form_id, data])
    end

    # 查看
    def view(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.View", [form_id, data])
    end

    # 单据查询
    def execute_bill_query(data)
      rows = execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.ExecuteBillQuery", [data])
      handle_query_result(rows)
    end

    # 删除
    def delete(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Delete", [form_id, data])
    end

    # 撤销
    def cancel_assign(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.CancelAssign", [form_id, data])
    end

    # 下推
    def push(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Push", [form_id, data])
    end

    # 状态转换：如关闭、反关闭、作废、反作废等
    def execute_operation(form_id, op_number, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.ExcuteOperation", [form_id, op_number, data])
    end

    # 分配
    def allocate(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Allocate", [form_id, data])
    end

    # 取消分配
    def cancel_allocate(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.CancelAllocate", [form_id, data])
    end

    # 分组保存
    def group_save(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.GroupSave", [form_id, data])
    end

    # 分组信息查询
    def query_group_info(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.QueryGroupInfo", [data])
    end

    # 分组删除
    def group_delete(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.GroupDelete", [data])
    end

    # 附件上传
    def attachment_upload(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.AttachmentUpload", [data])
    end

    # 附件下载
    def attachment_download(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.AttachmentDownLoad", [data])
    end

    # 元数据查询
    def query_business_info(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.QueryBusinessInfo", [data])
    end

    # 查询报表数据
    def get_sys_report_data(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.GetSysReportData", [form_id, data])
    end

    def flex_save(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.FlexSave", [form_id, data])
    end

    def send_msg(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.SendMsg", [form_id, data])
    end

    def disassembly(form_id, data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.Disassembly", [form_id, data])
    end

    # 工作流审核
    def workflow_audit(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.WorkflowAudit", [data])
    end

    # 切换组织
    def switch_org(data)
      execute("Kingdee.BOS.WebApi.ServicesStub.DynamicFormService.SwitchOrg", [data])
    end

    private

    def handle_query_result(rows)
      if !rows[0].nil? && (result = rows[0][0]).is_a?(Hash)
        K3cloud.logger.error({ errmsg: result, type: 'error', lever: 'ERROR' })
        []
      else
        []
      end
    end
  end
end
