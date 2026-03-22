module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def online_status(user)
    content_tag :span, user.name, class: "user-#{user.id} online_status #{'online' if user.online?}"
  end

  def emojify(content)
    return unless content.present?

    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      emoji = Emoji.find_by_alias($1)
      if emoji
        alias_name = ERB::Util.html_escape($1)
        filename = ERB::Util.html_escape(emoji.image_filename)
        %(<img alt="#{alias_name}" src="#{image_path("emoji/#{filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe
  end
end
