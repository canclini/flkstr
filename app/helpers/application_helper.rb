# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def link_block(link,&block)
#    content_tag(:a,:class=>"linkblock","data-remote" => true, :href=>link) do
    content_tag(:a,:class=>"linkblock", :href=>link) do
      yield
    end
  end
    
  def tag_flag(text, destroy_link)
    content_tag(:div, :class =>"tag") do
      concat(content_tag(:span, :class =>"tagname") do
        text
      end)
      concat(content_tag(:span, :class =>"tagdestroy") do
        button_to "X", destroy_link, :remote => :true, :method => :delete
      end)
    end
  end
    
  def errors_for(object, header=nil, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='errorExplanation #{object.class.name.humanize.downcase}Errors'>\n"
      html << "<div class='title'>"
      if header.blank?
        if object.new_record?
          html << "\t\t<h2>There was a problem creating the #{object.class.name.humanize.downcase}</h2>\n"
        else
          html << "\t\t<h2>There was a problem updating the #{object.class.name.humanize.downcase}</h2>\n"
        end    
      else
        html << "<h2>#{header}</h2>"
      end  
      html << "\t</div>\n"
      html << "<div class='content'>"      
      if message.blank?
        html << "<h3>folgende Felder:</h3>"
      else
        html << "<h3>#{message}</h3>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
      html << "\t</div>\n"
    end
    html
  end
end
