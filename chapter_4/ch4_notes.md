# Chapter 4: Collections, Blocks, and Iterators

The text explains that, naturally, most programs handle collections of data. It describes various examples (like songs in a jukebox playlist, books in a store, people in a course). It explains that there are two classes used to handle collections: arrays and hashes. I am reasonably familiar with this enough to be excited to see what new details I learn. Mastery of these and their large interfaces is an important part of being a Ruby developer.


# ARRAYS

Arrays hold collections of object references. The collection can be of strings, integers, hashes, and even other arrays. Each object reference holds a position in the array, and it's identified by an integer index. I'm not sure how deep this goes, but I'm noticing a similarity with how items are indexed in an array with how objects are held in memory.

Whenever I've made an array in the following fashion: `array = [1,2,3]`, I'm creating a literal array. I can also explicitly create an Array object by using: array = Array.new. I've used both methods in creating arrays before. Array indeces start at zero (i.e., index 0 of [1,2,3] would be value 1). Index an array with a positive integer and it will return the object (if nothing, nil). Indexing in the negative starts at the very end, which in this case is negative 1. This was all review for me.

There was also a fun diagram on page 54 that shows how various ranges are selected in an array. For instance, `a[2]` returns the second index of an array, `a[-3]` returns third-to-last, `a[1..3]` returns the first index through the third, `a[1...3]` returns index 1 and 2 only, and `a[4..-2]` would return index 4 and -2 in the array. All review, but the visual model was intuitive. I remember being confused for the longest time about two-period ranges including the end position whereas the 3-period range didn't (I know it's arbitrary, but in 2020 I thought they should be reversed--I've since grown used to it).

I learned that the `[]` pairing is the bracket operator. It's implemented as a method, and specifically as an instance of the class Array. These two are equivalent: `a[0]` and `a.[](0)` because of this. They both return the zero index of array instance a. The latter is not conventional, as it treats [] like a normal method being accessed by the dot operator (and accepting index (0) as its argument).

Something new I learned: you can index arrays with a pair of numbers in this format: `[start,count]`. This will return the chosen starting index, and then return that value along with the subsequent values (until it reaches the chosen count of values).



```
a = ["cat","rat","mat","bat","fat"]

a[1,4]

=> ["rat","mat","bat","fat"]

```


The `[]` operator has a corresponding `[]=` operator, that lets you set the element values in an array. If it's a single integer, the element at that index will be replaced by the assigned value. Neglected gaps will be filled with nil. It's a regular method that could be written more verbosely as `a.[]=(index,new_value)`.

If the index for this method is two numbers or a range, the elements in the original array are replaced by the right side of the assignment. If the length of the elements used on the left side of this operation is zero, the right side is simply moved before the start position, and no elements are removed. However, if the right side is an array, the elements are used to replace the original. The right side is not inserted as one element in this case, but rather each element is inserted individually.

I learned that I don't have to separate words in an array by quotations and commas. I can use a %w delimiter in anything that is inside a bracket or parenthesis, and the array will continue until it reaches the end. Using symbols lets me use a similar delimiter "%i". Here are examples of both, the difference being that if I select an element from each, the first will return a string literal and the second will return a symbol.


`a = %w[ant bee cat dog elk]`

`a = %i[ant bee cat dog elk]`


Arrays are useful in many ways. I can use them as stacks, sets, queues, dequeues, and FIFO queues. I learned that there is a specific Ruby class called Set that we'll be covering later. The text went over methods push and pop to add / remove elements from the end of an array. I've used both of these in my game's engine at some point, and am familiar with what they do. I was also familiar with what the first and last methods do.

However, I was not familiar with shift or unshift, and the text didn't give a lot of detail other than: they add and remove elements from the beginning of an array. That sounds simple enough. They work like push and pop, but target the first element of the array rather than the last.


# HASHES

Hashes are key/value pairs (Python uses a dictionary as its equivalent, Java uses a Java Map, and JavaScript uses... object. Kinda greedy, JavaScript). They're sometimes known as associative arrays, maps, or dictionaries. They're similar to arrays in that they're indexed collections of object references. The difference is HOW they're indexed. Where an array is indexed using integers (starting at 0 and ending at -1), a hash is indexed by its key. If you reference an index in an array, it returns that element's value. Likewise, if you reference a key in a hash, it returns that key's value.

"Hash" is named after an implementation detail: the keys are stored in memory (based on a function that returns the intended unique value for each object). The location of each key can be found without referring to the full object, so looking it up is very fast. The function that returns the unique value is called the 'hashing function', lending to the data structure being called a 'hash'.

Hash literals can be used as key / value pairs between braces like so:

`hash = { "dog" => "canine" }` Note: the => is sometimes called a 'hashrocket'.

Or, it can be be done more simply if the keys are symbols:

`hash = { :dog => "canine" }` Another, possibly more idiomatic way, is to use `hash = { dog: "canine" }`

The value of a symbol doesn't change, so symbols are often used as hash keys since they serve as reference points. Consider also, a shorter way to assign values to keys. Sometimes when creating a new hash, existing data stored as variables share the same name as the key they'll be mapped to in the hash. For instance:


```
firstname = "Erika"
lastname = "Maker"
user = {firstname: firstname, lastname: lastname}
```


The last line is equivalent to writing `user = {firstname:,lastname:}` since the variables have the same name as the key's symbol. Ruby infers the value should come from a variable when it's written this way, and it will look for the variable with the same name. However, if there isn't a variable with the same name as the symbol key, it will crash.

Arrays are advantageous in that they can use ANY object as an index. Ruby remembers the order in which an item is added to a hash. When you iterate over the entries, Ruby will return them in that order.

This surprised me-- don't arrays behave the same way? Don't they remember the order in which something is added to the array? If something is pushed to an array, it's always pushed to the end. What other way would it order them (besides from the starting index)?


# DIGGING

Sine data can be complicated, it doesn't always confined to a hash or array, but instead a complex package of both. Ruby helps make accessing such complicated structures easier with the dig method. This method is callable for arrays, hashes, and structs (I've briefly used and looked into structs before, but it was a long time ago and I definitely didn't know what I was doing even a little bit). This method lets us, as its aptly named, dig through the structure.

For something like:


```
data = {
  mcu: [
    {name: "Iron Man", year: 2008, actors: ["Robert Downey Jr.", "Gwyneth Paltrow"]}
  ],
  lotr: [
    {name: "Fellowship of the Ring", year: 2001, actors: ["Ian McKellen","Elijah Wood"]}
  ]
}


data[:lotr][0][:actors][1]        # => "Elijah Wood"
data.dig(:lotr, 0, :actors, 1)    # => "Elijah Wood"
```


According to the text, this is useful because if an element is not in the data structure, it returns nil and not an exception.

I'm a little unclear about why this is an advantage. Doesn't Array also return nil if the element doesn't exist? I tested below to make sure I wasn't wrong about that, so I must be misinterpreting the text?


```
erikamaker@erikas-computer:~$ irb
irb(main):001:0> array = ["thing","stuff","other"]
=> ["thing", "stuff", "other"]
irb(main):002:0> array[0]
=> "thing"
irb(main):003:0> array[5]
=> nil
```


# WORD FREQUENCY: USING HASHES AND ARRAYS

Alright, time to build a program that: calculates the number of each time a word occurs in a given text.

1.) Step 1: take a string of text and return an array of the words (I made something up for Bonecrawl like this; curious how they do it!).

Update: I'm thrilled to see that they also simply downcased the received string. But, I didn't use `scan` like they did, nor did I use the pattern `/[\w']+/` to match word characters. I learned that I could condense my own version, because scan returns an array based on that pattern. In addition, this method removes the need to eliminate punctuation, as it ONLY pattern matches for word characters. See: `words_from_string.rb`

2.) Step 2: Build a count fo reach distinct word, indexing a hash with each word and the count as its value.

The text describes an incrementer that will increase each found word by 1: `counts[next_word] += 1`

It notes that this wouldn't work when the word is encountered for the first time, however. It would crash the program.
One solution is to check whether the entry exists before doing the increment, like this prescribed attempt:


```
if counts.has_key?(next_word)     # the text does it this way, but I believe I can just use `.key?(next_word)` for the same effect.
  counts[next_word] += 1
else
  counts[next_word] = 1
end
```


This is how I would personally do it, so I thought I was on the right track. However, the text says there's an "tidier" way. See : `count_frequency.rb`

3.) Step 3: Decide the structure for how the words in this hash object are ordered. Currently, it's by appearance.

The text explains that it would be better to sort by frequencies of the words. To do that, we'll use the `sort_by` method. I've briefly used this method before but only superficially understand it. The text explains that, when using sort_by, I give it a block that tells the sort what to use when making comparisons.

In our case, we're using count. This results in an array bearing a set of two-element arrays:
Each of these two-element arrays correspond to a key/count pair in the hash object.

See: `ugly_word_count.rb`

Step 2 implements a loop, the first of which the text introduces. It briefly explains how the each method takes a block argument and executes the block once for each element in the array. In our case (a hash object), it's incrementing the value of each indexed word from the array of word characters. I commented on the program above to explain what was happening. I was familiar with it, and it's good to cross this off my list of things I understand (at least on a foundational level).


# Minitest

To validate the code, we're using a testing framework called Minitest that comes with the standard Ruby distros. We learn more about it in Chapter 13, but for now, it's just worth knowing that the class MiniTest::Test brings in test functionality. See file `test_words_from_string.rb` for its implementation. The `assert_equal` method checks that two parameters are equal, using different control values in isolation to test them one at a time.

The test first requires the source file that contains the `words_from_string` method, and the unit testing framework. It defines a test class, meaning that any methods whose names start with `test` are automatically run by the testing framework. In our cases, they sucessfully ran all of them, validating six different assertions. (see both `test_words_from_string.rb` and `test_count_frequency.rb`. I didn't comment on the latter because the principle is the same as the former.)

At this point, the text went over the `tally` method that's been introduced to the standard library. I've used this method before and am pretty familiar with how to use it. Like the text says, it does exactly what the `count_frequency.rb` program does, but with less work (see: `better_word_count.rb`).


# Blocks and Enumeration

In our last program to output the results of word frequency, there was a loop:


```
top_five.reverse_each do |word, count|
  puts "#word}: #{count}"
end
```

The method `reverse_each` is an example of an iterator. An iterator invokes a block of code repeatedly. For instance, in my Bonecrawl engine, I use iterators to output the contents of the player's inventory. Another term that is exchangable for this type of method is "enumerator".

The most general iterator is `each`. This method takes a block and invokes it for each element contained in its (the block's) collection. In the above case, we're using reverse_each, which is just iterates from the other end of the collection.


# Map

Enumerator methods have different behavior other than just executing a block of code. For instance, the enumerator method `map` helps write code more compactly.


```
top_five.reverse_each do |word, count|
  puts "#word}: #{count}"
end
```

and


`puts top_five.reverse.map { |word,count| "#{word}: #{count}" }`


are effectively the same. What's happening is that `map` applies its block to each element of the array one after the other, returning a new array made up of the result of each invocation of the block. At least, that's what the text tells me, but I found the explanation a little quick. I hopped on ChatGPT to ask it to break the concept down for me (to answer a question you asked on another issue, yes, I use this tool sometimes--I find it super helpful for getting a quick answer on a concept that isn't clicking, or to walk me through an example).

This is the example it gave me:


```
numbers = [1, 2, 3, 4, 5]
squares = numbers.map { |number| number ** 2 }

puts squares.inspect # Output: [1, 4, 9, 16, 25]
```

It explained the broader concept that `map` allows me to iterate through a collection. It says that, during each iteration, it applies a transformation to each element in that object before returning a new array with the transformed elements.

So, in the above example (which I totally get now), `map` iterates through the `numbers` array, and (just saying this in a familiar way) _for each_ element in that array, it transforms the element by squaring it. The output is therefore the square of each element in `numbers`.

This is great, because it kinda truncates the code we wrote earlier in `best_word_count.rb`, which was already refactored code. We can even chain the method `reverse` to map and output the array in reverse-order just like before (i.e. `puts top_five.reverse.map { |word,count| "#{word}: #{count}" }`). This is much more efficient.


Because each local variable is only used as the receiver of the next message, you can chain all the values together:


```
puts words_from_string(raw_text)
  .tally
  .sort_by { |word,count| count }
  .last(5)
  .reverse
  .map { |word, count| "#{word}: #{count}" }
```


Above, each message returns an entirely new collection of data that is processed by the next message all the way down to `map`. The text says that debugging a long chain of methods like that can be done with `tap`, a method that lets you "tap into" a method pipeline. The text uses an example `bester_word_count_with_tap.rb`. This can be found in the word_count directory.

Here is a quick example that ChatGPT helped put together for me to understand how the method works:


```
person = { name: "Alice", age: 30 }

person.tap do |p|
  p[:age] += 1         # increment the age key by 1, but we also want to return the original person hash.
end

puts person.inspect
```

The tap method takes a block, which is executed with the object as its argument. Doing this, we can perform any operation we'd like to on the object. Here, we increment `age` once. Then, the tap method returns the original object. That object has been mutated, and can take methods chained to it, like `inspect` above.

So the output of this code would be:


```
{:name=>"Alice", :age=>31}
```


Notice that the person hash has been modified to have an age value of 31, even though we didn't explicitly assign it. I like to think of the method as "tapping" into the object so it can mutate it. This sounds incredibly useful, and is a concept I hadn't yet read about.

Note to self:

   `each` iterates over a collection and DOES some kind of block to each element.
   `map`  iterates over a collection and RETURNS a NEW object after executing a block on each element.
   `tap`  iterates over a collection and MUTATES / RETURNS the ORIGINAL element after executing a block on it.


# Blocks

Blocks are "chunks" of code. They're enclosed either in braces, or between keywords `do` and `end`. Both implementations are identical except for precdence (which is rarely a practical issue). However, Ruby convention favors using braces for blocks that fit on one line, and the latter when a block spans multiple lines. For example, the most recent small program we built used method chaining, which covered multiple lines-- but the blocks within it fit on one line, so they use braces. Also, style has spaces between the brace and the code to distinguish a block from a hash literal.

I can think of a block like the body of an anonymous method. I really like that the text suggests this, because that's what it intuitively feels like. Just like a method, it can take parameters (however, unlike a method, the parameters appear at the start of the block between pipes (`||`)). Like a method, the body of a block is not executed at first sight during interpretation-- instead, the block is saved to memory (if only briefly) to be called again.

Blocks can appear only after the invocation of a method. If the method takes parameters, the block is written after said parameters. The block, in this form, would be a sort of 'extra parameter' that acts like a mini-temporary-method, which is itself passed to the original method.


```
sum = 0
[1,2,3,4].each do |value|
  square = value * value
  sum += square
end
puts sum
```


The above block is being called by the each method, where each element is passed to the block. Each element here is being passed to the block as the parameter `value`. Parameters are always local to a block, even if they have the same name as variables in the surrounding scope. The `sum` variable is declared outside of the block, and called after the block, meaning that the values calculated within the block remain until the method it exists within ends. However, we cannot call `value` outside of the block, as it's local to the block itself. See below:


```
irb(main):002:1* [1,2,3].each do |v|
irb(main):003:1*   square = v * v
irb(main):004:1*   sum += square
irb(main):005:0> end
=> [1, 2, 3]
irb(main):006:0> puts sum
14
=> nil
irb(main):007:0> puts square
(irb):7:in `<main>': undefined local variable or method `square' for main:Object (NameError)
```


That said, a block does not create new variables with existing names, and will overwrite them. See below:


```
irb(main):010:1* square = "SQUARE"
irb(main):011:1* [1,2,3].each do |v|
irb(main):012:1*   square = v * v
irb(main):013:1*   sum += square
irb(main):014:0> end
=> [1, 2, 3]
irb(main):015:0> puts sum
14
=> nil
irb(main):016:0> puts square
9
```

In other scenarios where `square` may have a preexisting method it calls from its class, a method that might not work on the new definition from the block. That could cause more than just unexpected behavior as seen above-- it could cause an error. You can also define block-local variables by putting them after a semicolon in the block's parameter (I had no idea you could do that! So cool). By making `square` local to the block, values assigned inside the block won't affect the value of `square` elsewhere in the program:


```
some_collection = [1,2,3]
some_collection.each do |number; square|  # This cool syntax? It's rare and unconventional.
...
```


Oh, and there's a shortcut way to access arguments to a block based on their numerical position (wouldn't the term 'index' have applied here, or am I wrong? 'Numerical position' just felt stilted).


```
[1,2].each { |thing| puts thing }
```

is the same as


```
[1,2].each { puts _1 }
```

In the shortcut, the variable `_1` is special, and indicates the first positional argument to the block. If there were two, you could reference them as `_2`, and so on. However, the text advises that if this goes past position 1, I should probably give the block variables their own names.


# Iterator

An "iterator" is a method that can invoke a block of code repeatedely for one or more elements. It's also called an "enumerator" as well. A block can only appear in the source adjacent to a method call (like `do` for instance). Ruby remembers the context in which a block appears (the local variables, current object being interpreted, etc). Ruby refers to this information as a "binding". This encapsulate the execution context at each position in the code. The binding method returns a Binding object that provides the context. In other words, the block is saved to memory. Once the Binding object points to the block we had saved, the method is then called on it.

Within the method, the block can be invoked as if were a method itself, using the `yield` statement. This statement invokes the code in the block passed to the method. If the block doesn't exist, Ruby crashes. After the block is completed, control picks up immediately following the yield. The word "yield" is used to echo the `yield` function in Liskov's language CLU. This language is over 40 years old and /still/ contains features that haven't been widely used.

```
irb(main):001:1* def two_times
irb(main):002:1*   yield
irb(main):003:1*   yield
irb(main):004:0> end
irb(main):005:0> two_times { puts "Hello" }
Hello
Hello
=> nil
irb(main):006:0>
```

In the example above, the block (between the `{}`) is part of the `two-times` method. In this method, every time `yield` is called, it invokes the code in the block. Easy enough! Blocks are cool because you can pass parameters to them and receive values from them. I've found this to be extremely useful and basically a workhorse of a concept for my own projects. For instance, see below, a method that calculates members of the Fibonacci series up to a chosen value. This is sometimes used in sorting algorithms and analyzing things in nature, so it's worth saving :)

```
irb(main):006:1* def fib_up_to(max)
irb(main):008:1*   i1, i2 = 1, 1
irb(main):009:2*   while i1 <= max
irb(main):010:2*   yield i1
irb(main):011:2*   i1, i2 = i2, i1 + i2
irb(main):012:1*   end
irb(main):013:0> end
=> :fib_up_to
irb(main):014:0> fib_up_to(1000) { |f| print f, " " }
irb(main):015:0> puts
1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
```
In this example, `yield` uses the argument `i1`, which is the first variable we declare in the definition. The value is passed to the block ` { |f| print f, " " } `. The parameter list `f` receives the value passed to `yield`, and then by `yield` to the block, so the block prints successive members of the series. This might not make total sense to me now, but we'll be learning more about parallel assignment in a little less than 100 pages. The block could also have been printed as ` { print _1, " " } ` (remember, the variable `_1` is special, and indicates the first positional argument to the block.)

It's conventional to pass just one value to a block, but isn't a requirement as there can be any number of arguments. Blocks behave just like methods in how they communicate with arguments, something the text says we'll be touching on more in Chapter 5. There are many iterators, but here are three common ones:

1. `each` : The simplest of all iterators-- all it does is yield successive elements of its collection (ergo: it spits out the collection in order). You can do fun things with it though! For instance, `some_array.reverse.each { |i| puts i }` prints an array back in reverse. Just an example of how useful a simple method can be. In fact, it's used as the basis of the language's `for` loops that we learn about on page 159.

Since a block returns a value to the method that yields to it, the value of the last expression evaluated in that block is passed back to the method. That last expression's value is now the value of the `yield` expression. Fun fact: that's how the `find` method works (it's defined in the module `Enumerable`, a mixin for `Array`).

Every time I've ever used `find` in Bone Crawl (like `@@inventory.find { |i| i.is_a?(Fuel) }`, the implementation has always stemmed from:

```
class Array
  def find
    each do |value|
      return value if yield(value)
    end
    nil
  end
end
```

`[1, 3, 5, 7, 9].find { |number| number * number > 30 } # => 7`

2. The `find` method is essentially iterating through the array until it finds the value that satisfies the expression in the block, thanks to the `each` method. `each` takes its own block and passes each indexed value to that block. It uses `yield(value)` to pass control to the block argument `find` (specifically  `{ |number| number * number > 30 } # => 7)`). When the block returns true (when a value isn't either `nil` or `false`), the method returns the appropriate element and returns (i.e. the `return value` section of the multi-line block).

In our case, element 7 does the trick. If none do, `nil` is returned (but you already knew that). Something noteworthy: when you `return` from inside a block, the `return` also extends to the associated method. This is because the block is inside another function or method (in this case, the "find" method), so the "return" value from the block actually becomes the return value for the ENTIRE "find" method.

3. Another common iterator is `map`. Also sometimes referred to as `collect`, it takes each element from a collection and passes it to the block. The results returned construct an entirely new array, so the first one is not mutated. For instance:

`["H", "A", "L"].map { |x| x.succ } # => ["I", "B", "M"]`

is implemented as:

```
class Array
def map
result = []
each do |value|
result << yield(value)
end
result
end
end
```

First, we take the empty result array, and for each value in the collection, `yield` is invoked, with the resulting value appending (`<<`) `result`. This result is returned.


Iterators are not limited to accessing only data in arrays and hashes. We can use them to return all kinds of derived values (like in the Fibonacci example we looked at earlier). We can use this capability in our I/O streams to implement `each` and iterate over an entire file. For instance:

```
f = File.open("testfile")
f.each do |line|
puts "The line is: #{line}"
end
f.close
produces:
The line is: This is line one
The line is: This is line two
The line is: This is line three
The line is: And so on...
```

A little tidbit: if you want to keep track of the total times you've iterated through a block, use `with_index` method. It's a little method call you can chain after an iterator to provide the sequence. Adding it to what we just wrote above will output the original value, as well as the sequence number. It is theoretically able to work with any properly defined iterator method.


4. And now we're looking at `reduce`. I have never encountered this method yet, so I'm excited to learn about it. Historically, it comes from the method name `inject` (while I haven't done any research, I imagine it comes from `C`? Googling real quick... yes, I was right about that). Anyway, this method lets you accumulate a value across members of a collection. For instance, you can sum all the elements in an array:

```
[1,3,5,7].reduce(0) { |sum, element| sum + element }.
```

This will output 16. The way it works is, the first time the associated block is called, the first argument to the block is set to the first argument passed to `reduce` (in this case, `0`).
The block that's passed to reduce takes two arguments, sum and element. The first time the block is called, sum is set to 0 (the initial value), and element is set to the first element in the array, which is 1. The block adds sum and element together, which is 1, and returns that value.

The second time the block is called, sum is set to the previous result of the block (which was 1), and element is set to the next element in the array, which is 3. The block adds sum and element together, which is 4, and returns that value.

The block is called two more times, each time with a new value of sum and element. The final value returned by reduce is the last value that was returned by the block, which is 16.

```
[1,3,5,7].reduce(1) { |product, element| product * element } # => 105
```

The above works similarly, though it works specifically with multiplication. I don't know if this is a poor habit to make, but I can't help notice that for the first example, if you add all the elements sequentially, it equals the return value. For the second, if you multiply left to right, the result illustrates the same expectation. I only notice this because the above explanation I wrote doesn't feel as intuitive to me. I get what the text meant by "accumulate a value across members of a collection", and if my way of remembering it isn't dangerous, I think I'll keep at it.

I checked with ChatGPT about what it had to say on this matter and got the following:

That's absolutely right! One way to think about how the reduce method works is to imagine iterating over the collection from left to right and applying the operation (e.g. addition or multiplication) as you go. Here's another simple example to illustrate this concept:

```
[2, 4, 6, 8].reduce(0) { |sum, element| sum + element } # => 20
```
In this example, the reduce method is called on an array of numbers [2, 4, 6, 8], with an initial value of 0. The block that's passed to reduce takes two arguments, sum and element, and adds them together. When we think about iterating over the array from left to right and applying addition as we go, we can see that the calculation would look like this:

```
0 + 2 = 2
2 + 4 = 6
6 + 6 = 12
12 + 8 = 20
```

Alright, back to my own thoughts:

Now, if `reduce` is called without a parameter (we were using `0` above), it'll use the first element of the collection as the initial value, starting the iteration with the 2nd value. In other words, we wouldn't have needed the arguments for the examples we did above. In fact, here's an even SHORTIER shortcut:

```
[1,3,5,7].reduce(:+) # => 16
[1,3,5,7].reduce(:*) # => 105
```

Now, finally, for at least the first example we have an even SHORTIEST shortcut:

```
1,3,5,7].sum
```

It would make sense for `product` to be a method in the same fashion, but it actually does something different: it returns the cross-product of two arrays.

```
[1,3,5,7].product([2, 4, 6]) # => [[1, 2], [1, 4], [1, 6], [3, 2], [3, 4], [3,
# .. 6], [5
```


UP TO PAGE: 72 text (83 browser) : USING BLOCKS FOR TRANSACTIONS