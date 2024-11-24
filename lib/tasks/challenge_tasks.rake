
namespace :challenges do
  desc "Create challenges for each champion type"
  task create_type_challenges: :environment do
    puts "Creating challenges for champion types..."

    Type.find_each do |type|
      challenge_name = "Find all #{type.name.pluralize}"
      
      # Check if a challenge for this type already exists
      challenge = Challenge.find_or_initialize_by(name: challenge_name)
      
      if challenge.new_record?
        challenge.progress_type = 'champion_specific' # Set the progress type for this kind of challenge
        challenge.save!
        puts "Created challenge: #{challenge.name}"
      else
        puts "Challenge already exists: #{challenge.name}"
      end
    end

    puts "Type challenges creation completed!"
  end
end
