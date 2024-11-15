# db/seeds.rb

# Clear existing data
Champion.destroy_all
Ability.destroy_all
Skin.destroy_all

# Fetch and seed champions
RiotApi.fetch_champions

puts "Successfully seeded champions, abilities, and skins!"
