module ApplicationHelper

    def flash_message_helper  
      if notice
        return "<script>toastr.info('#{notice}')</script>".html_safe
      elsif alert
        return "<script>toastr.warning('#{alert}')</script>".html_safe
      end
    end
end
