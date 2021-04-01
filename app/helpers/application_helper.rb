module ApplicationHelper
  def flash_message(message, style)
    return unless message

    content_tag('div',
                'data-controller': 'flash',
                class: "alert alert-#{style} d-flex justify-content-between align-items-center") do
      content_tag('div', message) +
        content_tag('button',
                    nil,
                    type: 'button',
                    'data-action': 'flash#remove',
                    class: 'btn-close',
                    'aria-label': 'Close')
    end
  end
end
