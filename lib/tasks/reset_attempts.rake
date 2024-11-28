namespace :reset do
  desc "Reset daily game attempts"
  task :attempts => :environment do
    User.update_all( quiz_attempts_today: 0, ability_guess_attempts_today: 0, skin_snippet_attempts_today: 0, skin_name_attempts_today: 0)
    puts "User attempts have been reset."
  end
end
