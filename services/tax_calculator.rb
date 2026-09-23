class TaxCalculator
  EXEMPT_KEYWORDS = %w[book chocolate chocolates pills headache].freeze
  NICKEL = 0.05
  BASIC_RATE = 0.10
  IMPORT_RATE = 0.05

  def initialize(item)
    @item = item
  end

  def tax_by_category
    return 0 if exempt?(@item.name)
    round_up_to_nickel(@item.price * BASIC_RATE)
  end

  def tax_by_imported
    return 0 unless @item.imported
    round_up_to_nickel(@item.price * IMPORT_RATE)
  end

  def price_with_tax
    (@item.price + tax_by_category + tax_by_imported).round(2)
  end

  def total_price
    price_with_tax * @item.quantity
  end

  private

  def exempt?(name)
    EXEMPT_KEYWORDS.any? { |kw| name.downcase.include?(kw) }
  end

  def round_up_to_nickel(amount)
    ((amount / NICKEL).ceil * NICKEL).round(2)
  end
end