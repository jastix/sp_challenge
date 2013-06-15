class OffersController < ApplicationController
  def new
    @offer = Offer.new
  end
  #TODO add action Create to validate offer

  def show
    @offers = Offer.find(offer_params)
  end

  private

  def offer_params
    params.require(:offer).permit(:uid, :pub0, :page)
  end
end
