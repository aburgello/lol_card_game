class SkinsController < ApplicationController
  def index
    # Show the user's last 5 unlocked skins (sorted by created_at)
    @skins = current_user.skins.order('user_skins.created_at DESC').limit(5)
  end

  def add_skins
    # Fetch 5 random skins
    @skins = Skin.order('RANDOM()').limit(5)  # Fetches 5 random skins

    # Add the skins to the current user's collection
    @skins.each do |skin|
      # Only add skin if the user doesn't already have it
      unless current_user.skins.exists?(skin.id)
        current_user.skins << skin
      end
    end

    respond_to do |format|
      format.html { redirect_to skins_path }  # Redirect to index after adding
      format.turbo_stream  # This will update the skins grid dynamically
    end
  end
end
