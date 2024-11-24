class Challenge < ApplicationRecord
  has_many :user_challenges
  has_many :users, through: :user_challenges
  
  def progress_for_user(user)
    case progress_type
    when 'skin_set'
      calculate_skin_set_progress(user)
    when 'champion_specific'
      calculate_champion_progress(user)
    when 'rarity_based'
      calculate_rarity_progress(user)
    else
      { current: 0, total: 0, percentage: 0 } # Default progress
    end
  end

  private

  def calculate_skin_set_progress(user)
    # Example logic for Arcane skin set
    if name.include?('Arcane')
      owned_arcane_skins = user.skins.where('name LIKE ?', '%Arcane%').count
      total_arcane_skins = Skin.where('name LIKE ?', '%Arcane%').count
      return {
        current: owned_arcane_skins,
        total: total_arcane_skins,
        percentage: (owned_arcane_skins.to_f / total_arcane_skins * 100).round
      }
    end
    { current: 0, total: 0, percentage: 0 } # Default when no relevant skins are found
  end

  def calculate_champion_progress(user)
    if name.start_with?('Find all')
      type_name = name.gsub('Find all ', '').singularize
      type = Type.find_by(name: type_name)
      return { current: 0, total: 0, percentage: 0 } unless type

      champions_of_type = type.champions
      owned_champions = champions_of_type.joins(:skins).where(skins: { id: user.skins.pluck(:id) }).distinct

      return {
        current: owned_champions.count,
        total: champions_of_type.count,
        percentage: (owned_champions.count.to_f / champions_of_type.count * 100).round
      }
    end
    { current: 0, total: 0, percentage: 0 } # Default when no relevant champions are found
  end

  def calculate_rarity_progress(user)
    # Logic for rarity-based progress (if applicable)
    { current: 0, total: 0, percentage: 0 } # Placeholder logic
  end
end
