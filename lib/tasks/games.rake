namespace :games do
  desc "Create default LoL games"
  task create: :environment do
    games = [
      {
        name: "Summoner's Wisdom",
        description: "Test your League of Legends knowledge",
        min_reward: 50,
        max_reward: 200,
        game_type: 'quiz',
        daily_plays_limit: 7
      },
      {
        name: "Abilities in Action",
        description: "Guess the champion by their ability",
        min_reward: 50,
        max_reward: 200,
        game_type: 'ability_guess',
        daily_plays_limit: 7
      },
      {
        name: "Skin Detective",
        description: "Identify the champion from the skin snippet",
        min_reward: 50,
        max_reward: 200,
        game_type: 'skin_snippet',
        daily_plays_limit: 7
      },
      {
        name: "Champion Skin Quest",
        description: "Complete the name of the skin",
        min_reward: 50,
        max_reward: 200,
        game_type: 'skin_name',
        daily_plays_limit: 7
      }
    ]

    games.each do |game_data|
      game = Game.find_or_initialize_by(name: game_data[:name])
      game.update!(game_data)
      puts "Updated game: #{game.name}"
    end
  end
end