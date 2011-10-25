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
    RedCloth.new(auto_link(text.to_s)).to_html(:textile, :refs_smiley)
  end

  def expand_tree_into_select_field(categories)
    returning(Array.new) do |html|
      categories.each do |category|
        category.name = '>========' * category.ancestors.size + category.name
        html << category
        #html << %{<option value="#{ category.id }">#{ '&nbsp;&nbsp;&nbsp;' * category.ancestors.size }#{ category.name }</option>}
        html.concat expand_tree_into_select_field(category.children) if category.has_children?
      end
    end
  end
end
