class ChampionType < ApplicationRecord
  belongs_to :champion
  belongs_to :type
end
