class UserSkinsController < ApplicationController
  before_action :authenticate_user!

  def create
    skin = Skin.find(params[:skin_id])

    if current_user.skins.include?(skin)
      flash[:notice] = "You already own this skin!"
    else
      current_user.skins << skin
      flash[:success] = "#{skin.name} unlocked!"
    end

    redirect_to skins_path
  end
end
