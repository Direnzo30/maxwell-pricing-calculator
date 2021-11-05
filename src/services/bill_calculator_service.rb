require_relative '../models/apple'
require_relative '../models/banana'
require_relative '../models/bread'
require_relative '../models/milk'
require_relative '../modules/printable'

class BillCalculatorService
  include Printable

  ALLOWED_PRODUCTS = %w[apple banana bread milk].freeze
  CLASS_MAPPING = {
    'apple' => Apple,
    'banana' => Banana,
    'bread'=> Bread,
    'milk' => Milk
  }.freeze

  def present_bill_summary(entry_items)
    items = calculate_bill_items(entry_items)
    prettify_summary(items)
  end

  private

  def calculate_bill_items(entry_items)
    items = {}
    entry_items.each do |item|
      if ALLOWED_PRODUCTS.include? item
        items[item] = CLASS_MAPPING[item].new unless items.has_key? item
        items[item].add_item
      end
    end
    items
  end

  def prettify_summary(items)
    result = "#{"Item".ljust(NAME_SPACING, ' ')} #{"Quantity".ljust(QUANTITY_SPACING, ' ')} #{"Price".ljust(PRICE_SPACING, ' ')}\n"
    result += "-"*(NAME_SPACING + QUANTITY_SPACING + PRICE_SPACING + 2) + "\n"
    total = 0
    savings = 0
    items.sort.to_h.each do |product_key, product_handler|
      label, amount, discount = product_handler.item_summary
      total += amount
      savings += discount
      result += "#{label}\n"
    end
    result += "\n"
    result += "Total price: $#{total.round(2)}\n"
    result += "You saved $#{savings.round(2)} today"
    result
  end
end
