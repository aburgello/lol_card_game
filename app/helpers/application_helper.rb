module ApplicationHelper
  def skin_gradient_style(rarity)
    case rarity.downcase
    when "mythic"
      "background: linear-gradient(to bottom, #7943ED, #5E2B99);"
    when "ultimate"
      "background: linear-gradient(to bottom, #FFA500, #CC8400);"
    when "legendary"
      "background: linear-gradient(to bottom, #FF3232, #B22222);"
    when "epic"
      "background: linear-gradient(to bottom, #00C8FF, #007BB5);"
    when "transcendent"
      "background: linear-gradient(to bottom, #A2A2D0, #6E6E96);"
    when "common"
      "background: linear-gradient(to bottom, #808080, #585858);"
    else
      "background: linear-gradient(to bottom, #0A1428, #091428);" # Default
    end
  end
end
