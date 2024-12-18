class UnlockChampionsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.includes(:skins, :user_champions, :champions, :user_regions).find(user_id)
    process_user_unlocks(user)
  end

  private

  def process_user_unlocks(user)
    owned_skins_by_champion = user.skins.group(:champion_id).count

    Champion.includes(:skins, :region, :types).find_each do |champion|
      total_champion_skins = champion.skins.count
      owned_champion_skins = owned_skins_by_champion[champion.id] || 0

      if owned_champion_skins == total_champion_skins && !user.champions.exists?(champion.id)
        unlock_champion_for_user(user, champion)
        discover_region_for_user(user, champion.region)
        update_challenge_progress(user, champion)
        award_hextech_cores(user, 5000)
      end
    end
  end

  def unlock_champion_for_user(user, champion)
    UserChampion.create!(user: user, champion: champion)
    Rails.logger.info "Unlocked champion: #{champion.name} for user: #{user.id}"

    champion.skins.each do |skin|
      if user.owns_skin?(skin) && !user.collected_skins.exists?(skin.id)
        user.collections.create!(skin: skin)
        Rails.logger.info "Added skin: #{skin.name} to collection for user: #{user.id}"
      end
    end
  end

  def award_hextech_cores(user, amount)
    user.transaction do
      user.hextech_cores += amount
      user.save!
    end
    Rails.logger.info "Awarded #{amount} Hextech Cores to #{user.name}"
  end

  def discover_region_for_user(user, region)
    return unless region
    return if user.discovered_regions.exists?(region.id)

    UserRegion.create!(user: user, region: region)
    Rails.logger.info "Discovered region: #{region.name} for user: #{user.id}"
  end

  def update_challenge_progress(user, champion)
    update_region_challenges(user, champion)
    update_type_challenges(user, champion)
  end

  def update_region_challenges(user, champion)
    return unless champion.region

    challenges = Challenge.region_based
                        .joins(:skins)
                        .where(skins: { champion_id: champion.id })
                        .distinct

    update_challenges_progress(user, challenges)
  end

  def update_type_challenges(user, champion)
    champion.types.each do |type|
      challenges = Challenge.champion_specific
                          .joins(:skins)
                          .where(skins: { champion_id: champion.id })
                          .distinct

      update_challenges_progress(user, challenges)
    end
  end

  def update_challenges_progress(user, challenges)
    challenges.each do |challenge|
      user_challenge = UserChallenge.find_or_initialize_by(
        user: user,
        challenge: challenge
      )

      progress = challenge.progress_for_user(user)
      user_challenge.update!(
        progress: progress[:current],
        completed: progress[:current] == progress[:total]
      )
    end
  end

  rescue_from(ActiveRecord::RecordInvalid) do |exception|
    Rails.logger.error "Failed to process champion unlocks: #{exception.message}"
    Rollbar.error(exception) if defined?(Rollbar)
    raise exception
  end
end
