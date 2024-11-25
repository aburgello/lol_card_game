class Challenge < ApplicationRecord
  has_many :user_challenges
  has_many :users, through: :user_challenges
  has_and_belongs_to_many :skins
  belongs_to :region

  enum progress_type: {
    skin_set: 'skin_set',
    champion_specific: 'champion_specific',
    rarity_based: 'rarity_based',
    region_based: 'region_based'  # Add region_based to the enum
  }
  
  def progress_for_user(user)
    case progress_type
    when 'skin_set'
      calculate_skin_set_progress(user)
    when 'champion_specific'
      calculate_champion_progress(user)
    when 'rarity_based'
      calculate_rarity_progress(user)
    when 'region_based'  # Handle region-based progress
      calculate_region_progress(user)
    end
  end
  
  private

  
  def calculate_rarity_progress(user)
    match = name.match(/Collect all (\w+) Skins/)
    
    if match
      rarity = match[1]
      Rails.logger.debug "Rarity: #{rarity}, Querying skins with rarity: #{rarity}"
      
      owned_skins = user.skins.where(rarity: rarity).count
      total_skins = Skin.where(rarity: rarity).count
  
      Rails.logger.debug "Owned skins: #{owned_skins}, Total skins: #{total_skins}"
  
      {
        current: owned_skins,
        total: total_skins,
        percentage: total_skins.zero? ? 0 : (owned_skins.to_f / total_skins * 100).round
      }
    else
      Rails.logger.warn "Challenge name format is incorrect for challenge: #{name}"
      return { current: 0, total: 0, percentage: 0 }
    end
  end
  
  def calculate_region_progress(user)
    # Extract region name from challenge name
    region_name = name.match(/Collect all (.+) Champions/)[1]
    Rails.logger.debug "Calculating progress for region: #{region_name}"
    
    # Find the region
    region = Region.find_by(name: region_name)
    return { current: 0, total: 0, percentage: 0 } unless region
    
    # Get all champions from this region with their skins preloaded
    champions_with_skins = Champion.includes(:skins)
                                 .where(region_id: region.id)
    
    total_champions = champions_with_skins.count
    return { current: 0, total: 0, percentage: 0 } if total_champions.zero?
    
    # Get all user's owned skins for this region's champions in one query
    owned_skins_by_champion = user.skins
                                 .joins(:champion)
                                 .where(champions: { region_id: region.id })
                                 .group(:champion_id)
                                 .count
    
    # Get total skins required for each champion
    required_skins_by_champion = Skin.joins(:champion)
                                   .where(champions: { region_id: region.id })
                                   .group(:champion_id)
                                   .count
    
    # Count completed champions
    completed_champions = 0
    
    required_skins_by_champion.each do |champion_id, required_count|
      owned_count = owned_skins_by_champion[champion_id] || 0
      if owned_count == required_count
        completed_champions += 1
        Rails.logger.debug "Champion #{champion_id} completed: #{owned_count}/#{required_count} skins"
      else
        Rails.logger.debug "Champion #{champion_id} progress: #{owned_count}/#{required_count} skins"
      end
    end
    
    percentage = (completed_champions.to_f / total_champions * 100).round
    
    Rails.logger.info "Region #{region_name} progress: " \
                     "#{completed_champions}/#{total_champions} champions completed (#{percentage}%)"
    
    {
      current: completed_champions,
      total: total_champions,
      percentage: percentage,
      details: {
        region_name: region_name,
        owned_skins: owned_skins_by_champion,
        required_skins: required_skins_by_champion
      }
    }
  end

  def calculate_skin_set_progress(user)
    match = name.match(/Collect all '([^']+)' skins/)
    
    if match
      set_word = match[1]
      Rails.logger.debug "Calculating progress for skin set: #{set_word}"
      
      skins_in_set = self.skins
      owned_skins = user.skins.where(id: skins_in_set.pluck(:id)).count
      total_skins = skins_in_set.count
  
      Rails.logger.debug "Skin set progress: #{owned_skins}/#{total_skins} skins owned"
  
      {
        current: owned_skins,
        total: total_skins,
        percentage: total_skins.zero? ? 0 : (owned_skins.to_f / total_skins * 100).round
      }
    else
      Rails.logger.warn "Invalid challenge name format: #{name}"
      { current: 0, total: 0, percentage: 0 }
    end
  end
  
  def calculate_champion_progress(user)
    type_name = name.match(/Find all (\w+)/)[1].singularize
    type = Type.find_by(name: type_name)
    
    return { current: 0, total: 0, percentage: 0 } unless type
    
    # Get all champions of this type
    champions = Champion.joins(:types).where(types: { id: type.id })
    
    # Get all skins for these champions
    total_skins = Skin.joins(:champion)
                     .where(champions: { id: champions.pluck(:id) })
                     .count
    
    # Get user's owned skins for these champions
    owned_skins = user.skins
                     .joins(:champion)
                     .where(champions: { id: champions.pluck(:id) })
                     .count
    
    Rails.logger.debug "Champion type #{type_name} progress: #{owned_skins}/#{total_skins} skins owned"
    
    {
      current: owned_skins,
      total: total_skins,
      percentage: total_skins.zero? ? 0 : (owned_skins.to_f / total_skins * 100).round
    }
  end
end