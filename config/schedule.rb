every :day, at: '12:00 am' do
  runner "User.update_all(quiz_attempts_today: 0, ability_guess_attempts_today: 0, skin_snippet_attempts_today: 0, skin_name_attempts_today: 0)"
end
