ChampionType.destroy_all
Type.destroy_all
Ability.destroy_all
Skin.destroy_all
Champion.destroy_all
Region.destroy_all
RiotApi.fetch_champions

regions = [
  { name: "Bandle City", 
    logo: "bandle_city_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/84d14187e66ee28277609d55a3db93b96ae2a34c.webm", 
    image_backdrop: "bandle_city.webp" },

  { name: "Freljord", 
    logo: "freljord_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/aa302815ab40524f8382dbc9865d6cbd7df0b9f9.webm", 
    image_backdrop: "Freljord_Pilgrim_Site_Of_Rakelstake.webp" },  

  { name: "Bilgewater", 
    logo: "bilgewater_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d9beea1a5d1cfc7ec6bbc100d3fb522175930f38.webm", 
    image_backdrop: "Bilgewater_A_New_Beginning.webp" },

  { name: "Demacia", 
    logo: "demacia_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/36c564338d66ac2000a3d6c091dd78c443230623.webm", 
    image_backdrop: "Demacia_Hall_Of_Valor.webp" },

  { name: "Ionia", 
    logo: "iona_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/a9b6b551e2589189615eb4f7d56a17862ff3a882.webm", 
    image_backdrop: "Ionia_The_Placidium.webp" },

  { name: "Ixtal", 
    logo: "ixtal_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/670a63d489e907098afeafd2ce42a81e8e64bfcb.webm", 
    image_backdrop: "Ixtal_An_Unexplored_Frontier.webp" },

  { name: "Noxus", 
    logo: "noxus_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/329c91313054076a869a6ceb95c995107320e334.webm", 
    image_backdrop: "Noxus_The_Immortal_Bastion_01.webp" },

  { name: "Piltover", 
    logo: "piltover_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/2b8b859578a41fc8a9272dacc0bdd6405a248c10.webm", 
    image_backdrop: "Piltover_Impacts_Across_Valoran.webp" },

  { name: "Shadow Isles", 
    logo: "shadow_isles_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/9648da1fe76a45096b7095940d7991269d97d351.webm", 
    image_backdrop: "Shadow_Isles_Ruins.webp" },

  { name: "Shurima", 
    logo: "shurima_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/903a0dc3286518114b68113d0778e5299a26a729.webm", 
    image_backdrop: "Shurima_The_Rebirth.webp" },

  { name: "Targon", 
    logo: "mt_targon_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d00f9e798c7e63fed1eaa8b92770f280d0c7f241.webm", 
    image_backdrop: "Mount_Targon_Once_In_A_Lifetime.webp" },

  { name: "The Void", 
    logo: "void_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d02e1a8e54aa5b4ea0bcbb430c5e1bb697400fa5.webm", 
    image_backdrop: "Void_An_Unknowable_Power.webp" },

  { name: "Zaun", 
    logo: "zaun_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/7feffff28f5a4df3f58438b83d4553b37ae647e0.webm", 
    image_backdrop: "Zaun_Life_Survives_In_The_Depth.webp" },

    { name: "Runeterra", 
    logo: "Runeterra_Crest_icon.webp", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/7feffff28f5a4df3f58438b83d4553b37ae647e0.webm",
    image_backdrop: "Runeterra_Terrain_map.webp"
  }
]




regions_to_create = regions.map do |region|
  {
    name: region[:name],
    logo: "#{region[:logo]}",
    video_backdrop: region[:video_backdrop],
    image_backdrop: region[:image_backdrop]
  }
end
Region.insert_all(regions_to_create)




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
  "Aatrox" => "Runeterra",
  "Alistar" => "Runeterra",
  "Annie" => "Runeterra",
  "Bard" => "Runeterra",
  "Brand" => "Runeterra",
  "Evelynn" => "Runeterra",
  "Fiddlesticks" => "Runeterra",
  "Jax" => "Runeterra",
  "Kindred" => "Runeterra",
  "Nami" => "Runeterra",
  "Nilah" => "Runeterra",
  "Nocturne" => "Runeterra",
  "Ryze" => "Runeterra",
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
