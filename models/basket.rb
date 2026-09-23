class Basket
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def sales_taxes
    @items.sum { |item| item.total_tax * item.quantity }
  end

  def total
    @items.sum { |item| item.total_price }
  end
end