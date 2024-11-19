class Champion < ApplicationRecord
  has_many :skins, dependent: :destroy
  has_many :abilities, dependent: :destroy
  has_many :champion_types
  has_many :types, through: :champion_types

  validates :name, :title, presence: true
end
