class BaseProduct
  attr_accessor :name, :price, :purchased_quantity, :promotion_price, :promotion_units

  def initialize(name:, price:, promotion_price: 0, promotion_units: 0)
    @name = name
    @price = price
    @promotion_price = promotion_price
    @promotion_units = promotion_units
    @purchased_quantity = 0
  end

  def add_item
    @purchased_quantity += 1
  end

  def final_amount
    return 0 if purchased_quantity <= 0
    purchased_amount - discount
  end

  def purchased_amount
    purchased_quantity * price
  end

  def discount
    return 0 if promotion_units <= 0
    valid_promotions = purchased_quantity % promotion_units
    no_discount_units = purchased_quantity - valid_promotions * promotion_units
    purchased_amount - no_discount_units*price - valid_promotions * promotion_price
  end
end
