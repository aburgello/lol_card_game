class Skin < ApplicationRecord
  belongs_to :champion
  has_many :user_skins
  has_many :users, through: :user_skins
  has_many :collections
  has_many :users, through: :collections
  def self.ransackable_attributes(auth_object = nil)
    ["champion_id", "created_at", "id", "loading_art", "name", "num", "splash_art", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["champion"]
  end
end
