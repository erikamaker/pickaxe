# QUICK UPDATES 

I backtracked and went through the first chapter for properly installing the newest Ruby (3.2.1) using rbenv. I started chapter 3 shortly after. I'm also going to begin using all my notes in README format, with titles and appropriately spaced example breaks. 


# DEFINING CLASSES

I learned that a good first step in designing object-oriented systems is to identify the 'domain concepts' we are using. I take 'domain concepts' to be part of the 'modeling' nature of objected-oriented programs. So, the domain concept can be something in the physical world, a known and abstracted process, or any other entity that makes sense for the team working with it. 


```
class BookInStock
end

a_book = BookInStock.new
another_book = BookInStock.new
```


Both of these instances have different object_ids, but will otherwise behave very much the same. They don't yet have any instance variables or other held information. The `initialize` method sets the state of each of these object during construction (`.new`). This individualized state is stored using instance variables. We can update the definition to include this state: 


```
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end
```


By calling new, Ruby allocates some memory to hold an uninitialized object, then initializes its state. By doing so, it passes all the arguments that are passed to `new`. That data is the instance's state. 

In this case, the `initialize` method takes two parameters. They act like variables local to the method (and follow the same naming conventions). However, if they were truly just local variables, they would disappear when the `initialize` method returns. 

To preserve them, we can pass them into instance variables as arguments. Even though `@isbn` and `isbn` look very similar, they are not equivalent. We are merely assigning the information passed at initialization to the instance variable, preserving its (mutable) state. 

In the class, the Float method takes the argument price and converts it to a floating-point number. It's worth noting that there are better ways to write this, because we shouldn't be holding prices in trailing floats--this is just to illustrate how the class works). 

This parameter will accept anything for `price`, as long as it can be converted to a float. An integer, another float, or even a string containing (only) the representation of a float, will all work. 


# OBJECTS AND ATTRIBUTES

The internal state is private to the instances we defined in the last exercise. No other object can access the instance variables holding that state. There is no such thing as perfect privacy in Ruby. Does this mean it's not a good language for security under some contexts, or all contexts? 

I learned that if an object is completely private, you can't do anything with it. Methods let you access and manipulate the instance variables in an object, which allows the global scope of the program to interact with it. These more visible parts, like instance variables, are its attributes. 

Accessor methods help us to learn the state of objects. 


```
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  def isbn
    @isbn
  end
  def price
    @price
  end
  # ..
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"


=> 
ISBN = isbn1
Price = 12.34
```


In the example above, we can access the instance variables @isbn and @price with the methods `isbn` and `price`. The following quote felt disorienting to read: 

"As far as other objects are concerned, there’s no difference between calling these attribute accessor methods and any other method. This is great because it means that the internal implementation of the object can change without the other objects needing to be aware of the change" 

I've read it multiple times and I'm not following. What 'other objects' are we referring to? Other instances of the same class? Entirely separate classes? 


```
class BookInStock
  attr_reader :isbn, :price                 # attr_reader creates the methods that we otherwise individually wrote in example 3.                                 above
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  # ..
end

book = BookInStock.new("isbn1", 12.34)

puts "ISBN = #{book.isbn}"                  # With attr_reader, they're already made for you through its one-line-implementation. 
puts "Price = #{book.price}"
```


Using a symbol, like :isbn and :price, we are referencing the state that was provided by attr_reader. I remember that, and was reminded by the text, that symbols are used to reference a name. In this context, `:isbn` means the name `isbn`, which in turn represents the value of the variable `@isbn`. The accessor methods we wrote in the earlier exercise are identical to the reader method using symbols in the most recent one. However, a reader method only allows you to read it--not to change it. 


# WRITING TO ATTRIBUTES

By the way, the attr_reader declaration does not declare instance variables. It creates accessor methods, but the variables don't need to be declared. The instance variables automatically have a value of nil when accessed, unless the value is assigned another way. Other languages restrict access to instance variables, making a need for setter functions. In the text, a snippet of Java was used, showing that there is a private method for setting the price, and a public method for getting the price. In Ruby, the attributes can simply be accessed with the getter method. 

From the text:    "In Ruby, the attributes of an object can be accessed via the getter method and that access
looks the same as any other method." This is another instance of the sentence that confused me on my first readthrough. I'm not sure what is meant by "looks the same as any other method". 

To create a getter method that accesses the attributes, a Ruby method is written that ends with an equals sign, like the below example: 



```
class BookInStock
  attr_reader :isbn, :price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  def price=(new_price)
    @price = new_price
  end
  # ...
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75 # discount price
puts "New price = #{book.price}"

=>
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998
```

The method .price= is an assignment invoking the price=() method. Here, it's reassigning the original price value to equal itself multiplied by .75, which has been passed as an argument on line 16. The ruby interpreter ignores the whitespace between the end of the name and the equals sign. The instance variable's value is now updated to the new price. 

`book.price=(1.50)` is also idiomatically written `book.price = 1.50`. A shortcut for write-only is to use attribute writer. However, most people want to use both, so attribute accessor is the standard. I'm not fully understanding why we have attr_reader for :isbn-- wouldn't it be quicker to just say: 

``` 
attr_accessor :isbn, :price
```

I suppose ISBN isn't going to change, so it makes sense not to make it accessible to write over. Still, I'm thinking, if the same people are working on this program, and there aren't any other methods that write over :isbn, would it make sense to write it with attr_accessor referencing both? Or would that cause confusion?
 

```
class BookInStock
  attr_reader :isbn                    # will only access to READ the value. 
  attr_accessor :price                 # will access to both READ and WRITE TO the value. 

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
  # ...
end
```


# ATTRIBUTES ARE JUST METHODS WITHOUT ARGUMENTS

The attribute-accessing methods have more functionality. For instance, I can update the exact number of the trailing floats in the earlier example with `.round`. The text talked a bit about multiplying the price by 100 and rounding it, to get the best price representation in dollars and cents. It also recommended using BigDecimal and not Float for financial calculations before discussing the possibility of creating writing methods that are parallel to the reader method. 

In exercise 8, a new method `price_in_cents=(cents)` is created. The text explains that the first method (without the `cents` argument) doesn't actually correspond to an instance variable. Using the Uniform Access Principle, we're benefiting from the difference between an instance variable vs calculated values. 

The first `price_in_cents` method calculates a value using the accessed value `price`. It's only reading the value of price, and making a new return value based on a simple calculation INVOLVING `price`'s VALUE, but not the actual instance variable itself. 

The second method is accepting `cents` as an argument to actually set a new value to the instance variable `@price`. I experimented by removing the @ symbol from the instance variable @price, and found that the 1234 value of line 24 means nothing to instance without it.


# ATTRIBUTES, INSTANCE VARIABLES, AND METHODS

The text says that, at this point, I may think that attributes are nothing more than methods. An attribute /is/ a method. Sometimes an attribute just gives you the value of an instance variable, sometimes it returns the result of a calculation, and sometimes it updates the instance's state. 

What makes something an attribute vs a regular method? Context, I think. External state intended to be viewable is an attribute. The internal state that's concealed is an instance variable. Other actions that the class can perform are regular methods. The text says there isn't a huge need to know the difference yet.


# CLASSES WORKING WITH OTHER CLASSES 

I've been excited to get to this. The text briefly explained intent for reading the CSV files we made at the start of the file. It reiterated the point that, in OO design, we identify external things and model our code after them. For instance, it talked about how our program was meant to handle multiple CSV files, and suggested we keep an array of values in an instance variable. I learned that Ruby comes with a good CSV library built in (we cover it more in Chapter 29). 

The CVS file reader class requires a file called "cvs", to find any files with that name. An instance variable is made at initialization that accepts data about the books. This data is parsed from the CSV files as a set of key / value pairs. The ISBN and Price columns are derived from these columns and rows, and used as the needed arguments to create a new BookInStock object. This object is instantiated and appended to the `@books_in_stock` array. 

This nearly was over my head, but I realized the book is trying to tell me what types of patterns to aim for. In general, the `initialize` method will set up the object's environment by giving it an accessible state. The point is to make it so that other methods can use that state. The exercises that I made and ran were all to prime me for this fully functional program that we're about to build. It's going to have the definition of the class BookInStock in one file, the CsvReader file, and a main runner file. I'm going to get building, and will report back after. 


# THOUGHTS ON THE BOOKS IN STOCK PROGRAM

I'm stuck. I can't seem to get the driver file to run like the text expects it to. I've read / reread / double checked the directory. I am swapping `csv_file_name` with the actual csv file. I've also tried leaving it exactly as it is and keep getting the same error. I've also tried changing `require_relative` to `require ./filename.rb`. I changed and swapped a few things around, reverted back to the original format, and can't seem to get past this: 


```
ruby stock_stats.rb data.csv 
stock_stats.rb:1:in `require_relative': cannot load such file -- /home/erikamaker/pickaxe/chapter_3/books_in_stock/csv_reader (LoadError)
	from stock_stats.rb:1:in `<main>'
```

I'm going to keep at this until I can get the program running. I'm currently about 7 pages from the end of this chapter, but I don't want to move on until I have this program funcitoning like it should. 

