module ApplicationHelper
  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url => url,
    }

    container && opts[:container] ||= container
    javascript_tag("$('#topics').pageless(#{opts.to_json});")
  end
end
