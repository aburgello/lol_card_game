class Region < ApplicationRecord
  has_many :champions
  has_many :user_regions, dependent: :destroy
  has_many :users, through: :user_regions
  validates :name, presence: true, uniqueness: true
  has_many :challenges

  regions = [
  { name: "Bandle City", 
    logo: "bandle_city_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/84d14187e66ee28277609d55a3db93b96ae2a34c.webm", 
    image_backdrop: "bandle_city.webp",
    lore: "Opinions differ as to where exactly the home of the yordles is to be found, though a handful of mortals claim to have traveled unseen pathways to a land of curious enchantment beyond the material realm. They tell of a place of unfettered magic, where the foolhardy can be led astray by myriad wonders, and end up lost in a dream...
In Bandle City, it is said that every sensation is heightened for non-yordles. Colors are brighter. Food and drink intoxicates the senses for years and, once tasted, will never be forgotten. The sunlight is eternally golden, the waters crystal clear, and every harvest brings a fruitful bounty. Perhaps some of these claims are true, or maybe none—for no two taletellers ever seem to agree on what they actually saw.
Only one thing is known for certain, and that is the timeless quality of Bandle City and its inhabitants. This might explain why those mortals who find their way back often appear to have aged tremendously, while many more never return at all."
  },
  { name: "Freljord", 
    logo: "freljord_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/aa302815ab40524f8382dbc9865d6cbd7df0b9f9.webm", 
    image_backdrop: "Freljord_Pilgrim_Site_Of_Rakelstake.webp",
    lore: "The Freljord is a harsh and unforgiving place—where the people are born warriors, who must persevere against all odds.
Proud and fiercely independent, the tribes of the Freljord are often considered wild, rugged, and “uncivilized” by their neighbors across Valoran, who do not know the ancient traditions that shaped them. Many thousands of years ago, the alliance between the sisters Avarosa, Serylda, and Lissandra was shattered in a war that unknowingly threatened all of Runeterra, plunging the northern lands into chaos, and near-constant winter. Now, only those truly exceptional mortals who seem immune to the ravages of fire or ice seem destined, or able, to lead.
Despite the best efforts of the Frostguard, myths and legends still endure of the old gods, the enigmatic yetis, and restless spirit walker shamans. The raiders of the Winter’s Claw range further with each passing year, harrying the borders of Demacia to the south, and the frontiers of Noxus to the east. Finally, seeking a more peaceful future, the fractious independent tribes and clans have begun to offer their allegiance to Ashe, young queen of the Avarosans.
Even so, the portents are grim. War is surely returning to the Freljord, and none can hope to escape it."
  }, 

  { name: "Bilgewater", 
    logo: "bilgewater_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d9beea1a5d1cfc7ec6bbc100d3fb522175930f38.webm", 
    image_backdrop: "Bilgewater_A_New_Beginning.webp",
    lore: "Nestled away in the Blue Flame Isles archipelago, Bilgewater is a port city like no other—home to serpent hunters, dock gangs, and smugglers from across the known world. Here, fortunes are made and ambitions shattered in the blink of an eye. For those fleeing justice, debt, or persecution, Bilgewater can be a place of new beginnings, for no one on these twisted streets cares about your past. Even so, with each new dawn, careless travelers can always be found floating in the harbor, their purses empty and their throats slit…
While incredibly dangerous, Bilgewater is ripe with opportunity, free from the shackles of formal government and trade regulation. If you have the coin, almost anything can be purchased here, from outlawed hextech to the favor of local crime lords.
With the recent removal of the last “reaver king” of Bilgewater, the city has entered a period of transition, while the most prominent captains try to agree on its future. But as long as there are seaworthy ships and crews to sail them, Bilgewater is likely to remain one of the most colorful and well-connected places in Runeterra."
    },

  { name: "Demacia", 
    logo: "demacia_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/36c564338d66ac2000a3d6c091dd78c443230623.webm", 
    image_backdrop: "Demacia_Hall_Of_Valor.webp",
    lore: "Astrong, lawful kingdom with a prestigious military history, Demacia’s people have always valued the ideals of justice, honor, and duty most highly, and are fiercely proud of their cultural heritage. But in spite of these lofty principles, this largely self-sufficient nation has grown more insular and isolationist in recent centuries.
Now, Demacia is a kingdom in turmoil.
The capital, the Great City of Demacia, was founded as a refuge from sorcery after the nightmare of the Rune Wars, and built upon the riddle of petricite—a peculiar white stone that dampens magical energy. It is from here that the royal family has long seen to the defense of the outlying towns and villages, farmland, forests, and mountains rich with mineral resources.
However, following the sudden death of King Jarvan III, the other noble families have not yet approved the succession of his sole heir, young Prince Jarvan, to the throne.
Those who dwell beyond the heavily guarded borders are increasingly viewed with suspicion, and many former allies have begun to look elsewhere for protection, in these uncertain times. Some dare to whisper that the golden age of Demacia has passed, and unless its people are willing to adapt to a changing world—something many believe they are simply incapable of doing—the kingdom’s decline may be inevitable.
And all the petricite in the land will not protect Demacia from itself."
    },

  { name: "Ionia", 
    logo: "iona_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/a9b6b551e2589189615eb4f7d56a17862ff3a882.webm", 
    image_backdrop: "Ionia_The_Placidium.webp",
    lore: "Surrounded by treacherous seas, Ionia is composed of a number of allied provinces scattered across a massive archipelago, known to many as the First Lands. Since Ionian culture has long been shaped by the pursuit of balance in all things, the border between the material and spirit realms tends to be more permeable here, especially in the wild forests and mountains.
Although these lands’ enchantments can be fickle, its creatures dangerous and fae, for many centuries most Ionians led lives of plenty. The warrior monasteries, provincial militias—and even Ionia itself—had been enough to protect them.
But that ended twelve years ago, when Noxus attacked the First Lands. The empire’s seemingly endless warhosts savaged Ionia, and were only defeated after many years, and at great cost.
Now, Ionia exists in an uneasy peace. Different reactions to the war have divided the region—some groups, such as the Shojin monks or the Kinkou, seek a return to isolationist pacifism, and pastoral traditions. Other more radical factions, such as the Navori Brotherhood and the Order of Shadow, demand a militarization of the land’s magic, to create a single, unified nation that can take vengeance on Noxus.
The fate of Ionia hangs in a delicate balance that few are willing to overturn, but all can feel shifting uneasily beneath their feet."
  },
  { name: "Ixtal", 
    logo: "ixtal_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/670a63d489e907098afeafd2ce42a81e8e64bfcb.webm", 
    image_backdrop: "Ixtal_An_Unexplored_Frontier.webp",
    lore: "Renowned for its mastery of elemental magic, Ixtal was one of the first independent nations to join the Shuriman empire. In truth, Ixtali culture is much older—part of the great westward diaspora that gave rise to civilizations including the Buhru, magnificent Helia, and the ascetics of Targon—and it is likely they played a significant role in the creation of the first Ascended.
But the mages of Ixtal survived the Void, and later the Darkin, by distancing themselves from their neighbors, drawing the wilderness around them like a shield. While much had already been lost, they were committed to the preservation of what little remained…
Now, secluded deep in the jungle for thousands of years, the sophisticated arcology-city of Ixaocan remains mostly free of outside influence. Having witnessed from afar the ruination of the Blessed Isles and the Rune Wars that followed, the Ixtali view all the other factions of Runeterra as upstarts and pretenders, and use their powerful magic to keep any intruders at bay."
    },

  { name: "Noxus", 
    logo: "noxus_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/329c91313054076a869a6ceb95c995107320e334.webm", 
    image_backdrop: "Noxus_The_Immortal_Bastion_01.webp",
    lore: "Noxus is a powerful empire with a fearsome reputation. To those beyond its borders, it is brutal, expansionist, and threatening, yet those who look past its warlike exterior see an unusually inclusive society, where the strengths and talents of its people are respected and cultivated.
The Noxii were once fierce barbarian tribes, until they stormed the ancient city that now lies at the heart of their domain. Under threat from all sides, they aggressively took the fight to their enemies, pushing their borders outward with each passing year. This struggle for survival has made modern Noxians a deeply proud people who value strength above all—though that strength can manifest in many different forms.
Anyone can rise to a position of power and respect within Noxus if they display the necessary aptitude, regardless of social standing, background, homeland, or wealth. Those who are able to wield magic are held in particularly high esteem, and are actively sought out in order that their special talents may be honed and best harnessed for the benefit of the empire.
But in spite of this meritocratic ideal, the old noble houses still wield considerable power… and some fear that the greatest threat to Noxus comes not from its enemies, but from within."
    },

  { name: "Piltover", 
    logo: "piltover_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/2b8b859578a41fc8a9272dacc0bdd6405a248c10.webm", 
    image_backdrop: "Piltover_Impacts_Across_Valoran.webp",
    lore: "Piltover is a thriving, progressive city whose power and influence is on the rise. It is Valoran’s cultural center, where art, craftsmanship, trade and innovation walk hand in hand. Its power comes not through military might, but the engines of commerce and forward thinking. Situated on the cliffs above the district of Zaun and overlooking the ocean, fleets of ships pass through its titanic sea-gates, bringing goods from all over the world. The wealth this generates has given rise to an unprecedented boom in the city’s growth. Piltover has - and still is - reinventing itself as a city where fortunes can be made and dreams can be lived. Burgeoning merchant clans fund development in the most incredible endeavors: grand artistic follies, esoteric hextech research, and architectural monuments to their power. With ever more inventors delving into the emergent lore of hextech, Piltover has become a lodestone for the most skilled craftsmen the world over."
    },

  { name: "Shadow Isles", 
    logo: "shadow_isles_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/9648da1fe76a45096b7095940d7991269d97d351.webm", 
    image_backdrop: "Shadow_Isles_Ruins.webp",
    lore: "This cursed land was once home to a noble, enlightened civilization, known to its allies and emissaries as the Blessed Isles. However, more than a thousand years ago, an unprecedented magical cataclysm left the barrier between the material and spirit realms in tatters, effectively merging the two… and dooming all living things in an instant.
Now, a malevolent Black Mist permanently shrouds the Isles, and the earth itself is tainted by dark sorcery. Mortals who dare to venture to these dismal shores will slowly have their life force stolen away from them, which in turn attracts the insatiable, restless spirits of the dead.
Those who perish within the Mist are condemned to haunt this nightmarish place for eternity—worse still, the power of the Shadow Isles appears to wax stronger with every passing year, allowing the most powerful specters to roam farther and farther across Runeterra."

  },

  { name: "Shurima", 
    logo: "shurima_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/903a0dc3286518114b68113d0778e5299a26a729.webm", 
    image_backdrop: "Shurima_The_Rebirth.webp",
    lore: "The empire of Shurima was once a thriving civilization that spanned an entire continent. Forged in a bygone age by the mighty god-warriors of the Ascended Host, it united all the disparate peoples of the south, and enforced a lasting peace between them.
Few dared to rebel. Those that did, like the accursed nation of Icathia, were crushed without mercy.
However, after several thousand years of growth and prosperity, the failed Ascension of Shurima’s last emperor left the capital in ruins, and tales of the empire’s former glory became little more than myth. Now, most of the nomadic inhabitants of Shurima’s deserts eke out a meager existence from the unforgiving land. Some have built small outposts to defend the few oases, while others delve into long lost catacombs in search of the untold riches that must surely lay buried there. There are also those who live as mercenaries, taking coin for their service before disappearing back into the lawless wastelands.
Still, a handful dare to dream of a return to the old ways. Indeed, more recently the tribes have been stirred by whispers from the heart of the desert—that their emperor Azir has returned, to lead them into a new, wondrous age."
    },

  { name: "Targon", 
    logo: "mt_targon_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d00f9e798c7e63fed1eaa8b92770f280d0c7f241.webm", 
    image_backdrop: "Mount_Targon_Once_In_A_Lifetime.webp",
    lore: "Mount Targon is the mightiest peak in Runeterra, a towering peak of sun-baked rock amid a range of summits unmatched in scale anywhere else in the world. Located far from civilization, Mount Targon is utterly remote and all but impossible to reach save by the most determined seeker. Many legends cling to Mount Targon, and, like any place of myth, it is a beacon to dreamers, madmen and questors of adventure. Some of these brave souls attempt to scale the impossible mountain, perhaps seeking wisdom or enlightenment, perhaps chasing glory or some soul-deep yearning to witness its summit. The ascent is all but impossible, and those hardy few who somehow survive to reach the top almost never speak of what they have seen. Some return with a haunted, empty look in their eyes, others changed beyond all recognition, imbued by an Aspect of unearthly, inhuman power with a destiny few mortals can comprehend."
  },

  { name: "The Void", 
    logo: "void_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d02e1a8e54aa5b4ea0bcbb430c5e1bb697400fa5.webm", 
    image_backdrop: "Void_An_Unknowable_Power.webp",
    lore: "Screaming into existence with the birth of the universe, the Void is a manifestation of the unknowable nothingness that lies beyond. It is a force of insatiable hunger, waiting through the eons until its masters, the mysterious Watchers, mark the final time of undoing.
To be a mortal touched by this power is to suffer an agonizing glimpse of eternal unreality, enough to shatter even the strongest mind. Denizens of the Void realm itself are construct-creatures, often of only limited sentience, but tasked with a singular purpose—to usher in total oblivion across Runeterra."
  },
  { name: "Zaun", 
    logo: "zaun_crest_icon.png", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/7feffff28f5a4df3f58438b83d4553b37ae647e0.webm", 
    image_backdrop: "Zaun_Life_Survives_In_The_Depth.webp",
    lore: "Zaun is a large, undercity district, lying in the deep canyons and valleys threading Piltover. What light reaches below is filtered through fumes leaking from the tangles of corroded pipework and reflected from the stained glass of its industrial architecture. Zaun and Piltover were once united, but are now separate, yet symbiotic societies. Though it exists in perpetual smogged twilight, Zaun thrives, its people vibrant and its culture rich. Piltover’s wealth has allowed Zaun to develop in tandem; a dark mirror of the city above. Many of the goods coming to Piltover find their way into Zaun’s black markets, and hextech inventors who find the restrictions placed upon them in the city above too restrictive often find their dangerous researches welcomed in Zaun. Unfettered development of volatile technologies and reckless industry has rendered whole swathes of Zaun polluted and dangerous. Streams of toxic runoff stagnate in the city’s lower reaches, but even here people find a way to exist and prosper."
  },
    { name: "Runeterra", 
    logo: "Runeterra_Crest_icon.webp", 
    video_backdrop: "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/7feffff28f5a4df3f58438b83d4553b37ae647e0.webm",
    image_backdrop: "Runeterra_Terrain_map.webp",
    lore: "Runeterra (meaning magic earth) is a plane of existence composed of the physical realm: an oblate spheroid planet and the Spirit Realm. Composed of both the material and spirit realms, Runeterra is all that separates the celestial powers of creation from the abyssal threat of all undoing. This is a magical world unlike any other--inhabited by peoples both fierce and wondrous. It also boasts several large bodies of water, such as the currently known 18 Seas (like the Conqueror's Sea and the Guardian's Sea), and 2 Oceans with several archipelagos and islands around them (like Ionia, the Serpent Isles, and the Shadow Isles). The planet orbits around a G-type star while a natural satellite moon orbits around the planet. Runeterra's sun and moon also even mirrored equivalents in the spirit realm."
  }
]


def create_regions
regions_to_create = regions.map do |region|
  {
    name: region[:name],
    logo: "#{region[:logo]}",
    video_backdrop: region[:video_backdrop],
    image_backdrop: region[:image_backdrop],
    lore: region[:lore]
  }
end
Region.insert_all(regions_to_create)
end



end
