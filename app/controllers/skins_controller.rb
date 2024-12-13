class SkinsController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @skins = current_user.user_skins.order(created_at: :desc).limit(5).includes(:skin).map(&:skin)
  end

  def add_skins
    cost_per_roll = 10
    total_cost = cost_per_roll * 5

    if current_user.hextech_cores < total_cost
      flash[:alert] = "You do not have enough Hextech Cores to roll for skins."
      redirect_to skins_path and return
    end

    current_user.update!(hextech_cores: current_user.hextech_cores - total_cost)


    selected_skins = []
    selected_skin_ids = []  # Track selected IDs within this batch
    rarity_counts = Hash.new(0)

    5.times do
      # Keep rolling until we find an available skin
      skin = nil
      attempts = 0
      max_attempts = 10  # Prevent infinite loops

      while skin.nil? && attempts < max_attempts
        roll = rand(1..6000)
        rarity = determine_rarity(roll)
        rarity_counts[rarity] += 1

        Rails.logger.info "Roll #{attempts + 1}: #{roll}, Selected Rarity: #{rarity}"

        # Try to find an available skin of the rolled rarity
        available_skins = Skin.where(rarity: rarity)
                            .where.not(id: current_user.skin_ids)
                            .where.not(id: selected_skin_ids)

        if available_skin = available_skins.order("RANDOM()").first
          skin = available_skin
          selected_skins << skin
          selected_skin_ids << skin.id
          Rails.logger.info "Added skin: #{skin.name} (#{skin.rarity})"
        else
          Rails.logger.info "No available skin found for rarity: #{rarity}, rerolling..."
          attempts += 1
        end
      end

      if attempts >= max_attempts
        Rails.logger.warn "Max reroll attempts reached for one slot"
      end
    end

    Rails.logger.info "Rarity Distribution this roll: #{rarity_counts.inspect}"
    Rails.logger.info "Selected skins: #{selected_skins.map { |s| "#{s.name} (#{s.rarity})" }.join(', ')}"

    ActiveRecord::Base.transaction do
      selected_skins.each do |skin|
        unless current_user.skins.exists?(skin.id)
          current_user.user_skins.create!(skin: skin)
        end
      end
    end
    UnlockChampionsJob.set(wait: 1.second).perform_later(current_user.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to skins_path }
    end
  end

  private

  def determine_rarity(roll)
    case roll
    when 1..3000      # 50% chance (3000/6000)
      "Common"
    when 3001..4500   # 25% chance (1500/6000)
      "Epic"
    when 4501..5400   # 15% chance (900/6000)
      "Rare"
    when 5401..5832   # 6.67% chance (400/6000)
      "Legendary"
    when 5833..5946   # 2.33% chance (140/6000)
      "Mythic"
    when 5947..5991   # 0.67% chance (40/6000)
      "Ultimate"
    when 5992..5995   # 0.2% chance (14/6000)
      "Exalted"
    when 5996..6000   # 0.1% chance (6/6000)
      "Transcendent"
    end
  end


  def self.test_probabilities(iterations = 3000)
    results = Hash.new(0)

    iterations.times do
      roll = rand(1..3000)
      rarity = case roll
      when 1..1500    # 50% chance (1500/3000)
        "Common"
      when 1501..2250 # 25% chance (750/3000)
        "Epic"
      when 2251..2700 # 15% chance (450/3000)
        "Rare"
      when 2701..2916 # 6.67% chance (200/3000)
        "Legendary"
      when 2917..2970 # 2.33% chance (70/3000)
        "Mythic"
      when 2971..2990 # 0.67% chance (20/3000)
        "Ultimate"
      when 2991..2997 # 0.2% chance (7/3000)
        "Exalted"
      when 2998..3000 # 0.1% chance (3/3000)
        "Transcendent"
      end
      results[rarity] += 1
    end

    results.each do |rarity, count|
      percentage = (count.to_f / iterations * 100).round(3)
      puts "#{rarity}: #{count} times (#{percentage}%)"
    end

    puts "\nExpected probabilities:"
    puts "Common: 50%"
    puts "Epic: 25%"
    puts "Rare: 15%"
    puts "Legendary: 6.67%"
    puts "Mythic: 2.33%"
    puts "Ultimate: 0.83%"
    puts "Transcendent: 0.17%"

    results
  end
end
