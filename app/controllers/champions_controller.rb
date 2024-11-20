class ChampionsController < ApplicationController
  before_action :set_champion, only: [ :show ]

  def index
    @regions = Region.order(:name)
    @champions = Champion.order(:name)

    if params[:region_id].present?
      @champions = @champions.where(region_id: params[:region_id])
    end
  end



  def show
    # @champion will be loaded with associated abilities and skins
  end

  private

  def set_champion
    @champion = Champion.includes(:abilities, :skins).find(params[:id])
  end
end
