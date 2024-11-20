class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_skins = current_user.skins.includes(champion: :region)
  end
end