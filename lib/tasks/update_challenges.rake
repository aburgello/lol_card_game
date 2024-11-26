namespace :challenges do
  desc "Update challenges with newly added skins"
  task update_challenges: :environment do
    puts "Updating existing challenges with new skins..."

    # Step 1: Loop through all challenges
    Challenge.find_each do |challenge|
      new_skins = nil # Initialize to avoid referencing old data

      # Step 2: Determine the relevant skins based on the challenge type
      case challenge.progress_type
      when 'champion_specific'
        type_name = challenge.name.match(/Find all (.+)/)[1].singularize
        type = Type.find_by(name: type_name)

        if type
          new_skins = Skin.joins(:champion)
                          .joins("INNER JOIN champion_types ON champions.id = champion_types.champion_id")
                          .where(champion_types: { type_id: type.id })
                          .where.not(id: challenge.skins.pluck(:id))
        end
      when 'skin_set'
        # For set-based challenges
        set_name = challenge.name.match(/Collect all '(.+)' skins/)[1]
        new_skins = Skin.where("LOWER(name) ~* ?", "\\m#{set_name.downcase}\\M")
                        .where.not(id: challenge.skins.pluck(:id))
      when 'rarity_based'
        rarity = challenge.name.match(/Collect all (.+) Skins/)[1].downcase
        new_skins = Skin.where('LOWER(rarity) = ?', rarity).where.not(id: challenge.skins.pluck(:id))

        if new_skins.any?
          challenge.skins << new_skins
          challenge.required_count = challenge.skins.count
          challenge.save!
          puts "Updated challenge: #{challenge.name} with #{new_skins.count} new skins. Total now: #{challenge.required_count}."
        else
          puts "No new skins for rarity challenge: #{challenge.name}"
        end

        next # Skip the general logic for `rarity_based` challenges
      when 'region_based'
        # For region-based challenges
        region_name = challenge.name.match(/Collect all (.+) Champions/)[1]
        region = Region.find_by(name: region_name)

        if region
          new_skins = Skin.joins(:champion)
                          .where(champions: { region_id: region.id })
                          .where.not(id: challenge.skins.pluck(:id))
        end
      else
        puts "Unknown progress_type for challenge: #{challenge.name}"
        next
      end

      # Step 3: Add new skins to the challenge
      if new_skins && new_skins.any?
        challenge.skins << new_skins
        challenge.required_count = challenge.skins.count
        challenge.save!
        puts "Updated challenge: #{challenge.name} with #{new_skins.count} new skins. Total now: #{challenge.required_count}."
      else
        puts "No new skins for challenge: #{challenge.name}"
      end
    end

    puts "Challenges update completed!"
    # Step 2: Refresh rarity-based challenges
    puts "Refreshing rarity-based challenges..."
    Challenge.where(progress_type: 'rarity_based').find_each do |rarity_challenge|
      rarity = rarity_challenge.name.match(/Collect all (.+) Skins/)[1].downcase

      # Get all skins with the given rarity
      skins_with_rarity = Skin.where('LOWER(rarity) = ?', rarity)

      # Reassign skins for the challenge
      rarity_challenge.skins = skins_with_rarity

      # Update the required_count to the exact number of skins
      rarity_challenge.required_count = skins_with_rarity.count
      rarity_challenge.save!

      puts "Refreshed rarity challenge: #{rarity_challenge.name} with total skins: #{rarity_challenge.required_count}."
    end

    puts "Challenges update completed!"
  end
end