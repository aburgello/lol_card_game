namespace :challenges do
  desc "Create challenges for each champion type, skin rarity, and region"
  task create_type_challenges: :environment do
    puts "Creating challenges for champion types, skin rarities, and regions..."

    # Create challenges for each champion type
    Type.find_each do |type|
      challenge_name = "Find all #{type.name.pluralize}"
      
      challenge = Challenge.find_or_initialize_by(name: challenge_name)
      
      if challenge.new_record?
        challenge.description = "Find all #{type.name.downcase} champions skins"
        challenge.progress_type = 'champion_specific'
        challenge.required_count = Skin.joins(:champion)
                                    .joins("INNER JOIN champion_types ON champions.id = champion_types.champion_id")
                                    .where(champion_types: { type_id: type.id })
                                    .count
        challenge.save!
    
        # Associate skins with the challenge
        skins = Skin.joins(:champion)
                    .joins("INNER JOIN champion_types ON champions.id = champion_types.champion_id")
                    .where(champion_types: { type_id: type.id })
    
        skins.each do |skin|
          challenge.skins << skin unless challenge.skins.include?(skin)
        end
    
        puts "Created challenge: #{challenge.name} with required count #{challenge.required_count} and associated skins."
      else
        puts "Challenge already exists: #{challenge.name}"
      end
    end

    puts "Creating challenges for set-based skins..."

    # Step 1: Remove champion names from the skins
    skins_with_cleaned_names = Skin.joins(:champion).map do |skin|
      cleaned_name = skin.name.sub(/#{skin.champion.name}\s*/, '')  # Remove champion name from skin name
      cleaned_name.strip  # Remove any extra spaces
    end
    
    # Step 2: Extract both single words and multi-word phrases
    word_pairs = skins_with_cleaned_names.flat_map do |name|
      words = name.downcase.split(/\s+/)  # Split into words using spaces as separators
      words + words.each_cons(2).map(&:join)  # This generates both single words and word pairs
    end
    
    # Step 3: Group and find the most common word pairs
    common_word_pairs = word_pairs
                          .group_by(&:itself)
                          .transform_values(&:count)
                          .select { |_, count| count >= 3 }
    
    # Step 4: Define special terms or phrases that should match exactly
    special_terms = ["iG", "T1", "Pool Party", "LCS", "Worlds", "Beast Hunter"]
    
    # Step 5: Create challenges for each set-based skin group
    common_word_pairs.each do |pair, count|
      challenge_name = "Collect all '#{pair.capitalize}' skins"
    
      challenge = Challenge.find_or_initialize_by(name: challenge_name)
    
      if challenge.new_record?
        # Adjust the query to match the pair as a whole word using PostgreSQL regex
        skins_in_set = Skin.where("LOWER(name) ~* ?", "\\m#{pair.downcase}\\M")
    
        puts "Found #{skins_in_set.count} skins for word pair '#{pair}'"
    
        if skins_in_set.count > 0
          challenge.description = "Find all skins from the set"
          challenge.progress_type = 'skin_set'
          challenge.required_count = skins_in_set.count
          challenge.save!
    
          # Associate skins with the challenge using the join table
          skins_in_set.each do |skin|
            challenge.skins << skin unless challenge.skins.include?(skin)
          end
    
          puts "Created challenge: #{challenge.name} with required count #{challenge.required_count}"
        else
          puts "No skins found for word pair '#{pair}'"
        end
      else
        puts "Challenge already exists: #{challenge.name}"
      end
    end
    
    puts "Set-based skin challenges creation completed!"
    
    # Create challenges for each skin rarity
    Skin.distinct.pluck(:rarity).each do |rarity|
      challenge_name = "Collect all #{rarity.capitalize} Skins"
      
      challenge = Challenge.find_or_initialize_by(name: challenge_name)
      
      if challenge.new_record?
        challenge.description = "Find all #{rarity.downcase} skins"
        challenge.progress_type = 'rarity_based'
        challenge.required_count = Skin.where(rarity: rarity).count
        challenge.save!
        
        # Associate skins with the challenge using the join table
        Skin.where(rarity: rarity).each do |skin|
          challenge.skins << skin unless challenge.skins.include?(skin)
        end
        
        puts "Created challenge: #{challenge.name} with required count #{challenge.required_count}"
      else
        puts "Challenge already exists: #{challenge.name}"
      end
    end

    puts "Creating challenges for champion regions..."

# Create challenges for each champion region
Champion.select(:region_id).distinct.each do |champion|
  next if champion.region_id.nil? # Skip if region_id is nil
  
  # Find the region based on the champion's region_id
  region = Region.find(champion.region_id) # Define the region variable here
  
  challenge_name = "Collect all #{region.name} Champions"
  
  challenge = Challenge.find_or_initialize_by(name: challenge_name)
  
  if challenge.new_record?
    challenge.description = "Find all champions from the #{region.name.downcase} region"
    challenge.progress_type = 'region_based'
    challenge.required_count = Champion.where(region_id: region.id).count
    challenge.save!
    
    # Associate skins with the challenge using the join table
    Champion.where(region_id: region.id).each do |champion|
      champion.skins.each do |skin|
        challenge.skins << skin unless challenge.skins.include?(skin)
      end
    end
    
    puts "Created challenge: #{challenge.name} with required count #{challenge.required_count}"
  else
    puts "Challenge already exists: #{challenge.name}"
  end
end

# Logic to unlock champions for users based on skins
Region.find_each do |region| # Iterate over each region
  Champion.where(region_id: region.id).each do |champion|
    User.find_each do |user| # Iterate over each user
      total_skins = champion.skins.count
      owned_skins = user.skins.where(champion_id: champion.id).count
      
      if owned_skins == total_skins
        # Unlock the champion for the user
        user.champions << champion unless user.champions.include?(champion)
        puts "Unlocked champion: #{champion.name} for user: #{user.id}"
      end
    end
  end
end

    puts "Type, rarity, and region challenges creation completed!"
  end
end