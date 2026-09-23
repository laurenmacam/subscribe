RSpec.describe BasketItem do
  describe "#full_name" do
    it "prefixes the name with 'imported' when the item is imported" do
      item = described_class.new("bottle of perfume", 27.99, 1, true)
      expect(item.full_name).to eq("imported bottle of perfume")
    end

    it "does not prefix the name when the item is not imported" do
      item = described_class.new("bottle of perfume", 18.99, 1, false)
      expect(item.full_name).to eq("bottle of perfume")
    end
  end

  describe "price calculation" do
    it "applies 10% basic tax for a non-imported, taxable item" do
      item = described_class.new("music CD", 14.99, 1, false)
      expect(item.total_price).to eq(16.49)
    end

    it "applies 5% import tax for an imported, exempt item" do
      item = described_class.new("box of chocolates", 10.00, 1, true)
      expect(item.total_price).to eq(10.50)
    end

    it "applies 10% basic tax and 5% import tax for an imported, taxable item" do
      item = described_class.new("bottle of perfume", 27.99, 1, true)
      expect(item.total_price).to eq(32.19)
    end

    it "applies neither tax for a non-imported, exempt item" do
      item = described_class.new("book", 12.49, 1, false)
      expect(item.total_price).to eq(12.49)
    end
  end
end