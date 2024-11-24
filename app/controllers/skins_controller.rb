class SkinsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @skins = current_user.user_skins.order(created_at: :desc).limit(5).includes(:skin).map(&:skin)
  end

  def add_skins
    selected_skins = []
    selected_skin_ids = []  # Track selected IDs within this batch
    rarity_counts = Hash.new(0)
    
    5.times do
      # Keep rolling until we find an available skin
      skin = nil
      attempts = 0
      max_attempts = 10  # Prevent infinite loops

      while skin.nil? && attempts < max_attempts
        roll = rand(1..3000)
        rarity = determine_rarity(roll)
        rarity_counts[rarity] += 1
        
        Rails.logger.info "Roll #{attempts + 1}: #{roll}, Selected Rarity: #{rarity}"
        
        # Try to find an available skin of the rolled rarity
        available_skins = Skin.where(rarity: rarity)
                            .where.not(id: current_user.skin_ids)
                            .where.not(id: selected_skin_ids)

        if available_skin = available_skins.order('RANDOM()').first
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

    # Add the selected skins to the user's collection in a transaction
    ActiveRecord::Base.transaction do
      selected_skins.each do |skin|
        # Double-check to prevent duplicates
        unless current_user.skins.exists?(skin.id)
          current_user.user_skins.create!(skin: skin)
        end
      end
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to skins_path }
    end
  end

  private

  def determine_rarity(roll)
    case roll
    when 1..1500    # 50% chance (1500/3000)
      'Common'
    when 1501..2250 # 25% chance (750/3000)
      'Epic'
    when 2251..2700 # 15% chance (450/3000)
      'Rare'
    when 2701..2916 # 6.67% chance (200/3000)
      'Legendary'
    when 2917..2970 # 2.33% chance (70/3000)
      'Mythic'
    when 2971..2995 # 0.83% chance (25/3000)
      'Ultimate'
    when 2996..3000 # 0.17% chance (5/3000)
      'Transcendent'
    end
  end

  def self.test_probabilities(iterations = 3000)
    results = Hash.new(0)
    
    iterations.times do
      roll = rand(1..3000)
      rarity = case roll
      when 1..1500 then 'Common'     # 50.00%
      when 1501..2250 then 'Epic'    # 25.00%
      when 2251..2700 then 'Rare'    # 15.00%
      when 2701..2900 then 'Legendary'# 6.67%
      when 2901..2970 then 'Mythic'  # 2.33%
      when 2971..2995 then 'Ultimate'# 0.83%
      when 2996..3000 then 'Transcendent'# 0.17%
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