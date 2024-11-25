# app/helpers/challenges_helper.rb
module ChallengesHelper
  def link_to_prev_page(challenges, section_id, current_page, total_pages, html_options = {})
    return if current_page == 1
    
    link_to challenges_path(page: current_page - 1, section: section_id),
            html_options.merge(data: { turbo_frame: "#{section_id}_challenges" }) do
      content_tag(:span, class: 'flex items-center') do
        "← Previous".html_safe
      end
    end
  end

  def link_to_next_page(challenges, section_id, current_page, total_pages, html_options = {})
    return if current_page == total_pages
    
    link_to challenges_path(page: current_page + 1, section: section_id),
            html_options.merge(data: { turbo_frame: "#{section_id}_challenges" }) do
      content_tag(:span, class: 'flex items-center') do
        "Next →".html_safe
      end
    end
  end
end