class Region < ApplicationRecord
  has_many :champions
  has_many :user_regions, dependent: :destroy
  has_many :users, through: :user_regions
  validates :name, presence: true, uniqueness: true
end
