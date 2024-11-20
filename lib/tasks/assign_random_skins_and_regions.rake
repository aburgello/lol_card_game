namespace :assign do
  desc "Assign 5 random skins and regions to user with ID 5"
  task skins_and_regions: :environment do
    user_id = 5

    # Get 5 random skins
    random_skins = Skin.order('RANDOM()').limit(35).pluck(:id)

    # Get 5 random regions
    random_regions = Region.order('RANDOM()').limit(35).pluck(:id)

    # Assign skins to the user
    random_skins.each do |skin_id|
      UserSkin.create(user_id: user_id, skin_id: skin_id, unlocked_at: Time.current)
    end

    # Assign regions to the user
    random_regions.each do |region_id|
      UserRegion.create(user_id: user_id, region_id: region_id, discovered_at: Time.current)
    end

    puts "Assigned 5 random skins and regions to user with ID #{user_id}."
  end
end