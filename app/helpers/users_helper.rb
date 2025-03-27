module UsersHelper
  def safe_blog_link(user)
    uri = URI.parse(user.blog_url)
    if uri && %w[http https].include?(uri.scheme)
      link_to user.blog_url, user.blog_url, target: "_blank", rel: "noopener"
    else
      content_tag(:p, "無効なURLです")
    end
  rescue URI::InvalidURIError
    content_tag(:p, "無効なURLです")
  end
end
