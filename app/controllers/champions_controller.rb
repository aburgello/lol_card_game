class ChampionsController < ApplicationController
  before_action :set_champion, only: [ :show ]

  def index
    @regions = Region.order(:name)
    @champions = Champion.order(:name)

    if params[:region_id].present?
      @champions = @champions.where(region_id: params[:region_id])
    end

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @champions = @champions.where("LOWER(name) LIKE LOWER(?) OR LOWER(title) LIKE LOWER(?)",
                                  search_term, search_term)
    end

    respond_to do |format|
      format.html
      format.js { render partial: "champions/champion_grid", locals: { champions: @champions } }
    end
  end

  def show
    puts "Champion: #{@champion.name}"
    @user_skin_ids = current_user&.skins&.pluck(:id) || []
  end

  def redirect_skin
    skin = Skin.find_by(name: params[:skin_name])

    if skin
      redirect_to champion_path(skin.champion.name)
    else
      flash[:alert] = "Skin not found"
      redirect_to champions_path
    end
  end

  private

  def set_champion
    puts "params[:name]: #{params[:name]}"

    @champion = Champion.includes(:abilities, :skins).find_by(name: params[:name])

    if @champion.nil?
      flash[:alert] = "Champion not found"
      redirect_to champions_path
    end
  end
end
