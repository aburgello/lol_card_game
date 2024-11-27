namespace :games do
  desc "Create default LoL games"
  task create: :environment do
    games = [
      {
        name: "LoL Knowledge Quiz",
        description: "Test your League of Legends knowledge",
        min_reward: 50,
        max_reward: 200,
        game_type: 'quiz',
        daily_plays_limit: 1
      },
      {
        name: "Ability Icon Challenge",
        description: "Guess the champion by their ability icon",
        min_reward: 50,
        max_reward: 200,
        game_type: 'ability_guess',
        daily_plays_limit: 1
      },
      {
        name: "Skin Detective",
        description: "Identify champions from skin snippets",
        min_reward: 50,
        max_reward: 200,
        game_type: 'skin_snippet',
        daily_plays_limit: 1
      },
      {
        name: "Skin Name Challenge",
        description: "Complete the hidden letters in skin names",
        min_reward: 50,
        max_reward: 200,
        game_type: 'skin_name',
        daily_plays_limit: 1
      }
    ]

    games.each do |game_data|
      game = Game.find_or_initialize_by(name: game_data[:name])
      game.update!(game_data)
      puts "Updated game: #{game.name}"
    end
  end
end