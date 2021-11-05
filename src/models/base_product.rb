require_relative '../modules/printable'

class BaseProduct
  include Printable

  def initialize(name:, price:, promotion_price: 0, promotion_units: 0)
    @name = name
    @price = price
    @promotion_price = promotion_price
    @promotion_units = promotion_units
    @purchased_quantity = 0
  end

  def item_summary
    ["#{pretty_name} #{pretty_quantity} #{pretty_price}", final_amount, discount]
  end

  def add_item
    @purchased_quantity += 1
  end

  private

  attr_accessor :name, :price, :purchased_quantity, :promotion_price, :promotion_units

  def pretty_name
    name.ljust(NAME_SPACING,' ')
  end

  def pretty_quantity
    purchased_quantity.round(2).to_s.ljust(QUANTITY_SPACING,' ')
  end

  def pretty_price
    "$#{final_amount.round(2)}".ljust(PRICE_SPACING,' ')
  end

  def final_amount
    return 0 if purchased_quantity <= 0
    (purchased_amount - discount).round(2)
  end

  def purchased_amount
    purchased_quantity * price
  end

  def discount
    return 0 if promotion_units <= 0
    valid_promotions = purchased_quantity / promotion_units
    no_discount_units = purchased_quantity - valid_promotions * promotion_units
    (purchased_amount - no_discount_units*price - valid_promotions * promotion_price).round(2)
  end
end
