
class BookInStock
  attr_reader :isbn                                      # Accessor method that can read the referenced value of @isbn 
  attr_accessor :price                                   # Accessor method that can both read and write to the value of @price 

  def initialize(isbn, price)                            # Passing arguments at initialization creates the value for both instance variables.
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents                                     # Rounds the Float price into a dollar-appropriate number. 
    (price * 100).round
  end

  def price_in_cents=(cents)                             # Takes value @price and changes it to argument-passed cents, dividing by 100. 
    @price = cents / 100.0
  end
  # ...
end

book = BookInStock.new("isbn1", 33.80)
puts "Price          = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"
book.price_in_cents = 1234                               # The value of @price is changed to the value of cents, which this line defines as 1234. 
puts "Price          = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"
