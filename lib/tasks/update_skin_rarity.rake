
namespace :skins do
  desc "Update NoRarity to Common for all Champion skins"
  task update_rarity: :environment do
    puts "Starting update of skin rarities..."
    
    Skin.where(rarity: 'Norarity').find_each do |skin|
      skin.update(rarity: 'Common')
      puts "Updated Skin ##{skin.id}: #{skin.name} to rarity 'Common'"
    end
    
    puts "Update complete!"
  end
end
