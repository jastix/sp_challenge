class OffersController < ApplicationController

  def new
  end

  def show
    @offers = Offer.find(offer_params)
  end

  #######
  private
  #######

  def offer_params
    params.require(:offer).permit(:uid, :pub0, :page, :locale, :appid,
                                  :device_id, :ip, :offer_types, :format, :timestamp)
  end
end
