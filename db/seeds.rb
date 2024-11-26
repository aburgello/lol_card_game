
RiotApi.fetch_champions


# Regions
champion_region_map = {
  "Bandle City" => %w[Corki Lulu Rumble Teemo Tristana Veigar Yuumi],
  "Bilgewater" => %w[Fizz Gangplank Graves Illaoi Miss\ Fortune Nautilus Pyke Tahm\ Kench Twisted\ Fate],
  "Demacia" => %w[Fiora Galio Garen Jarvan\ IV Kayle Lucian Lux Morgana Poppy Quinn Shyvana Sona Sylas Vayne Xin\ Zhao],
  "Ionia" => %w[Ahri Akali Irelia Ivern Jhin Karma Kayn Kennen Lee\ Sin Lillia Master\ Yi Wukong Rakan Sett Shen Syndra Varus Xayah Yasuo Yone Zed],
  "Ixtal" => %w[Malphite Milio Neeko Nidalee Qiyana Rengar Skarner Zyra],
  "Noxus" => %w[Ambessa Briar Cassiopeia Darius Draven Katarina Kled LeBlanc Mordekaiser Rell Riven Samira Sion Swain Talon Vladimir],
  "Piltover" => %w[Caitlyn Camille Ezreal Heimerdinger Jayce Orianna Seraphine Vi],
  "Shadow Isles" => %w[Elise Gwen Hecarim Kalista Karthus Maokai Thresh Vex Viego Yorick],
  "Zaun" => %w[Blitzcrank Dr.\ Mundo Ekko Janna Jinx Renata\ Glasc Singed Twitch Urgot Viktor Warwick Zac Ziggs Zeri],
  "Shurima" => %w[Akshan Amumu Azir K'Sante Naafiri Nasus Rammus Renekton Sivir Taliyah Xerath Shaco],
  "The Void" => %w[Bel'Veth Cho'Gath Kai'Sa Kassadin Kha'Zix Kog'Maw Malzahar Rek'Sai Vel'Koz],
  "Targon" => %w[Aphelios Aurelion\ Sol Diana Leona Pantheon Soraka Taric Zoe],
  "Freljord" => %w[Anivia Ashe Aurora Braum Gnar Gragas Lissandra Nunu\ &\ Willump Olaf Ornn Sejuani Trundle Tryndamere Udyr Volibear],
  "Runeterra" => %w[Aatrox Alistar Annie Bard Brand Evelynn Fiddlesticks Jax Kindred Nami Nilah Nocturne Ryze]
}

champion_region_map.each do |region_name, champion_names|
  region = Region.find_or_create_by(name: region_name)

  champion_names.each do |champion_name|
    champion = Champion.find_or_initialize_by(name: champion_name)
    champion.region = region
    champion.save!
    puts "Associated #{champion.name} with region #{region.name}"
  end
end

puts "Seeding complete!"


puts "Successfully associated champions with regions!"

=begin Skin.create(
  id: 147002,
  champion_id: 147, # Use the appropriate champion ID
  name: "K/DA ALL OUT Seraphine Rising Star",
  description: "Seraphine's life is changing faster than she ever expected, and she's trying to hold on to her unique voice, keep up with Kai'Sa's intimidatingly sharp choreography, and still somehow manage to get enough sleep.",
  splash_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/images/seraphine_splash_centered_2.jpg",
  loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/seraphineloadscreen_2.jpg",
  is_base: false,
  rarity: "Ultimate",
  is_legacy: false,
  splash_art_centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/images/seraphine_splash_centered_2.jpg"
)

Skin.create(
  id: 147003,
  champion_id: 147, # Use the appropriate champion ID
  name: "K/DA ALL OUT Seraphine Superstar",
  description: "After her whirlwind rise to stardom, Seraphine is on top of the world, and the charts, with her feature on K/DA's new EP. Her music and her message are resonating with her fans, and she's excited to show them what's to come on her journey of self-discovery through music.",
  splash_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/images/seraphine_splash_centered_3.jpg",
  loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/seraphineloadscreen_3.jpg",
  is_base: false,
  rarity: "Ultimate",
  is_legacy: false,
  splash_art_centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/images/seraphine_splash_centered_3.jpg"
) =end