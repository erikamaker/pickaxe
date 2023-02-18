class BookInStock
  def initialize(isbn, price)                   # With no methods to access the state
    @isbn = isbn
    @price = Float(price)
  end
end
    
b1 = BookInStock.new("isbn1", 3)    
puts b1                                         # Sending `puts` only returns its unique
b2 = BookInStock.new("isbn2", 3.14)
puts b2
b3 = BookInStock.new("isbn3", "5.67")
puts b3


#=>
#<BookInStock:0x0000000102c587c8>               # Class name + hexidecimal id number. 
#<BookInStock:0x0000000102c583e0>
#<BookInStock:0x0000000102c58318>