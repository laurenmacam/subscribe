require "spec_helper"

RSpec.describe Basket do
  describe "unit behavior" do
    it "sums total_tax * quantity for sales_taxes" do
      items = [
        BasketItem.new("book", 12.49, 2, false),
        BasketItem.new("music CD", 14.99, 1, false)
      ]

      basket = described_class.new(items)

      expect(basket.sales_taxes.round(2)).to eq(1.50)
    end

    it "sums total_price across all items" do
      items = [
        BasketItem.new("book", 12.49, 2, false),
        BasketItem.new("music CD", 14.99, 1, false)
      ]

      basket = described_class.new(items)

      expect(basket.total.round(2)).to eq(41.47)
    end

    it "returns zero totals for an empty basket" do
      basket = described_class.new([])

      expect(basket.sales_taxes).to eq(0)
      expect(basket.total).to eq(0)
    end
  end

  describe "integration with the problem statement's test baskets" do
    def basket_from_text(text)
      described_class.new(ItemsParser.parse(text))
    end

    context "with basket 1 (books, CD, chocolate)" do
      let(:input) do
        <<~BASKET
          2 book at 12.49
          1 music CD at 14.99
          1 chocolate bar at 0.85
        BASKET
      end

      subject(:basket) { basket_from_text(input) }

      it { expect(basket.sales_taxes.round(2)).to eq(1.50) }
      it { expect(basket.total.round(2)).to eq(42.32) }
    end

    context "with basket 2 (imported chocolates and perfume)" do
      let(:input) do
        <<~BASKET
          1 imported box of chocolates at 10.00
          1 imported bottle of perfume at 47.50
        BASKET
      end

      subject(:basket) { basket_from_text(input) }

      it { expect(basket.sales_taxes.round(2)).to eq(7.65) }
      it { expect(basket.total.round(2)).to eq(65.15) }
    end

    context "with basket 3 (mixed imported and non-imported items)" do
      let(:input) do
        <<~BASKET
          1 imported bottle of perfume at 27.99
          1 bottle of perfume at 18.99
          1 packet of headache pills at 9.75
          3 imported boxes of chocolates at 11.25
        BASKET
      end

      subject(:basket) { basket_from_text(input) }

      it { expect(basket.sales_taxes.round(2)).to eq(7.90) }
      it { expect(basket.total.round(2)).to eq(98.38) }
    end
  end
end