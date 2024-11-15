class Champion < ApplicationRecord
  has_many :skins, dependent: :destroy
  has_many :abilities, dependent: :destroy

  validates :name, :title, presence: true
end
