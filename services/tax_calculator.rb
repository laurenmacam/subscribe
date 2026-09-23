class TaxCalculator
  EXEMPT_KEYWORDS = %w[book chocolate chocolates pills headache].freeze
  NICKEL = 5
  BASIC_RATE = 10
  IMPORT_RATE = 5

  def initialize(item)
    @item = item
  end

  def tax_by_category
    return 0 if exempt?(@item.name)
    tax_for(BASIC_RATE)
  end

  def tax_by_imported
    return 0 unless @item.imported
    tax_for(IMPORT_RATE)
  end

  def price_with_tax
    (@item.price + tax_by_category + tax_by_imported).round(2)
  end

  def total_price
    (price_with_tax * @item.quantity).round(2)
  end

  private

  def exempt?(name)
    EXEMPT_KEYWORDS.any? { |kw| name.downcase.include?(kw) }
  end

  def tax_for(rate)
    price_in_cents = (@item.price * 100).round
    nickels = (price_in_cents * rate).ceildiv(100 * NICKEL)

    nickels * NICKEL / 100.0
  end
end
