class Champion < ApplicationRecord
  has_many :skins, dependent: :destroy
  has_many :abilities, dependent: :destroy
  has_many :champion_types
  has_many :types, through: :champion_types
  belongs_to :region, optional: true
  has_many :user_champions, class_name: 'UserChampion'
  has_many :users, through: :user_champions
  validates :name, :title, presence: true
  
  def self.ability_icon_data
    all_champions = includes(:abilities).to_a
    
    all_champions.map do |champion|
      ability = champion.abilities.sample
      next unless ability&.image

      wrong_options = all_champions.reject { |c| c.id == champion.id }.sample(3).map(&:name)
      options = (wrong_options + [champion.name]).shuffle

      {
        champion: champion.name,
        ability_icon: ability.image,
        ability_name: ability.name,
        options: options
      }
    end.compact
  end

  def self.skin_snippet_data
    all_champions = includes(:skins).to_a
    
    all_champions.map do |champion|
      skin = champion.skins.sample
      next unless skin&.splash_art

      wrong_options = all_champions.reject { |c| c.id == champion.id }.sample(3).map(&:name)
      options = (wrong_options + [champion.name]).shuffle

      {
        champion: champion.name,
        snippet: skin.splash_art,
        skin_name: skin.name,
        options: options
      }
    end.compact
  end

  def self.skin_name_data
    all_champions = includes(:skins).to_a
    
    all_champions.flat_map do |champion|
      champion.skins.map do |skin|
        next unless skin.name.present?
        
        hidden_name = generate_hidden_name(skin.name)
        
        {
          champion: champion.name,
          full_name: skin.name,
          hidden_name: hidden_name
        }
      end
    end.compact
  end

  private

  def self.generate_hidden_name(name)
    # Hide ~40% of letters randomly, keeping spaces intact
    name.chars.map do |char|
      if char == ' '
        char
      else
        rand < 0.4 ? '_' : char
      end
    end.join
  end
end
