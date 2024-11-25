class Champion < ApplicationRecord
  has_many :skins, dependent: :destroy
  has_many :abilities, dependent: :destroy
  has_many :champion_types
  has_many :types, through: :champion_types
  belongs_to :region, optional: true
  has_many :user_champions, class_name: 'UserChampion'
  has_many :users, through: :user_champions
  validates :name, :title, presence: true
  
end
