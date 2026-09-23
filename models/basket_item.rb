class BasketItem
  require_relative "../services/tax_calculator"

  attr_accessor :name, :price, :quantity, :imported

  def initialize(name, price, quantity, imported)
    @name = name
    @price = price
    @quantity = quantity
    @imported = imported
  end

  def tax_by_category
    calculator.tax_by_category
  end

  def tax_by_imported
    calculator.tax_by_imported
  end

  def total_tax
    tax_by_category + tax_by_imported
  end

  def price_with_tax
    calculator.price_with_tax
  end

  def total_price
    calculator.total_price
  end

  def full_name
    "#{@imported ? 'imported ' : ''}#{name}"
  end

  private 

  def calculator
    TaxCalculator.new(self)
  end
end