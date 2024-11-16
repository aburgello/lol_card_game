class Type < ApplicationRecord
  has_many :champion_types
  has_many :champions, through: :champion_types
end
