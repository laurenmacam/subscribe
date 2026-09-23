require_relative "services/items_parser"
require_relative "models/basket"

begin
  file = File.read("tmp/input.txt")

  items = ItemsParser.parse(file)

  basket = Basket.new(items)

  basket.items.each do |item|
    puts "#{item.quantity} #{item.full_name}: #{'%.2f' % item.total_price}"
  end

  puts "Sales Taxes: #{'%.2f' % basket.sales_taxes}"
  puts "Total: #{'%.2f' % basket.total}"
rescue Errno::ENOENT
  puts "Input file not found: tmp/input.txt"
  exit 1
rescue StandardError => e
  puts "Failed to process basket: #{e.message}"
  exit 1
end



