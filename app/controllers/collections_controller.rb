class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_skins = current_user.skins.includes(champion: :region)
    @user_regions = current_user.user_regions.includes(:region)

  end
end