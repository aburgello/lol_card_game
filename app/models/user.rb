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
# Check if a user owns a specific skin
def owns_skin?(skin)
  skins.include?(skin)
end
end
