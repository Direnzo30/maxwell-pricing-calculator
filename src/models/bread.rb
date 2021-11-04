require_relative './base_product'

class Bread < BaseProduct
  def initialize()
    super(name: 'Bread', price: 2.17, promotion_units: 3, promotion_price: 6)
  end
end
