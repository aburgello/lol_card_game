module GamesHelper
  QUESTIONS = [
    { question: "What is the cooldown of Flash in League of Legends?", answers: ["180 seconds", "210 seconds", "300 seconds", "150 seconds"], correct_answer: "300 seconds" },
    { question: "Which champion has the ability 'Leap Strike'?", answers: ["Lee Sin", "Riven", "Jax", "Kennen"], correct_answer: "Jax" },
    { question: "What is the maximum level a champion can reach?", answers: ["15", "18", "20", "25"], correct_answer: "18" },
    { question: "Which item grants bonus movement speed when out of combat?", answers: ["Boots of Speed", "Ionian Boots of Lucidity", "Berserker's Greaves", "Boots of Mobility"], correct_answer: "Boots of Mobility" },
    { question: "What is the name of the dragon that grants a team bonus attack damage?", answers: ["Cloud Drake", "Mountain Drake", "Infernal Drake", "Ocean Drake"], correct_answer: "Infernal Drake" },
    { question: "Which champion is known as the 'Unforgiven'?", answers: ["Yasuo", "Zed", "Riven", "Jhin"], correct_answer: "Yasuo" },
    { question: "What is the primary resource used by champions to cast abilities?", answers: ["Energy", "Mana", "Rage", "Health"], correct_answer: "Mana" },
    { question: "Which item is used to counteract healing effects?", answers: ["Executioner's Calling", "Mortal Reminder", "Greaves of the Legion", "Riftmaker"], correct_answer: "Mortal Reminder" },
    { question: "What is the name of the Rift Herald's ability?", answers: ["Rift Assault", "Herald's Charge", "Rift Surge", "Herald's Wrath"], correct_answer: "Rift Surge" },
    { question: "Which champion can teleport to a ward?", answers: ["Kennen", "Kassadin", "Shen", "Twisted Fate"], correct_answer: "Shen" },
    { question: "What does the Baron Nashor buff grant?", answers: ["Increased health regeneration", "Bonus attack damage and ability power", "Vision of the enemy jungle", "Increased gold per minion"], correct_answer: "Bonus attack damage and ability power" },
    { question: "Which champion has a passive ability called 'Adrenaline Rush'?", answers: ["Warwick", "Rengar", "Olaf", "Dr. Mundo"], correct_answer: "Dr. Mundo" },
    { question: "What is the name of the jungle monster that grants a shield when killed?", answers: ["Gromp", "Krug", "Rift Scuttler", "Blue Buff"], correct_answer: "Rift Scuttler" },
    { question: "Which item is known for providing 'Spell Vamp'?", answers: ["Gunblade", "Rylai's Crystal Scepter", "Riftmaker", "Morellonomicon"], correct_answer: "Gunblade" },
    { question: "What is the cooldown of the ability 'Smite'?", answers: ["60 seconds", "90 seconds", "45 seconds", "30 seconds"], correct_answer: "90 seconds" },
    { question: "Which champion is known as the 'Cryophoenix'?", answers: ["Anivia", "Lissandra", "Zyra", "Frost Queen"], correct_answer: "Anivia" },
    { question: "What is the name of the in-game currency?", answers: ["Gold", "Silver", "Platinum", "Crystal"], correct_answer: "Gold" },
    { question: "Which champion can create a 'Doppelganger'?", answers: ["Kassadin", "Shaco", "Zed", "Mordekaiser"], correct_answer: "Shaco" },
    { question: "What is the name of the ability that allows champions to dodge incoming attacks?", answers: ["Evasion ", "Dodge", "Spell Shield", "Counter"], correct_answer: "Spell Shield" },
    { question: "Which champion has the ability 'R' - Destiny?", answers: ["Twisted Fate", "Zyra", "Kennen", "Gragas"], correct_answer: "Twisted Fate" },
    { question: "What does the 'S' rank in a game signify?", answers: ["Satisfactory", "Superb", "S-tier", "Special"], correct_answer: "Superb" },
    { question: "What is the name of the dragon that grants bonus cooldown reduction?", answers: ["Ocean Drake", "Cloud Drake", "Infernal Drake", "Hextech Drake"], correct_answer: "Cloud Drake" },
    { question: "Which champion has the ability 'Q' - Mystic Shot?", answers: ["Ezreal", "Caitlyn", "Ashe", "Jhin"], correct_answer: "Ezreal" },
    { question: "What is the name of the item that increases critical strike chance and attack speed?", answers: ["Phantom Dancer", "Infinity Edge", "Rapid Firecannon", "Statikk Shiv"], correct_answer: "Phantom Dancer" },
    { question: "Which champion is known as 'The Nine-Tailed Fox'?", answers: ["Ahri", "Evelynn", "Lissandra", "Fiora"], correct_answer: "Ahri" },
    { question: "What is the passive effect of the 'Luden's Tempest' item?", answers: ["Cooldown reduction", "Spell haste", "Echo damage", "Mana regeneration"], correct_answer: "Echo damage" },
    { question: "Which champion can place mushrooms as traps?", answers: ["Teemo", "Zyra", "Singed", "Ivern"], correct_answer: "Teemo" },
    { question: "What is the base cooldown of the summoner spell 'Teleport'?", answers: ["300 seconds", "240 seconds", "360 seconds", "420 seconds"], correct_answer: "360 seconds" },
    { question: "What is the name of the ability that heals nearby allies?", answers: ["Resonating Strike", "Wild Growth", "Wish", "Rejuvenation"], correct_answer: "Wish" },
    { question: "Which champion has the nickname 'The Seneschal of Demacia'?", answers: ["Jarvan IV", "Xin Zhao", "Galio", "Vayne"], correct_answer: "Xin Zhao" },
    { question: "What is the maximum number of turrets a team can destroy?", answers: ["10", "11", "9", "12"], correct_answer: "11" },
    { question: "Which champion uses 'Heat' as their resource?", answers: ["Rumble", "Jayce", "Jinx", "Heimerdinger"], correct_answer: "Rumble" },
    { question: "What is the name of the in-game system that bans players for toxicity?", answers: ["Tribunal", "Honor System", "Behavior Review", "Justice Program"], correct_answer: "Tribunal" },
    { question: "Which champion is known as 'The Lady of Luminosity'?", answers: ["Lux", "Leona", "Karma", "Morgana"], correct_answer: "Lux" },
    { question: "What is the name of the jungle monster that grants bonus vision?", answers: ["Rift Scuttler", "Red Buff", "Blue Buff", "Gromp"], correct_answer: "Rift Scuttler" },
    { question: "Which champion has the ability 'R' - Cannon Barrage?", answers: ["Gangplank", "Graves", "Miss Fortune", "Twisted Fate"], correct_answer: "Gangplank" },
    { question: "What is the name of the summoner spell that removes debuffs?", answers: ["Cleanse", "Barrier", "Heal", "Exhaust"], correct_answer: "Cleanse" },
    { question: "Which item gives bonus attack damage and lifesteal?", answers: ["Ravenous Hydra", "Blade of the Ruined King", "Bloodthirster", "Death's Dance"], correct_answer: "Bloodthirster" },
    { question: "What is the name of the map used in professional League of Legends games?", answers: ["Twisted Treeline", "Summoner's Rift", "Howling Abyss", "Crystal Scar"], correct_answer: "Summoner's Rift" },
    { question: "Which champion's ultimate ability is 'The Box'?", answers: ["Thresh", "Morgana", "Leona", "Alistar"], correct_answer: "Thresh" },
    { question: "Which item builds into 'Infinity Edge'?", answers: ["Cloak of Agility", "Long Sword", "Serrated Dirk", "B. F. Sword"], correct_answer: "B. F. Sword" },
    { question: "Which champion is known as the 'Mad Chemist'?", answers: ["Dr. Mundo", "Singed", "Viktor", "Heimerdinger"], correct_answer: "Singed" },
    { question: "What is the name of the Summoner's Rift boss monster?", answers: ["Baron Nashor", "Elder Dragon", "Rift Herald", "Infernal Drake"], correct_answer: "Baron Nashor" },
    { question: "Which champion uses 'Ferocity' as a resource?", answers: ["Rengar", "Gnar", "Renekton", "Warwick"], correct_answer: "Rengar" },
    { question: "What is the cost of the item 'Infinity Edge'?", answers: ["3400 gold", "3200 gold", "3600 gold", "3000 gold"], correct_answer: "3400 gold" },
    { question: "Which champion's ultimate ability is called 'Glacial Prison'?", answers: ["Ashe", "Lissandra", "Sejuani", "Anivia"], correct_answer: "Sejuani" },
    { question: "What type of damage does 'Lethality' affect?", answers: ["True Damage", "Magic Damage", "Physical Damage", "Critical Damage"], correct_answer: "Physical Damage" },
    { question: "Which rune provides bonus attack speed and movement speed on hitting an enemy?", answers: ["Conqueror", "Phase Rush", "Fleet Footwork", "Lethal Tempo"], correct_answer: "Lethal Tempo" },
    { question: "What is the name of the buff granted by killing the Red Brambleback?", answers: ["Crimson Fury", "Red Buff", "Elder Strength", "Bramble Flame"], correct_answer: "Red Buff" },
    { question: "Which champion's passive ability is 'Sheen Proc'?", answers: ["Irelia", "Ezreal", "Gangplank", "Twisted Fate"], correct_answer: "Ezreal" },
    { question: "What is the name of the item that increases a champion's critical strike damage?", answers: ["Infinity Edge", "Phantom Dancer", "Essence Reaver", "Rapid Firecannon"], correct_answer: "Infinity Edge" },
    { question: "Which champion is referred to as 'The Darkin Blade'?", answers: ["Kayn", "Aatrox", "Varus", "Rhaast"], correct_answer: "Aatrox" },
    { question: "What is the bonus gold for killing a cannon minion?", answers: ["60 gold", "40 gold", "70 gold", "50 gold"], correct_answer: "60 gold" },
    { question: "Which champion has the ability 'R' - 'Moonfall'?", answers: ["Diana", "Leona", "Zoe", "Soraka"], correct_answer: "Diana" },
    { question: "What is the cooldown for teleport summoner spell?", answers: ["300 seconds", "420 seconds", "360 seconds", "400 seconds"], correct_answer: "360 seconds" },
    { question: "Which champion's passive ability is 'Ebb and Flow'?", answers: ["Soraka", "Nami", "Janna", "Karma"], correct_answer: "Nami" },
    { question: "Which item grants a shield when immobilizing an enemy?", answers: ["Immortal Shieldbow", "Eclipse", "Crown of the Shattered Queen", "Sterak's Gage"], correct_answer: "Eclipse" },
    { question: "What is the range of a basic attack by a melee champion?", answers: ["125 units", "150 units", "100 units", "175 units"], correct_answer: "125 units" },
    { question: "Which champion can become untargetable with 'W' ability 'Shroud of Darkness'?", answers: ["Nocturne", "Akali", "Zed", "Kassadin"], correct_answer: "Nocturne" },
    { question: "Which champion has the ability 'Q' - 'Barrel Roll'?", answers: ["Gragas", "Gangplank", "Ziggs", "Keg"], correct_answer: "Gragas" },
    { question: "What is the maximum number of wards a player can place at a time?", answers: ["4", "3", "5", "6"], correct_answer: "3" }
  ]
  

  def daily_attempts_for(game_type, user)
    case game_type
    when "quiz"
      "#{user.quiz_attempts_today}/7"
    when "ability_guess"
      "#{user.ability_guess_attempts_today}/7"
    when "skin_snippet"
      "#{user.skin_snippet_attempts_today}/7"
    when "skin_name"
      "#{user.skin_name_attempts_today}/7"
    else
      "0/7"
    end
  end
end
