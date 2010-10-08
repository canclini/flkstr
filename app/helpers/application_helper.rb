module ApplicationHelper
  def link_block(link,&block)
    content_tag(:a,:class=>"linkblock", :href=>link) do
      yield
    end
  end
end
