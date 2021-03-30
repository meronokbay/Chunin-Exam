module ApplicationHelper
  def flash_alert_message
    content_tag('div', alert, class: 'alert alert-danger') if alert
  end

  def flash_notice_message
    content_tag('div', notice, class: 'alert alert-info') if notice
  end
end
