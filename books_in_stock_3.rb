class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  def isbn                                      
    @isbn                                  # Returns exactly the value of this instance variable, and nothing else. 
  end
  def price
    @price
  end
  # ..
end

book = BookInStock.new("isbn1", 12.34)     # The values are passed as a string and float type parameter. 
puts "ISBN = #{book.isbn}"                 # we can access the instance variables @isbn and @price with the methods `isbn` and `price`. 
puts "Price = #{book.price}"

=begin

=> 
ISBN = isbn1
Price = 12.34                              

=end