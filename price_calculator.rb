require_relative './src/services/bill_calculator_service'

def main
  puts "Please enter all the items purchased separated by a comma (example: milk, bread, bread, apple):"
  items = gets.chomp
  items = items.split(',').map { |item| item.strip.downcase }
  summary = BillCalculatorService.new.present_bill_summary(items)
  puts summary
end

main()
