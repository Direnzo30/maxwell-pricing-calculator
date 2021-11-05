require 'spec_helper'

RSpec.describe BillCalculatorService do

  def bill_header
    "#{"Item".ljust(described_class::NAME_SPACING, ' ')} #{"Quantity".ljust(described_class::QUANTITY_SPACING, ' ')} #{"Price".ljust(described_class::PRICE_SPACING, ' ')}\n" +
    "-"*(described_class::NAME_SPACING + described_class::QUANTITY_SPACING + described_class::PRICE_SPACING + 2) + "\n"
  end

  describe '#present_bill_summary' do
    context 'when there are valid entries' do
      it 'calculates the summary for the allowed products' do
        entry = %w[milk milk random bread banana not_allowed bread bread bread funny milk apple]
        expect(subject.present_bill_summary(entry)).to eq(
          "Item            Quantity   Price       \n" +
          "---------------------------------------\n" +
          "Apple           1          $0.89       \n" +
          "Banana          1          $0.99       \n" +
          "Bread           4          $8.17       \n" +
          "Milk            3          $8.97       \n" +
          "\n" +
          "Total price: $19.02\n" +
          "You saved $3.45 today"
        ) 
      end
    end
    context "when there are no valid entries" do
      it 'returns a summary with empty values' do
        entry = %w[bad music empty awesome potato]
        expect(subject.present_bill_summary(entry)).to eq(
          "Item            Quantity   Price       \n" +
          "---------------------------------------\n" +
          "\n" +
          "Total price: $0\n" +
          "You saved $0 today"
        ) 
      end
    end
  end
end
