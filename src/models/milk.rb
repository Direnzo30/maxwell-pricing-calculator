require_relative './base_product'

class Milk < BaseProduct
  def initialize()
    super(name: 'Milk', price: 3.97, promotion_units: 2, promotion_price: 5)
  end
end
