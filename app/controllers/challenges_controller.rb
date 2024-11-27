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
  
    # Check if the challenge is completed
    if @progress[:percentage] == 100 && !challenge_completed?
      award_hextech_cores
      mark_challenge_completed
    end
  end
  
  private
  
  def challenge_completed?
    # Check if the challenge has already been completed by the user
    UserChallenge.exists?(user: current_user, challenge: @challenge, completed: true)
  end

  def mark_challenge_completed
    # Find or create the user's challenge record
    user_challenge = UserChallenge.find_or_create_by(user: current_user, challenge: @challenge)
    
    # Update the challenge completion status
    user_challenge.update(completed: true, completed_at: Time.current)
    
    flash[:notice] = "Challenge completed!"
  end

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

  def award_hextech_cores
    # Award Hextech Cores before marking the challenge as completed
    current_user.update(hextech_cores: current_user.hextech_cores + 1000) # Adjust the award value as necessary
    flash[:notice] = "You've earned a Hextech Core!"
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You need to sign in first."
    end
  end
end
