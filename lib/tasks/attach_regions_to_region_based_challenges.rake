namespace :challenges do
  desc "Attach regions to region-based challenges"
  task attach_regions: :environment do
    Challenge.find_each do |challenge|
      if challenge.region_based?
        # Extract the region name from the challenge name
        region_name = challenge.name.match(/Collect all (.+) Champions/)[1]
        
        # Find the region by name
        region = Region.find_by(name: region_name)
        
        if region
          # Update the challenge with the region ID
          challenge.update(region_id: region.id)
          Rails.logger.info "Challenge #{challenge.id}: Attached to region #{region_name}"
        else
          Rails.logger.warn "Region not found for challenge #{challenge.id}: #{region_name}"
        end
      end
    end
  end
end
