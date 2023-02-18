class BookInStock
  attr_reader :isbn, :price                 #attr_reader creates the methods that we otherwise individually wrote in example 3. 
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  # ..
end

book = BookInStock.new("isbn1", 12.34)

puts "ISBN = #{book.isbn}"                  # With attr_reader, they're already made for you through its one-line-implementation. 
puts "Price = #{book.price}"


=begin                                      # Pudding. 
    
=>
ISBN = isbn1
Price = 12.34                               # Proof. 

=end