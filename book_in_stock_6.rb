class BookInStock
  attr_reader :isbn                    # will only access to READ the value. 
  attr_accessor :price                 # will access to both READ and WRITE TO the value. 

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  # ...
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN      = #{book.isbn}"
puts "Price     = #{book.price}"
book.price = book.price * 0.75        # discount price
puts "New price = #{book.price}"
