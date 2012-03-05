# encoding: utf-8
module StoriesHelper

  def story_title(story)
    html = "<div class=\"story-title\">"
    if story.kind == Story::Link
      html << "#{link_to story.title, story.url}"
    else
      html << story.title
    end
    html << "</div>"
    html.html_safe
  end

  def story_edit_btn(story)
    html = "&nbsp;"
    html << "<div class='btn-group'>"
    html << "<a class='btn btn-info btn-small' href='#'>Edit</a>"
    html << "<a class='btn btn-info btn-small dropdown-toggle' data-toggle='dropdown' href='#'>"
    html << "<span class='caret'></span>"
    html << "</a>"
    html << "<ul class='dropdown-menu'>"
    html << "<li>"
    html << "<a data-toggle='modal' href='#delete_confirm_" << story.id.to_s << "'>Delete</a>"
    html << "</li>"
    html << "</ul>"
    html << "</div>"
    html << "<div class='modal' style='display:none;' id='delete_confirm_" << story.id.to_s << "'>"
    html << "<div class='modal-header'>"
    html << "<a class='close' data-dismiss='modal'>&times;</a>"
    html << "<h3>Are you sure?</h3>"
    html << "</div>"
    html << "<div class='modal-body'>"
    html << "<p>You want to delete '" << story.title << "'</p>"
    html << "</div>"
    html << "<div class='modal-footer'>"
    html << "<a href='#' class='btn' data-dismiss='modal'>Cancel</a>"
    html << (link_to "Ok", story, :method => :delete, :class => 'btn btn-danger')
    html << "</div>"
    html << "</div>"
    html.html_safe
  end

  def sidebar_story_image(story)
    if image_exists? story.image_file_name
      return link_to image_tag(story.image.url(:thumb), :class=>'sidebar-story-thumb'), story
    else
      return ""
    end
  end

  def sidebar_story(story)
    html = "<div class='sidebar-story row'>"

    if image_exists? story.image_file_name
      html += "<div class='span1' style='width: 100px;'>"
    else
      html += "<div class='span'>"
    end

    if story.kind == Story::Rss
      html += link_to image_tag(favicon_url(story.source_url), :class => "favicon"), story.source_url
    else
      html += link_to gravatar_image_tag(story.user.email,
                :gravatar => { :size => 20 }, :class => "favicon"),
                story.user,
                :title => story.user.login
    end

    html += sidebar_story_image(story)
    html += "</div>"

    if image_exists? story.image_file_name
      html += "<div class='span2 sidebar-story-content'>"
    else
      html += "<div class='span3 sidebar-story-content'>"
    end

    html += link_to story.title, story
    html += "</div>"
    html += "</div>"
    html.html_safe
  end
end