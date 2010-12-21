module ApplicationHelper
  
  def link_block(link,&block)
#    content_tag(:a,:class=>"linkblock","data-remote" => true, :href=>link) do
    content_tag(:a,:class=>"linkblock", :href=>link) do
      yield
    end
  end
  
  def tag_flag(text, destroy_link)
    content_tag(:div, :class =>"tag") do
      concat(content_tag(:div, :class =>"tagname") do
        text
      end)
      concat(content_tag(:div, :class =>"tagdestroy") do
        link_to "X", destroy_link, :method => :delete
      end)
    end
  end
  
end
