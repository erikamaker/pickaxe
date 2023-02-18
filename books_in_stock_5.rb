class BookInStock
  attr_reader :isbn, :price                # accessor method to create references for the variables assigned to @isbn and @price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  def price=(new_price)                    # getter method that accepts 
    @price = new_price
  end
  # ...
end
  
book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75             # The method .price= is an assignment invoking the price=() method. Here, it's reassigning the original price value to equal itself multiplied by .75. 
puts "New price = #{book.price}"           # Because :price created the accessor method for local variable price, we have updated the instance variable @price's value by passing the above as an argument.




=begin

=>
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998

=end 