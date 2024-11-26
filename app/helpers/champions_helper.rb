module ChampionsHelper
  def get_skin_media_data(skin)
    # Map of special skins to their webm URLs
    special_skins = {
      "Risen Legend Ahri" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ahri/skins/skin86/animatedsplash/ahri_skin86_centered.skins_ahri_hol.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ahri/skins/skin86/animatedsplash/ahri_skin86_uncentered.skins_ahri_hol.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ahri/skins/skin86/animatedsplash/ahri_skin86_card.skins_ahri_hol.webm"
      },
      "Pulsefire Ezreal" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ezreal/skins/skin05/animatedsplash/ezreal_skin5_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ezreal/skins/skin05/animatedsplash/ezreal_skin5_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/ezreal/skins/skin05/animatedsplash/ezreal_skin05_card.webm"
      },
      "Elementalist Lux" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/lux/skins/skin07/animatedsplash/lux_skin7_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/lux/skins/skin07/animatedsplash/lux_skin7_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/lux/skins/skin07/animatedsplash/lux_skin07_card.webm"
      },
      "Gun Goddess Miss Fortune" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/missfortune/skins/skin16/animatedsplash/missfortune_skin16_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/missfortune/skins/skin16/animatedsplash/missfortune_skin16_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/missfortune/skins/skin16/animatedsplash/missfortune_skin16_card.webm"
      },
      "Soul Fighter Samira" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/samira/skins/skin30/animatedsplash/samira_skin30_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/samira/skins/skin30/animatedsplash/samira_skin30_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/samira/skins/skin30/animatedsplash/samira_skin30_card.webm"
      },
      "K/DA ALL OUT Seraphine Indie" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin01/animatedsplash/seraphine_skin1_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin01/animatedsplash/seraphine_skin1_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin01/animatedsplash/seraphine_skin1_centered.webm"
      },
      "K/DA ALL OUT Seraphine Rising Star" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/animatedsplash/seraphine_skin2_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/animatedsplash/seraphine_skin2_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin02/animatedsplash/seraphine_skin2_centered.webm"
      },
      "K/DA ALL OUT Seraphine Superstar" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/animatedsplash/seraphine_skin3_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/animatedsplash/seraphine_skin3_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/seraphine/skins/skin03/animatedsplash/seraphine_skin3_centered.webm"
      },
      "DJ Sona" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/sona/skins/skin06/animatedsplash/sona_skin6_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/sona/skins/skin06/animatedsplash/sona_skin6_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/sona/skins/skin06/animatedsplash/sona_skin06_card.webm"
      },
      "Spirit Guard Udyr" => {
        centered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/udyr/skins/skin03/animatedsplash/udyr_skin3_centered.webm",
        uncentered: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/udyr/skins/skin03/animatedsplash/udyr_skin3_uncentered.webm",
        loading_art: "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/assets/characters/udyr/skins/skin03/animatedsplash/udyr_skin03_card.webm"
      }
    }

    if special_skins[skin.name]
      {
        type: 'video',
        centered_url: special_skins[skin.name][:centered],
        uncentered_url: special_skins[skin.name][:uncentered],
        loading_art_url: special_skins[skin.name][:loading_art]
      }
    else
      {
        type: 'image',
        centered_url: skin.splash_art_centered,
        uncentered_url: skin.splash_art,
        loading_art_url: skin.loading_art
      }
    end
  end
end