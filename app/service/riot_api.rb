require 'open-uri'
require 'json'
require 'httparty'
require 'faraday'
class RiotApi
  CHAMPION_SUMMARY_URL = 'https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/v1/champion-summary.json'
  CHAMPION_DETAILS_URL = "https://cdn.communitydragon.org/latest/champion/%{champion_id}/data"

  def self.map_asset_path(asset_path)
    if asset_path.starts_with?('/lol-game-data/assets/')
      path = asset_path.sub('/lol-game-data/assets/', '').downcase
      "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/#{path}"
    else
      asset_path
    end
  end

  def self.fetch_champions
    response = Faraday.get(CHAMPION_SUMMARY_URL)
  
    if response.status == 200
      champions_data = JSON.parse(response.body) rescue nil
      return if champions_data.nil? || champions_data.empty?
    else
      puts "Error: Failed to fetch champions data. HTTP Status: #{response.status}"
      return
    end
  
    champions_data.each do |champion_data|
      next if champion_data['id'] == -1
  
      # Fetch champion details for additional data
      champion_details = fetch_champion_details(champion_data['id'])
  
      # Find or initialize the champion
      champion = Champion.find_or_initialize_by(id: champion_data['id'])
  
      # Update champion attributes
      champion.name = champion_data['name']
      champion.title = champion_details['title'].presence || 'Untitled'
      champion.lore = champion_details['shortBio']
      champion.splash_art = "https://cdn.communitydragon.org/latest/champion/#{champion.id}/splash-art"
  
      # Handle assets
      if champion_data['squarePortraitPath']
        champion.square_art = map_asset_path(champion_data['squarePortraitPath'])
      end
  
      if champion_data.dig('passive', 'abilityIconPath')
        champion.passive_image = map_asset_path(champion_data['passive']['abilityIconPath'])
      end
  
      # Save champion and log the status
      if champion.save
        puts "#{champion.new_record? ? 'Created' : 'Updated'} champion: #{champion.name}"
        
        # Seed additional related data (skins, abilities, types)
        create_skins(champion, champion_details['skins']) if champion_details['skins'].present?
        create_abilities(champion, champion_details['spells'], champion_details['passive']) if champion_details['spells'].present? || champion_details['passive'].present?
        create_types(champion, champion_data['roles']) if champion_data['roles'].present?
      else
        puts "Failed to save champion #{champion.name}: #{champion.errors.full_messages.join(', ')}"
      end
    end
  end
  

  def self.fetch_champion_details(champion_id)
    url = CHAMPION_DETAILS_URL % { champion_id: champion_id }
    begin
      JSON.parse(URI.open(url).read)
    rescue OpenURI::HTTPError => e
      puts "Error fetching details for champion #{champion_id}: #{e.message}"
      nil
    end
  end

  def self.create_skins(champion, skins)
    skins.each do |skin|
      # Remove the 'k' prefix from the rarity value if it exists and check for 'kNoRarity'
      rarity_name = skin['rarity'].sub(/^k/, '').capitalize
      rarity_name = "Base" if rarity_name == "NoRarity"  # Replace "NoRarity" with "Base"
  
      # Find or create the skin record
      skin_record = Skin.find_or_create_by(id: skin['id'], champion_id: champion.id) do |skin_record|
        skin_record.name = skin['name']
        skin_record.num = skin['num']
        skin_record.splash_art = map_asset_path(skin['uncenteredSplashPath'])
        skin_record.splash_art_centered = map_asset_path(skin['splashPath'])
        skin_record.loading_art = map_asset_path(skin['loadScreenPath'])
        skin_record.is_base = skin['isBase']
        skin_record.description = skin['description']
        skin_record.rarity = rarity_name # Assign the cleaned-up rarity
        skin_record.is_legacy = skin['isLegacy'] # Legacy flag
      end
  
      # Print info about the skin being seeded, including its rarity and legacy status
      puts "Skin seeded: #{skin_record.name} (Rarity: #{skin_record.rarity}, Legacy: #{skin_record.is_legacy})"
      skin_record.save! # Explicitly save after creation
    end
  end
  
  
  

  def self.create_abilities(champion, spells, passive)
    spells.each do |spell|
      ability_record = Ability.find_or_create_by(champion_id: champion.id, name: spell['name']) do |ability|
        ability.name = spell['name']
        ability.image = map_asset_path(spell['abilityIconPath'])
        ability.description = spell['description']
      end

      if ability_record.errors.any?
        puts "Error saving ability for #{champion.name}: #{ability_record.errors.full_messages.join(', ')}"
      end
      ability_record.save!
      puts "Ability seeded: #{ability_record.name} for #{champion.name}"
    end

    if passive
      ability_record = Ability.find_or_create_by(champion_id: champion.id, name: passive['name']) do |ability|
        ability.name = passive['name']
        ability.image = map_asset_path(passive['abilityIconPath'])
        ability.description = passive['description']
      end

      if ability_record.errors.any?
        puts "Error saving passive for #{champion.name}: #{ability_record.errors.full_messages.join(', ')}"
      end
      ability_record.save!
      puts "Passive ability seeded: #{ability_record.name} for #{champion.name}"
    end
  end

  def self.create_types(champion, roles)
    roles.each do |role|
      # Capitalize the first letter of the role
      capitalized_role = role.capitalize
  
      # Find or create a Type based on the capitalized role
      type = Type.find_or_create_by(name: capitalized_role)
      
      # Create a ChampionType association
      ChampionType.find_or_create_by(champion_id: champion.id, type_id: type.id)
      
      puts "Type seeded: #{capitalized_role} for #{champion.name}"
    end
  end
  
end

 