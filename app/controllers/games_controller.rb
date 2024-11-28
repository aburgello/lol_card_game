class GamesController < ApplicationController
  before_action :set_game, only: [:show, :submit_answer]
  before_action :check_daily_limit, only: [:submit_answer]
  before_action :check_skin_name_game_limit, only: [:handle_skin_name_answer]

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
      { question: "Which champion's passive ability is 'Rising Spell Force'?", answers: ["Irelia", "Ezreal", "Gangplank", "Twisted Fate"], correct_answer: "Ezreal" },
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
      { question: "What is the maximum number of wards a player can place at a time?", answers: ["4", "3", "5", "6"], correct_answer: "3" },
      { question: "What is the name of the passive that allows Aatrox to heal with his abilities?", answers: ["Blood Well", "Deathbringer Stance", "World Ender", "Darkin Pact"], correct_answer: "Deathbringer Stance" },
      { question: "Which champion has the ability 'E' - Shadow Dash?", answers: ["Shen", "Zed", "Akali", "Kayn"], correct_answer: "Shen" },
      { question: "What is the maximum attack speed a champion can reach in League of Legends?", answers: ["2.0", "2.5", "3.0", "1.75"], correct_answer: "2.5" },
      { question: "Which champion's ultimate ability is 'Realm Warp'?", answers: ["Ryze", "Ezreal", "Twisted Fate", "Sylas"], correct_answer: "Ryze" },
      { question: "What is the base cooldown of the summoner spell 'Barrier'?", answers: ["120 seconds", "90 seconds", "60 seconds", "150 seconds"], correct_answer: "120 seconds" },
      { question: "Which rune provides a bonus shield when out of combat?", answers: ["Guardian", "Nullifying Orb", "Second Wind", "Overgrowth"], correct_answer: "Nullifying Orb" },
      { question: "What is the gold bounty for a 5-kill streak?", answers: ["400 gold", "600 gold", "700 gold", "500 gold"], correct_answer: "700 gold" },
      { question: "Which champion has a passive ability called 'Hemorrhage'?", answers: ["Darius", "Draven", "Vladimir", "Mordekaiser"], correct_answer: "Darius" },
      { question: "What is the name of the neutral monster that grants bonus mana regeneration?", answers: ["Blue Sentinel", "Gromp", "Rift Scuttler", "Red Brambleback"], correct_answer: "Blue Sentinel" },
      { question: "Which champion is known as 'The Stoneweaver'?", answers: ["Taliyah", "Malphite", "Ivern", "Skarner"], correct_answer: "Taliyah" },
      { question: "Which item is designed to counter shields?", answers: ["Serpent's Fang", "Black Cleaver", "Lord Dominik's Regards", "Thornmail"], correct_answer: "Serpent's Fang" },
      { question: "What is the name of the ability that allows champions to reveal invisible units?", answers: ["Oracle Lens", "True Sight", "Vision Ward", "Revealing Light"], correct_answer: "Oracle Lens" },
      { question: "Which champion's passive ability grants stacking movement speed when out of combat?", answers: ["Hecarim", "Sivir", "Nidalee", "Bard"], correct_answer: "Hecarim" },
      { question: "What is the name of the Drake that grants adaptive bonuses based on missing health?", answers: ["Elder Dragon", "Ocean Drake", "Chemtech Drake", "Cloud Drake"], correct_answer: "Chemtech Drake" },
      { question: "Which item provides the 'Haste' passive?", answers: ["Ionian Boots of Lucidity", "Youmuu's Ghostblade", "Force of Nature", "Cosmic Drive"], correct_answer: "Cosmic Drive" },
      { question: "Which champion is known as 'The Frost Archer'?", answers: ["Ashe", "Anivia", "Lissandra", "Sejuani"], correct_answer: "Ashe" },
      { question: "What is the gold cost of 'Tear of the Goddess'?", answers: ["400 gold", "450 gold", "350 gold", "500 gold"], correct_answer: "400 gold" },
      { question: "Which champion has the ability 'W' - 'Inspire'?", answers: ["Karma", "Lulu", "Janna", "Lux"], correct_answer: "Karma" },
      { question: "What is the cooldown reduction cap in League of Legends?", answers: ["40%", "35%", "30%", "50%"], correct_answer: "40%" },
      { question: "Which champion can become untargetable with their ultimate?", answers: ["Kayle", "Fiddlesticks", "Elise", "Vladimir"], correct_answer: "Vladimir" },
      { question: "Which champion's ultimate ability is 'Hijack'?", answers: ["Sylas", "Ekko", "Fizz", "Zoe"], correct_answer: "Sylas" },
      { question: "What is the name of the shopkeeper on the blue side?", answers: ["The Quartermaster", "Bluestone Merchant", "Professor Stanwick", "Blue Sentinel Keeper"], correct_answer: "The Quartermaster" },
      { question: "Which champion has the ability 'R' - 'Cannon Barrage'?", answers: ["Gangplank", "Miss Fortune", "Graves", "Twisted Fate"], correct_answer: "Gangplank" },
      { question: "What is the name of the jungle monster that grants healing over time?", answers: ["Gromp", "Red Brambleback", "Blue Sentinel", "Krugs"], correct_answer: "Red Brambleback" },
      { question: "Which champion can summon 'Daisy'?", answers: ["Ivern", "Zyra", "Heimerdinger", "Malzahar"], correct_answer: "Ivern" },
      { question: "What is the cooldown of the Flash summoner spell?", answers: ["300 seconds", "270 seconds", "240 seconds", "210 seconds"], correct_answer: "300 seconds" },
      { question: "Which item grants the passive 'Spellblade'?", answers: ["Trinity Force", "Luden's Echo", "Infinity Edge", "Moonstone Renewer"], correct_answer: "Trinity Force" },
      { question: "What type of champion is Vayne classified as?", answers: ["Marksman", "Fighter", "Assassin", "Support"], correct_answer: "Marksman" },
      { question: "Which dragon grants bonus movement speed out of combat?", answers: ["Cloud Drake", "Infernal Drake", "Ocean Drake", "Hextech Drake"], correct_answer: "Cloud Drake" },
      { question: "Which champion has the ability 'Passive' - 'Living Forge'?", answers: ["Ornn", "Volibear", "Poppy", "Yorick"], correct_answer: "Ornn" },
      { question: "What is the name of the Rift Herald's weak point?", answers: ["Eye", "Core", "Backplate", "Heart"], correct_answer: "Eye" },
      { question: "Which champion is referred to as 'The Shadow of War'?", answers: ["Hecarim", "Nocturne", "Mordekaiser", "Shaco"], correct_answer: "Hecarim" },
      { question: "What is the ability that allows Jhin to reload his gun?", answers: ["Passive - Whisper", "Q - Dancing Grenade", "W - Deadly Flourish", "R - Curtain Call"], correct_answer: "Passive - Whisper" },
      { question: "Which champion's abilities scale with maximum health?", answers: ["Cho'Gath", "Nasus", "Tahm Kench", "Sion"], correct_answer: "Cho'Gath" },
      { question: "What is the name of the buff granted by Baron Nashor?", answers: ["Hand of Baron", "Baron's Blessing", "Empowered Assault", "Nashor's Fury"], correct_answer: "Hand of Baron" },
      { question: "Which champion's Q ability is 'Timewinder'?", answers: ["Ekko", "Zilean", "Viktor", "Jayce"], correct_answer: "Ekko" },
      { question: "What is the base gold cost of 'Infinity Edge'?", answers: ["3400 gold", "3200 gold", "3600 gold", "3300 gold"], correct_answer: "3400 gold" },
      { question: "Which champion can stealth allies with their W ability?", answers: ["Akshan", "Rengar", "Senna", "Evelynn"], correct_answer: "Akshan" },
      { question: "What is the bonus effect of Mountain Drake?", answers: ["Bonus armor and magic resist", "Healing regeneration", "True damage on abilities", "Attack speed"], correct_answer: "Bonus armor and magic resist" },
      { question: "Which champion has the ability 'Q' - 'Bouncing Bomb'?", answers: ["Ziggs", "Jinx", "Heimerdinger", "Corki"], correct_answer: "Ziggs" },
      { question: "Which champion is known as 'The Unforgiven'?", answers: ["Yasuo", "Zed", "Riven", "Irelia"], correct_answer: "Yasuo" },
      { question: "What is the maximum number of wards a player can place at a time?", answers: ["3", "2", "4", "5"], correct_answer: "3" },
      { question: "Which champion has the ability 'E' - 'Shuriken Flip'?", answers: ["Akali", "Kennen", "Zed", "Shen"], correct_answer: "Akali" },
      { question: "What is the cooldown reduction cap in League of Legends?", answers: ["40%", "50%", "30%", "45%"], correct_answer: "40%" },
      { question: "Which item provides the 'Lifeline' passive shield?", answers: ["Maw of Malmortius", "Sterak's Gage", "Guardian Angel", "Hexdrinker"], correct_answer: "Maw of Malmortius" }
    ]

  ABILITY_ICONS = [
    # You'll need to define ability icon data here
    # Example format:
    # { champion: "Ahri", ability_icon: "path_to_icon.png", options: ["Ahri", "Lux", "Annie", "Veigar"] }
  ]

  SKIN_SNIPPETS = [
    # You'll need to define skin snippet data here
    # Example format:
    # { champion: "Ezreal", snippet: "path_to_snippet.png", options: ["Ezreal", "Lux", "Caitlyn", "Jinx"] }
  ]

  SKIN_NAMES = [
    # You'll need to define skin name data here
    # Example format:
    # { champion: "Teemo", full_name: "Omega Squad Teemo", hidden_name: "Om_ga Sq__d T__mo" }
  ]

    def index
      @games = Game.all
    end

    def show
      @game = Game.find(params[:id])
      @user = current_user

      attempts_key = "#{@game.game_type}_plays_#{Date.today}_#{current_user.id}"
    
      # Now you can safely use the attempts_key and current_attempts variables
      current_attempts = Rails.cache.read(attempts_key).to_i
      Rails.logger.debug "Attempts key: #{attempts_key} - Current attempts: #{current_attempts}"
    

        case @game.game_type
        when 'quiz'
          handle_quiz_show
        when 'ability_guess'
          @game_data = Champion.ability_icon_data
          handle_ability_guess_show
        when 'skin_snippet'
          @game_data = Champion.skin_snippet_data
          handle_skin_snippet_show
        when 'skin_name'
          @game_data = Champion.skin_name_data
          handle_skin_name_show
        end
      end

      def submit_ability_guess_answer
        # Increment attempts for the ability icon game
        current_user.increment!(:ability_icon_attempts_today)
      
        # Logic for checking the selected ability guess
        selected_ability = params[:selected_ability]
        correct_ability = session[:current_ability][:champion] # Assuming you store the champion's name in session
      
        correct = selected_ability == correct_ability
        reward = calculate_reward(correct)
      
        current_user.increment!(:hextech_cores, reward) if reward > 0
        session[:current_ability] = nil  # Clear the session for the next question
      
        render json: {
          success: true,
          reward: reward,
          correct: correct,
          attempts: current_user.ability_icon_attempts_today
        }
      end

    
    
      def check_guess(guess)
        # Logic to check if the guess is correct (e.g., compare with the actual champion name)
        correct_ability = "CorrectChampionName" # Replace with actual logic
        guess == correct_ability
      end


      def submit_skin_snippet_answer
        current_user.increment!(:skin_snippet_attempts_today)
      
        submitted_skin = params[:submitted_skin]
        correct_skin = session[:current_snippet][:champion] # Assuming you store the champion's name in session
      
        correct = submitted_skin.downcase == correct_skin.downcase
        reward = calculate_reward(correct)
      
        current_user.increment!(:hextech_cores, reward) if reward > 0
        session[:current_snippet] = nil  # Clear the session for the next question
      
        render json: {
          success: true,
          reward: reward,
          correct: correct,
          attempts: current_user.skin_snippet_attempts_today
        }
      end


      def submit_answer
        case @game.game_type
        when 'quiz'
          handle_quiz_answer
        when 'ability_guess'
          handle_ability_guess_answer
        when 'skin_snippet'
          handle_skin_snippet_answer
        when 'skin_name'
          handle_skin_name_answer
        end
      end

      
      def handle_skin_name_answer
        submitted_name = params[:submitted_name]
        current_skin = session[:current_skin]
        @user = current_user
      
        # Increment attempts if under the limit
        if @user.skin_name_attempts_today < 5
          @user.increment!(:skin_name_attempts_today)
        end
      
        # Handle skin name comparison
        if submitted_name.present? && current_skin && current_skin[:full_name].present?
          correct = current_skin[:full_name].downcase == submitted_name.downcase
          reward = calculate_reward(correct)
      
          # Apply reward if correct
          if correct
            current_user.increment!(:hextech_cores, reward)
            session[:current_skin] = nil  # Clear the current skin for new challenge
          end
      
          # Turbo Stream update for correct/incorrect feedback and attempts count
          if request.format.turbo_stream?
            render turbo_stream: [
              turbo_stream.replace("feedback", partial: "games/feedback", locals: { correct: correct, reward: reward }),
              turbo_stream.replace("attempts-count-skin", partial: "games/attempts_count", locals: { attempts: @user.skin_name_attempts_today })
            ]
          else
            redirect_to game_path(@game) # Regular redirect for non-Turbo Stream requests
          end
        else
          render json: { success: false, message: "No skin name submitted" }, status: :unprocessable_entity
        end
      end
      def handle_skin_name_show
        return redirect_to games_path, alert: "No skin name data available" if @game_data.empty?
        
        # Fetch a random skin from the Skin model
        @skin = Skin.order('RANDOM()').first  # This will fetch a random skin
      
        # If the skin has a valid name, proceed
        if @skin && @skin.name.present?
          @icon_url = @skin.splash_art_centered  # Assuming splash_art is the URL field for the skin image
          @skin_name = @skin.name
          @masked_skin_name = mask_skin_name(@skin_name)
      
          # Store skin data in session
          session[:current_skin] = { full_name: @skin_name }  # Store the full name of the skin in the session
        else
          redirect_to games_path, alert: "No valid skin data available"
        end
      end
      
  
      # ABILITY SECTION

      def submit_guess
        Rails.logger.info "Params received: #{params.inspect}"
        Rails.logger.info "Current user: #{current_user.inspect}"
        Rails.logger.info "Session champion_id: #{session[:current_champion_id]}"
    
        begin
          respond_to do |format|
            format.json do
              unless current_user
                return render json: { success: false, message: "User not found" }, status: :unauthorized
              end
    
              if current_user.ability_guess_attempts_today >= 5
                return render json: { 
                  success: false, 
                  message: "You've reached your daily limit!", 
                  attempts: current_user.ability_guess_attempts_today 
                }, status: :unprocessable_entity
              end
              
              clicked_champion_id = params[:champion_id]
              unless clicked_champion_id
                return render json: { success: false, message: "No champion selected" }, status: :unprocessable_entity
              end
    
              unless session[:current_champion_id]
                return render json: { success: false, message: "No current champion in session" }, status: :unprocessable_entity
              end
              
              @champion = Champion.find(session[:current_champion_id])
              correct = @champion.id == clicked_champion_id.to_i
              
              # Calculate score and award hextech cores
              user_score = correct ? 1 : 0
              if user_score > 0
                current_user.increment!(:hextech_cores, user_score * 50)
              end
              current_user.increment!(:ability_guess_attempts_today)
              
              render json: {
          success: correct,
          message: correct ? "Correct! You earned 50 Hextech Cores!" : "Incorrect. Try again!",
          attempts: current_user.ability_guess_attempts_today,
          hextech_cores: current_user.hextech_cores
        }
            end
          end
        rescue => e
          Rails.logger.error "Error in submit_guess: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          render json: { 
            success: false, 
            message: "An error occurred: #{e.message}" 
          }, status: :internal_server_error
        end
      end
    
      def handle_ability_guess_show
        Rails.logger.info "Handling ability guess show"
        begin
          @ability = Ability.order('RANDOM()').first
          raise "No ability found" unless @ability
          
          @champion = @ability.champion
          raise "No champion found for ability" unless @champion
          
          session[:current_champion_id] = @champion.id
          @ability_name = @ability.name
          @icon_url = @ability.image
    
          Rails.logger.info "Set up ability guess: Ability=#{@ability.id}, Champion=#{@champion.id}"
        rescue => e
          Rails.logger.error "Error in handle_ability_guess_show: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          redirect_to games_path, alert: "Error loading ability game: #{e.message}"
        end
      end

def check_guess(guess)
  # Fetch the correct ability name from the session
  correct_ability = session[:current_ability][:name] # Assuming you store the ability name in session
  guess == correct_ability
end
      
      def load_game_data
          case @game.game_type
          when 'ability_guess'
            @game_data = Champion.ability_icon_data
          when 'skin_snippet'
            @game_data = Champion.skin_snippet_data
          when 'skin_name'
            @game_data = Champion.skin_name_data
          end
        end
        
      def set_game
        @game = Game.find(params[:id])
      end

      def check_daily_limit
        if current_user.quiz_attempts_today >= 5
          flash[:alert] = "You've reached your quiz limit for today."
          redirect_to games_path and return
        else
        end
      end
      
      
      def check_skin_name_game_limit
        if current_user.skin_name_attempts_today >= 5
          flash[:alert] = "You've reached your daily limit for the Skin Name Game."
          redirect_to games_path and return
        end
      end
      
      
      
# QUIZ SHOW SECTION
      def handle_quiz_show
      @current_question_index = session[:current_question_index] || 0
        
        # Ensure the question index is valid
        @current_question_index = @current_question_index % QUESTIONS.length

        @current_question = QUESTIONS[@current_question_index]  
        # Shuffle the QUESTIONS array for random order and store in session
        session[:shuffled_questions] = QUESTIONS.shuffle
      
        # Retrieve shuffled questions from session
        @shuffled_questions = session[:shuffled_questions]

        if @current_question_index < @shuffled_questions.length
          @question = @shuffled_questions[@current_question_index][:question]
          @answers = @shuffled_questions[@current_question_index][:answers]
          @correct_answer = @shuffled_questions[@current_question_index][:correct_answer]
        else
          flash[:notice] = "Quiz completed!"
          redirect_to root_path and return
        end
      
        # Pass the shuffled QUESTIONS constant to the view
        @questions = @shuffled_questions
        
      end

      def handle_quiz_answer
      current_question_index = session[:current_question_index] || 0

      @current_question = QUESTIONS[current_question_index]

      Rails.logger.info("Received parameters: #{params.inspect}")
      selected_answer = params[:selected_answer]
      question_index = params[:question_index].to_i

      # Increment the user's quiz attempts
      current_user.increment!(:quiz_attempts_today)
      self.check_daily_limit
      # Retrieve shuffled questions from session
      @shuffled_questions = session[:shuffled_questions]

      # Ensure the shuffled questions exist
      if @shuffled_questions.nil?
        Rails.logger.error("Shuffled questions not found in session.")
        render json: { success: false, error: "Session expired. Please restart the quiz." }, status: :unprocessable_entity and return
      end

      # Ensure the question index is valid
      if question_index < 0 || question_index >= @shuffled_questions.length
        Rails.logger.error("Invalid question index: #{question_index}")
        render json: { success: false, error: "Invalid question index." }, status: :unprocessable_entity and return
      end

      # Check if the selected answer is correct
      correct_answer = @shuffled_questions[question_index][:correct_answer]
      user_score = (selected_answer == correct_answer) ? 1 : 0

      # Increment the user's Hextech cores if the answer is correct
      if user_score > 0
        current_user.increment!(:hextech_cores, user_score * 50)
      end

      # Prepare the response data
      response_data = {
        success: true,
        attempts: current_user.quiz_attempts_today, # Return the updated attempts
        next_question: question_index + 1 < @shuffled_questions.length,
        question: @shuffled_questions[question_index + 1] || nil,
        correct_answer: @shuffled_questions[question_index + 1][:correct_answer] || nil,
        answers: @shuffled_questions[question_index + 1][:answers] || []
      }

      render json: response_data
    rescue StandardError => e
      Rails.logger.error("Error in submit_answer: #{e.message}")
      render json: { success: false, error: "An error occurred while processing your request." }, status: :internal_server_error
      end

     
      def calculate_reward(correct)
        correct ? 50 : 0
      end
    end


# SKIN SNIPPET SECTION

      def handle_skin_snippet_show
        return redirect_to games_path, alert: "No skin data available" if @game_data.empty?
      
        session[:current_snippet] ||= @game_data.sample
        @snippet = session[:current_snippet]
        @options = @snippet[:options]
      
        # Fetch the icon_url from the skin snippet data
        @icon_url = @snippet[:icon_url]  # Assuming that `@snippet` contains an `icon_url` field
      end


# ABILITY SECTION

      

# SKIN NAME SECTION


      # Helper method to replace random letters with underscores
      def mask_skin_name(name)
        masked_name = name.chars.map do |char|
          rand < 0.5 ? "_" : char  # 50% chance to replace with an underscore
        end.join
        masked_name
      end
      
      
     
      
      def calculate_reward(correct)
        if correct
          rand(@game.min_reward..@game.max_reward)
        else
          0
        end
      end
