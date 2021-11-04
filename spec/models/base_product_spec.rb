require 'spec_helper'

RSpec.describe BaseProduct do
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

        label, final_amount, discount = subject.item_summary
        expect(label).to eq("#{params[:name].ljust(described_class::NAME_SPACING, ' ')} #{5.to_s.ljust(described_class::QUANTITY_SPACING, ' ')} #{"$#{params[:price]}".ljust(described_class::PRICE_SPACING, ' ')}")
        expect(final_amount).to eq(12.5)
        expect(discount).to eq(0) 
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

        label, final_amount, discount = subject.item_summary
        expect(label).to eq("#{params[:name].ljust(described_class::NAME_SPACING, ' ')} #{5.to_s.ljust(described_class::QUANTITY_SPACING, ' ')} #{"$#{params[:price]}".ljust(described_class::PRICE_SPACING, ' ')}")
        expect(final_amount).to eq(25.20)
        expect(discount).to eq(0.80)
      end
    end
  end
end