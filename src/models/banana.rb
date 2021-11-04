require_relative './base_product'

class Banana < BaseProduct
  def initialize()
    super(name: 'Banana', price: 0.99)
  end
end
