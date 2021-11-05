require 'spec_helper'

RSpec.describe BaseProduct do

  def validate_product_summary(name:, quantity:, expected_amount:, expected_discount:)
    label, final_amount, discount = subject.item_summary
    expect(label).to eq("#{name.ljust(described_class::NAME_SPACING, ' ')} #{quantity.to_s.ljust(described_class::QUANTITY_SPACING, ' ')} #{"$#{final_amount}".ljust(described_class::PRICE_SPACING, ' ')}")
    expect(final_amount).to eq(expected_amount)
    expect(discount).to eq(expected_discount) 
  end

  let(:subject) { described_class.new(**params) }

  describe '#item_summary' do

    context 'when the product doesn\'t have promotions' do
      let(:params) do
        {
          name: 'My awesome product',
          price: 2.5
        }
      end

      it 'returns the summary without applying any discount' do
        5.times do
          subject.add_item
        end
        validate_product_summary(name: params[:name], quantity: 5, expected_amount: 12.5, expected_discount: 0)
      end
    end

    context 'when the product does have a promotion' do
      let(:params) do
        {
          name: 'Offer',
          price: 5.20,
          promotion_price: 10,
          promotion_units: 2
        }
      end

      it 'returns the summary with the promotion discount applied' do
        5.times do
          subject.add_item
        end
        validate_product_summary(name: params[:name], quantity: 5, expected_amount: 25.20, expected_discount: 0.80)
      end
    end
  end
end
