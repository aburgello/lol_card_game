class ChampionsController < ApplicationController
  before_action :set_champion, only: [ :show ]

  def index
    @champions = Champion.order(:name)
  end



  def show
    # @champion will be loaded with associated abilities and skins
  end

  private

  def set_champion
    @champion = Champion.includes(:abilities, :skins).find(params[:id])
  end
end
