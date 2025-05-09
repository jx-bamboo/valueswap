module ApplicationHelper
  def mask_string(str, front_length: 8, back_length: 8, mask: '******')
    return '' if str.nil? || str.empty?

    str = str.to_s
    total_length = front_length + back_length

    if str.length <= total_length
      str
    else
      str[0, front_length] + mask + str[-back_length, back_length]
    end
  end

  def get_menu_style(action)
    params[:action] == action ? "text-bg-warning text-light" : "text-light clmenu"
  end

end
