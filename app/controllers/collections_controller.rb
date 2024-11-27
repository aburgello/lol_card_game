class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @champions = Champion.pluck(:name)
    @regions = Region.pluck(:name)
    
    # Start with the user's skins
    @user_skins = current_user.skins.includes(champion: :region)

    # Apply filters
    if params[:champion].present?
      @user_skins = @user_skins.where(champions: { name: params[:champion] })
    end

    if params[:region].present?
      @user_skins = @user_skins.joins(champion: :region).where(regions: { name: params[:region] })
    end

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @user_skins = @user_skins.where("LOWER(skins.name) LIKE LOWER(?)", search_term)
    end

    respond_to do |format|
      format.html
      format.js { render partial: 'collections/skins_grid', locals: { user_skins: @user_skins }, layout: false }
    end
  end
end