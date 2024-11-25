class ChallengesController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = (params[:page] || 1).to_i
    @per_page = 7
    @section = params[:section]

    @challenges = Challenge.includes(:region).all
    all_progress = calculate_all_progress(@challenges)
    
    # Split progress by type
    @user_progress = {
      rarity: paginate_progress(all_progress.select { |p| p[:challenge].progress_type == 'rarity_based' }),
      region: paginate_progress(all_progress.select { |p| p[:challenge].progress_type == 'region_based' }),
      type: paginate_progress(all_progress.select { |p| p[:challenge].progress_type == 'champion_specific' }),
      set: paginate_progress(all_progress.select { |p| ['set_based', 'skin_set'].include?(p[:challenge].progress_type) })
    }

    # If it's a Turbo Frame request, render only the specific section
    if turbo_frame_request? && @section.present?
      render partial: 'challenge_section', locals: {
        challenges: @user_progress[@section.to_sym][:items],
        title: "#{@section.titleize} Challenges",
        section_id: @section,
        current_page: @page,
        total_pages: @user_progress[@section.to_sym][:total_pages]
      }
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @progress = @challenge.progress_for_user(current_user)
    @skins = @challenge.skins
    @user_skin_ids = current_user.skins.pluck(:id)
  end

  private

  def calculate_all_progress(challenges)
    challenges.map do |challenge|
      progress = challenge.progress_for_user(current_user)

      
      if progress
        {
          challenge: challenge,
          progress: {
            current: progress[:current],
            total: challenge.required_count || progress[:total],
            percentage: progress[:percentage]
          }
        }
      else
        {
          challenge: challenge,
          progress: {
            current: 0,
            total: challenge.required_count || 0,
            percentage: 0
          }
        }
      end
    end
  end

  def paginate_progress(progress_array)
    sorted_progress = progress_array.sort_by { |p| -p[:progress][:percentage] }
    total_pages = (sorted_progress.length.to_f / @per_page).ceil
    
    {
      items: sorted_progress.slice((@page - 1) * @per_page, @per_page) || [],
      total_pages: total_pages,
      total_items: sorted_progress.length
    }
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You need to sign in first."
    end
  end
end