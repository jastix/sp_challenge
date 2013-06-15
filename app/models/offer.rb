class Offer
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :uid, :pub0, :page

  def initialize(attributes)
    self.uid = attributes[:uid]
    self.pub0 = attributes[:pub0]
    self.page = attributes[:page]
  end
end
