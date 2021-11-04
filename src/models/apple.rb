require_relative './base_product'

class Apple < BaseProduct
  def initialize()
    super(name: 'Apple', price: 0.89)
  end
end
