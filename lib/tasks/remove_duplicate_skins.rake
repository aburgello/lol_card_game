
namespace :skins do
  desc "Remove skins where the name matches the champion's name"
  task remove_default_skins: :environment do
    puts "Starting removal of default skins..."

    Skin.joins(:champion).where('skins.name = champions.name').find_each do |skin|
      puts "Removing Skin ##{skin.id}: #{skin.name} (Champion: #{skin.champion.name})"
      skin.destroy
    end

    puts "Removal complete!"
  end
end
