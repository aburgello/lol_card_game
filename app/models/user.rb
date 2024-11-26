class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :username, presence: true, uniqueness: true
def admin?
  self.admin
end
has_many :user_skins
has_many :skins, through: :user_skins
has_many :collections
has_many :collected_skins, through: :collections, source: :skin
has_many :user_regions, dependent: :destroy
has_many :discovered_regions, through: :user_regions, source: :region
has_many :user_challenges
has_many :challenges, through: :user_challenges
has_many :user_champions, class_name: 'UserChampion'
has_many :champions, through: :user_champions
validates :hextech_cores, numericality: { greater_than_or_equal_to: 0 }

# Check if a user owns a specific skin
def owns_skin?(skin)
  skins.include?(skin)
end

def champion_completion_status(champion)
  total_skins = champion.skins.count
  owned_skins = skins.where(champion: champion).count
  {
    owned: owned_skins,
    total: total_skins,
    completed: owned_skins == total_skins,
    percentage: total_skins.zero? ? 0 : (owned_skins.to_f / total_skins * 100).round
  }
end

def region_completion_status(region)
  champions = Champion.where(region: region)
  completed = champions.count { |champion| champion_completion_status(champion)[:completed] }
  {
    completed_champions: completed,
    total_champions: champions.count,
    percentage: champions.count.zero? ? 0 : (completed.to_f / champions.count * 100).round
  }
end
end
