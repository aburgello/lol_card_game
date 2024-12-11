
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
