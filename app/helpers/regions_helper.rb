module RegionsHelper
  def calculate_region_progress(user, name)
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
end
