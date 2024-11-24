class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
    @user_progress = @challenges.map do |challenge|
      {
        challenge: challenge,
        progress: challenge.progress_for_user(current_user)
      }
    end
  end
  
  def show
    @challenge = Challenge.find(params[:id])
    @progress = @challenge.progress_for_user(current_user)
  end
end
