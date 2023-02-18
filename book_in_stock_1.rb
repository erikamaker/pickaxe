class BookInStock
    def initialize(isbn, price)
        @isbn = isbn
        @price = Float(price)
    end
end

b1 = BookInStock.new("isbn1", 3)
p b1                                          # Using `p` vs `puts` allows us to inspect the content (state). It also displays its unique hexadecimal code / class name. 

b2 = BookInStock.new("isbn2", 3.14)         
puts b2                                       # Doing it this way ONLY prints the object's unique identifying hexadecimal code trailing its class name. 

b3 = BookInStock.new("isbn3", "5.67")
p b3




b1 = BookInStock.new("isbn1", 3)

puts b1.to_s                                   # `puts` accepts the argument and outputs it. In this case, it's outputting the return value of b1.to_s. 
puts b2.to_s                                   # It's taking the arguments at initialization, and outputting their instance variables that we interpolated in the t_s method. 
puts b3.to_s

