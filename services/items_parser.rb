module ItemsParser
  require_relative "../models/basket_item"

  def self.parse(file)
    result = Array.new()

    file.split("\n").map do |line|
      next if line.strip.empty?
      result << parse_line(line)
    rescue StandardError => e
      puts "Failed to parse line \"#{line}\": #{e.message}"
    end

    result
  end

  def self.parse_line(line)
    product_splited = line.split(" ")

    quantity = product_splited.shift
    price = product_splited.pop
    
    product_splited.delete("at")

    imported = false

    if product_splited.include?("imported")
      imported = true
      product_splited.delete("imported")
    end

    name = product_splited.join(" ")

    BasketItem.new(name, price.to_f, quantity.to_i, imported)
  end
end