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

  def rarity_color_class(rarity)
    case rarity.downcase
    when 'common'
      'text-gray-400'
    when 'epic'
      'text-blue-400'
    when 'rare'
      'text-yellow-400'
    when 'legendary'
      'text-red-400'
    when 'mythic'
      'text-purple-400'
    when 'ultimate'
      'text-orange-400'
    when 'transcendent'
      'text-slate-400'
    else
      'text-slate-400'
    end
  end

  def progress_bar_color(percentage)
    case percentage
    when 0..20
      '#C8AA6E'  # Original gold
    when 21..40
      '#B8B36B'  # Gold-lime mix
    when 41..60
      '#A8BC68'  # Lighter lime
    when 61..75
      '#98C565'  # Lime
    when 76..85
      '#88CE62'  # Lime-green
    when 86..95
      '#78D75F'  # Light green
    else
      '#68E05C'  # Full green
    end
  end
end
