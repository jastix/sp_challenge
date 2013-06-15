class OffersController < ApplicationController
  def new
  end

  def show
    @offers = Offer.new(offer_params)
  end

  private

  def offer_params
    params.require(:offer).permit(:uid, :pub0, :page)
  end
end
