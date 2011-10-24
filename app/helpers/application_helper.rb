module ApplicationHelper
  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url => url,
    }

    container && opts[:container] ||= container
    javascript_tag("$('#topics').pageless(#{opts.to_json});")
  end

  def format_text(text)
    RedCloth.new(auto_link(text.to_s)).to_html(:textile,:refs_smiley)
  end
end
