class ChallengesController < ApplicationController
  before_action :authenticate_user!

  def index
    @challenges = Challenge.includes(:region).all 
    @user_progress = @challenges.map do |challenge| 
      progress = challenge.progress_for_user(current_user)
      
      # Logging for debugging
      Rails.logger.debug "Challenge: #{challenge.name}"
      Rails.logger.debug "Progress: #{progress.inspect}"
      Rails.logger.debug "Required count: #{challenge.required_count}"
      
      # Check if progress is nil and set default values if necessary
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
        # Handle the case when progress is nil
        {
          challenge: challenge,
          progress: {
            current: 0,   # default to 0 if progress is nil
            total: challenge.required_count || 0, # default to 0 if no required_count
            percentage: 0  # default to 0 if progress is nil
          }
        }
      end
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @progress = @challenge.progress_for_user(current_user)
    @skins = @challenge.skins # Assuming the challenge has many skins
    @user_skin_ids = current_user.skins.pluck(:id) # Assuming you have a current_user method
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You need to sign in first."
    end
  end
end
