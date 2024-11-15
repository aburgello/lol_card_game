require "open-uri"
require "json"
require "httparty"

class RiotApi
  API_KEY = ENV["RIOT_API_KEY"]
  BASE_URL = "https://ddragon.leagueoflegends.com/cdn/14.22.1/data/en_US/champion.json"

  # Fetch the current version for Riot's assets
  def self.fetch_version
    url = "https://ddragon.leagueoflegends.com/realms/na.json"
    response = HTTParty.get(url)
    if response.success?
      data = response.parsed_response
      data["n"]["champion"]
    else
      raise "Failed to fetch version"
    end
  end

  # Fetch champions from the Riot API and seed them into your database
  def self.fetch_champions
    # Fetch the list of champions
    url = "https://ddragon.leagueoflegends.com/cdn/14.22.1/data/en_US/champion.json"
    response = HTTParty.get(url)
    if response.success?
      champions = response.parsed_response["data"]

      champions.each do |name, details|
        champion = Champion.find_or_create_by(name: name) do |champion|
          champion.title = details["title"]
          # We now fetch lore from the detailed champion JSON
          champion.lore = fetch_lore_for_champion(name)
          # Set the splash and square art images correctly using the champion's name
          champion.splash_art = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{name}_0.jpg"
          champion.square_art = "https://ddragon.leagueoflegends.com/cdn/14.22.1/img/champion/#{name}.png"

          # Set passive ability information if present
          if details["passive"]
            champion.passive_name = details["passive"]["name"]
            champion.passive_description = details["passive"]["description"]
            champion.passive_image = "https://ddragon.leagueoflegends.com/cdn/14.22.1/img/passive/#{details['passive']['image']['full']}"
          end
        end

        # Now fetch the detailed data for each champion (abilities, skins, etc.)
        fetch_detailed_data_for_champion(champion, name)
      end
    else
      raise "Failed to fetch champions"
    end
  end

  # Fetch detailed data (abilities, skins) for each champion
  def self.fetch_detailed_data_for_champion(champion, name)
    # Fetch the detailed champion data
    url = "https://ddragon.leagueoflegends.com/cdn/14.22.1/data/en_US/champion/#{name}.json"
    response = HTTParty.get(url)

    if response.success?
      champion_data = response.parsed_response["data"][name]

      # Fetch abilities for the champion
      fetch_abilities_for_champion(champion, champion_data)

      # Fetch skins for the champion
      fetch_skins_for_champion(champion, champion_data)
    else
      Rails.logger.warn "Failed to fetch detailed data for champion: #{name}"
    end
  end

  # Fetch the lore for a champion from the detailed JSON
  def self.fetch_lore_for_champion(name)
    url = "https://ddragon.leagueoflegends.com/cdn/14.22.1/data/en_US/champion/#{name}.json"
    response = HTTParty.get(url)

    if response.success?
      champion_data = response.parsed_response["data"][name]
      champion_data["lore"] # Return the lore from the detailed champion data
    else
      Rails.logger.warn "Failed to fetch lore for champion: #{name}"
      nil
    end
  end

  # Fetch abilities for a champion and save them
  def self.fetch_abilities_for_champion(champion, champion_data)
    if champion_data["spells"].present?
      champion_data["spells"].each do |spell|
        Rails.logger.info "Creating ability for spell: #{spell['name']}"

        Ability.create(
          champion: champion,
          name: spell["name"],
          description: spell["description"],
          image: "https://ddragon.leagueoflegends.com/cdn/14.22.1/img/spell/#{spell['id']}.png",
          ability_type: spell["key"]
        )
      end
    else
      Rails.logger.warn "No spells found for champion #{champion.name}"
    end

    # Process the champion's passive ability
    if champion_data["passive"].present?
      Rails.logger.info "Creating passive ability for champion: #{champion.name}"

      Ability.create(
        champion: champion,
        name: champion_data["passive"]["name"],
        description: champion_data["passive"]["description"],
        image: "https://ddragon.leagueoflegends.com/cdn/14.22.1/img/passive/#{champion_data['passive']['image']['full']}",
        ability_type: "Passive"
      )
    else
      Rails.logger.warn "No passive abilities found for champion #{champion.name}"
    end
  end

  # Fetch skins for a champion and save them
  def self.fetch_skins_for_champion(champion, champion_data)
    if champion_data["skins"].present?
      champion_data["skins"].each do |skin|
        Rails.logger.info "Creating skin for #{skin['name']}"

        Skin.create(
          champion: champion,
          name: skin["name"],
          num: skin["num"],
          splash_art: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{champion.name}_#{skin['num']}.jpg",
          loading_art: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/#{champion.name}_#{skin['num']}.jpg"
        )
      end
    else
      Rails.logger.warn "No skins found for champion #{champion.name}"
    end
  end
end
