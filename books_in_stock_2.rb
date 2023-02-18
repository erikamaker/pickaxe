class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  def to_s                                       # We're redefining the built-in method to_s in the context of this class. to_s is for human readable outputs.
    "ISBN: #{@isbn}, price: #{@price}"
  end
end

b1 = BookInStock.new("isbn1", 3)                 # `puts` accepts the argument and outputs it. In this case, it's outputting the return value of b1.to_s. 
puts b1                                          # NOTE: Inspecting an object with `p` instead is used more for debugging.
b2 = BookInStock.new("isbn2", 3.14)
puts b2
b3 = BookInStock.new("isbn3", "5.67")
puts b3

b1 = BookInStock.new("isbn1", 3)

puts b1.to_s                                   
puts b2.to_s                                   
puts b3.to_s


=begin                                          # It's taking the arguments at initialization, and outputting their instance variables that we interpolated in the t_s method. 
                                        
=>

ISBN: isbn1, price: 3.0
ISBN: isbn2, price: 3.14
ISBN: isbn3, price: 5.67


=end