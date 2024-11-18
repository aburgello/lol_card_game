class Skin < ApplicationRecord
  belongs_to :champion


  def self.ransackable_attributes(auth_object = nil)
    ["champion_id", "created_at", "id", "loading_art", "name", "num", "splash_art", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["champion"]
  end
end
