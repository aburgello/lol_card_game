class RegionsController < ApplicationController
  def index
    @regions = Region.all
  end

  def show
    @region = Region.find(params[:id])

    if @region.name == "Runeterra"
      @region.video_backdrop = random_video_backdrop
    else
      @video_backdrop = @region.video_backdrop
    end
  end

  private

  def random_video_backdrop
    video_backdrops = [
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/7feffff28f5a4df3f58438b83d4553b37ae647e0.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d02e1a8e54aa5b4ea0bcbb430c5e1bb697400fa5.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/d00f9e798c7e63fed1eaa8b92770f280d0c7f241.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/903a0dc3286518114b68113d0778e5299a26a729.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/9648da1fe76a45096b7095940d7991269d97d351.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/2b8b859578a41fc8a9272dacc0bdd6405a248c10.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/329c91313054076a869a6ceb95c995107320e334.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/670a63d489e907098afeafd2ce42a81e8e64bfcb.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/36c564338d66ac2000a3d6c091dd78c443230623.webm",
      "https://cmsassets.rgpub.io/sanity/files/dsfx7636/universe/84d14187e66ee28277609d55a3db93b96ae2a34c.webm"
    ]
    video_backdrops.sample
  end
end
