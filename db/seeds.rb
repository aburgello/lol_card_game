ChampionType.destroy_all
Type.destroy_all
Ability.destroy_all
Skin.destroy_all
Champion.destroy_all
RiotApi.fetch_champions

# Create or find regions
regions = [
  "Bandle City", "Bilgewater", "Demacia", "Ionia", "Ixtal", "Noxus",
  "Piltover", "Shadow Isles", "Shurima", "Targon", "Freljord",
  "The Void", "Zaun", "Runeterra"
].map { |name| Region.find_or_create_by(name: name) }

# Create a hash mapping champions to regions
champion_region_map = {
  # Bandle City
  "Corki" => "Bandle City",
  "Lulu" => "Bandle City",
  "Rumble" => "Bandle City",
  "Teemo" => "Bandle City",
  "Tristana" => "Bandle City",
  "Veigar" => "Bandle City",
  "Yuumi" => "Bandle City",

  # Bilgewater
  "Fizz" => "Bilgewater",
  "Gangplank" => "Bilgewater",
  "Graves" => "Bilgewater",
  "Illaoi" => "Bilgewater",
  "Miss Fortune" => "Bilgewater",
  "Nautilus" => "Bilgewater",
  "Pyke" => "Bilgewater",
  "Tahm Kench" => "Bilgewater",
  "Twisted Fate" => "Bilgewater",

  # Demacia
  "Fiora" => "Demacia",
  "Galio" => "Demacia",
  "Garen" => "Demacia",
  "Jarvan IV" => "Demacia",
  "Kayle" => "Demacia",
  "Lucian" => "Demacia",
  "Lux" => "Demacia",
  "Morgana" => "Demacia",
  "Poppy" => "Demacia",
  "Quinn" => "Demacia",
  "Shyvana" => "Demacia",
  "Sona" => "Demacia",
  "Sylas" => "Demacia",
  "Vayne" => "Demacia",
  "Xin Zhao" => "Demacia",

  # Ionia
  "Ahri" => "Ionia",
  "Akali" => "Ionia",
  "Irelia" => "Ionia",
  "Ivern" => "Ionia",
  "Jhin" => "Ionia",
  "Karma" => "Ionia",
  "Kayn" => "Ionia",
  "Kennen" => "Ionia",
  "Lee Sin" => "Ionia",
  "Lillia" => "Ionia",
  "Master Yi" => "Ionia",
  "Wukong" => "Ionia",
  "Rakan" => "Ionia",
  "Sett" => "Ionia",
  "Shen" => "Ionia",
  "Syndra" => "Ionia",
  "Varus" => "Ionia",
  "Xayah" => "Ionia",
  "Yasuo" => "Ionia",
  "Yone" => "Ionia",
  "Zed" => "Ionia",

  # Ixtal
  "Malphite" => "Ixtal",
  "Milio" => "Ixtal",
  "Neeko" => "Ixtal",
  "Nidalee" => "Ixtal",
  "Qiyana" => "Ixtal",
  "Rengar" => "Ixtal",
  "Skarner" => "Ixtal",
  "Zyra" => "Ixtal",

  # Noxus
  "Ambessa" => "Noxus",
  "Briar" => "Noxus",
  "Cassiopeia" => "Noxus",
  "Darius" => "Noxus",
  "Draven" => "Noxus",
  "Katarina" => "Noxus",
  "Kled" => "Noxus",
  "LeBlanc" => "Noxus",
  "Mordekaiser" => "Noxus",
  "Rell" => "Noxus",
  "Riven" => "Noxus",
  "Samira" => "Noxus",
  "Sion" => "Noxus",
  "Swain" => "Noxus",
  "Talon" => "Noxus",
  "Vladimir" => "Noxus",

  # Piltover
  "Caitlyn" => "Piltover",
  "Camille" => "Piltover",
  "Ezreal" => "Piltover",
  "Heimerdinger" => "Piltover",
  "Jayce" => "Piltover",
  "Orianna" => "Piltover",
  "Seraphine" => "Piltover",
  "Vi" => "Piltover",

  # Shadow Isles
  "Elise" => "Shadow Isles",
  "Gwen" => "Shadow Isles",
  "Hecarim" => "Shadow Isles",
  "Kalista" => "Shadow Isles",
  "Karthus" => "Shadow Isles",
  "Maokai" => "Shadow Isles",
  "Thresh" => "Shadow Isles",
  "Vex" => "Shadow Isles",
  "Viego" => "Shadow Isles",
  "Yorick" => "Shadow Isles",

  # Zaun
  "Blitzcrank" => "Zaun",
  "Dr. Mundo" => "Zaun",
  "Ekko" => "Zaun",
  "Janna" => "Zaun",
  "Jinx" => "Zaun",
  "Renata Glasc" => "Zaun",
  "Singed" => "Zaun",
  "Twitch" => "Zaun",
  "Urgot" => "Zaun",
  "Viktor" => "Zaun",
  "Warwick" => "Zaun",
  "Zac" => "Zaun",
  "Ziggs" => "Zaun",
  "Zeri" => "Zaun",

  # Shurima
  "Akshan" => "Shurima",
  "Amumu" => "Shurima",
  "Azir" => "Shurima",
  "K'Sante" => "Shurima",
  "Naafiri" => "Shurima",
  "Nasus" => "Shurima",
  "Rammus" => "Shurima",
  "Renekton" => "Shurima",
  "Sivir" => "Shurima",
  "Taliyah" => "Shurima",
  "Xerath" => "Shurima",

  # The Void
  "Bel'Veth" => "The Void",
  "Cho'Gath" => "The Void",
  "Kai'Sa" => "The Void",
  "Kassadin" => "The Void",
  "Kha'Zix" => "The Void",
  "Kog'Maw" => "The Void",
  "Malzahar" => "The Void",
  "Rek'Sai" => "The Void",
  "Vel'Koz" => "The Void",

  # Targon
  "Aphelios" => "Targon",
  "Aurelion Sol" => "Targon",
  "Diana" => "Targon",
  "Leona" => "Targon",
  "Pantheon" => "Targon",
  "Soraka" => "Targon",
  "Taric" => "Targon",
  "Zoe" => "Targon",
  # Freljord
  "Anivia" => "Freljord",
  "Ashe" => "Freljord",
  "Aurora" => "Freljord",
  "Braum" => "Freljord",
  "Gnar" => "Freljord",
  "Gragas" => "Freljord",
  "Lissandra" => "Freljord",
  "Nunu & Willump" => "Freljord",
  "Olaf" => "Freljord",
  "Ornn" => "Freljord",
  "Sejuani" => "Freljord",
  "Trundle" => "Freljord",
  "Tryndamere" => "Freljord",
  "Udyr" => "Freljord",
  "Volibear" => "Freljord",

  # Your champions
  "Aatrox" => "Shurima",
  "Alistar" => "Freljord",
  "Annie" => "Noxus",
  "Bard" => "Targon",
  "Brand" => "Freljord",
  "Evelynn" => "Ionia",
  "Fiddlesticks" => "Ionia",
  "Jax" => "Runeterra",
  "Kindred" => "Shadow Isles",
  "Nami" => "Bilgewater",
  "Nilah" => "Shurima",
  "Nocturne" => "Shadow Isles",
  "Ryze" => "Runeterra", # Ryze's origin is tied to many places
  "Shaco" => "Shurima"
}

champion_region_map.each do |champion_name, region_name|
  champion = Champion.find_by(name: champion_name)
  region = Region.find_by(name: region_name)

  if champion && region
    champion.update(region_id: region.id)
    puts "Successfully associated #{champion_name} with #{region_name}"
  else
    puts "Could not find champion or region for #{champion_name} / #{region_name}"
  end
end

puts "Successfully associated champions with regions!"
