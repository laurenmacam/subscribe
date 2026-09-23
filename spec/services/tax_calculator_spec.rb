RSpec.describe TaxCalculator do
  def fake_item(name:, price:, quantity: 1, imported: false)
    instance_double("BasketItem", name: name, price: price, quantity: quantity, imported: imported)
  end

  describe "#tax_by_category" do
    it "is zero for exempt products (book)" do
      item = fake_item(name: "book", price: 12.49)
      expect(described_class.new(item).tax_by_category).to eq(0)
    end

    it "is 10% rounded up to the nearest nickel for taxable products" do
      item = fake_item(name: "music CD", price: 14.99)
      expect(described_class.new(item).tax_by_category).to eq(1.50)
    end

    it "keeps the tax as is when it already lands on a nickel" do
      { 1.50 => 0.15, 3.00 => 0.30, 12.00 => 1.20, 14.50 => 1.45 }.each do |price, tax|
        item = fake_item(name: "music CD", price: price)
        expect(described_class.new(item).tax_by_category).to eq(tax)
      end
    end
  end

  describe "#tax_by_imported" do
    it "is zero when the item is not imported" do
      item = fake_item(name: "bottle of perfume", price: 18.99, imported: false)
      expect(described_class.new(item).tax_by_imported).to eq(0)
    end

    it "is 5% rounded up to the nearest nickel when imported" do
      item = fake_item(name: "bottle of perfume", price: 27.99, imported: true)
      expect(described_class.new(item).tax_by_imported).to eq(1.40)
    end
  end

  describe "#price_with_tax" do
    it "sums the shelf price with both applicable taxes" do
      item = fake_item(name: "imported bottle of perfume", price: 27.99, imported: true)
      expect(described_class.new(item).price_with_tax).to eq(32.19)
    end

    it "applies only the basic tax when the item is exempt but imported" do
      item = fake_item(name: "imported box of chocolates", price: 10.00, imported: true)
      expect(described_class.new(item).price_with_tax).to eq(10.50)
    end
  end

  describe "#total_price" do
    it "multiplies price_with_tax by quantity" do
      item = fake_item(name: "book", price: 12.49, quantity: 2)
      expect(described_class.new(item).total_price).to eq(24.98)
    end
  end
end