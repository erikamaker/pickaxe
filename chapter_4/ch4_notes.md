# Chapter 4: Collections, Blocks, and Iterators

The text explains that, naturally, most programs handle collections of data. It describes various examples (like songs in a jukebox playlist, books in a store, people in a course). It explains that there are two classes used to handle collections: arrays and hashes. I am reasonably familiar with this enough to be excited to see what new details I learn. Mastery of these and their large interfaces is an important part of being a Ruby developer.

Doing a few pages a day, starting on the weekend. I should have Chapter 4 finished by 3/11. 


# ARRAYS

Arrays hold collections of object references. The collection can be of strings, integers, hashes, and even other arrays. Each object reference holds a position in the array, and it's identified by an integer index. I'm not sure how deep this goes, but I'm noticing a similarity with how items are indexed in an array with how objects are held in memory. 

Whenever I've made an array in the following fashion: `array = [1,2,3]`, I'm creating a literal array. I can also explicitly create an Array object by using: `array = Array.new`. I've used both methods in creating arrays before. Array indeces start at zero (i.e., index 0 of `[1,2,3]` would be value `1`). Index an array with a positive integer and it will return the object (if nothing, nil). Indexing in the negative starts at the very end, which in this case is negative 1. This was all review for me. 

There was also a fun diagram on page 54 that shows how various ranges are selected in an array. For instance, `a[2]` returns the second index of an array, `a[-3]` returns third-to-last, `a[1..3]` returns the first index through the third, `a[1...3]` returns index 1 and 2 only, and `a[4..-2]` would return index 4 and -2 in the array. All review, but the visual model was intuitive. I remember being confused for the longest time about two-period ranges including the end position whereas the 3-period range didn't (I know it's arbitrary, but in 2020 I thought they should be reversed--I've since grown used to it). 

I learned that the `[]` pairing is the bracket operator. It's implemented as a method, and specifically as an instance of the class Array. These two are equivalent: `a[0]` and `a.[](0)` because of this. They both return the zero index of array instance `a`. The latter is not conventional, as it treats `[]` like a normal method being accessed by the dot operator (and accepting index `(0)` as its argument).

Something new I learned: you can index arrays with a pair of numbers in this format: `[start,count]`. This will return the chosen starting index, and then return that value along with the subsequent values (until it reaches the chosen count of values). 



```
a = ["cat","rat","mat","bat","fat"]

a[1,4]

   => ["rat","mat","bat","fat"]
   
```

The `[]` operator has a corresponding `[]=` operator, that lets you set the element values in an array. If it's a single integer, the element at that index will be replaced by the assigned value. Neglected gaps will be filled with `nil`. It's a regular method that could be written more verbosely as `a.[]=(index,new_value)`. 

If the index for this method is two numbers or a range, the elements in the original array are replaced by the right side of the assignment. If the length of the elements used on the left side of this operation is zero, the right side is simply moved before the start position, and no elements are removed. However, if the right side is an array, the elements are used to replace the original. The right side is not inserted as one element in this case, but rather each element is inserted individually. 

I learned that I don't have to separate words in an array by quotations and commas. I can use a `%w` delimiter in anything that is inside a bracket or parenthesis, and the array will continue until it reaches the end. Using symbols lets me use a similar delimiter "%i". Here are examples of both, the difference being that if I select an element from each, the first will return a string literal and the second will return a symbol. 


` a = %w[ant bee cat dog elk] ` 

` a= %i[ant bee cat dog elk] `


Arrays are useful in many ways. I can use them as stacks, sets, queues, dequeues, and FIFO queues. I learned that there is a specific Ruby class called `Set` that we'll be covering later. The text went over methods `push` and `pop` to add / remove elements from the end of an array. I've used both of these in my game's engine at some point, and am familiar with what they do. I was also familiar with what the `first` and `last` methods do. 

However, I was not familiar with `shift` or `unshift`, and the text didn't give a lot of detail other than: they add and remove elements from the beginning of an array. That sounds simple enough. They work like `push` and `pop`, but target the first element of the array rather than the last. 


# HASHES

Hashes are key/value pairs (Python uses a `dictionary` as its equivalent, Java uses a `Java Map`, and JavaScript uses... `object`. Kinda greedy, JavaScript. They're sometimes known as associative arrays, maps, or dictionaries. They're similar to arrays in that they're indexed collections of object references. The difference is HOW they're indexed. Where an array is indexed using integers (starting at 0 and ending at -1), a hash is indexed by its key. If you reference an index in an array, it returns that element's value. Likewise, if you reference a key in a hash, it returns that key's value. 

"Hash" is named after an implementation detail: the keys are stored in memory (based on a function that returns the intended unique value for each object). The location of each key can be found without referring to the full object, so looking it up is very fast. The function that returns the unique value is called the 'hashing function', lending to the data structure being called a 'hash'. 

Hash literals can be used as key / value pairs between braces like so: 

` hash = { "dog" => "canine" } ` Note: the `=>` is sometimes called a 'hashrocket'. 

Or, it can be be done more simply if the keys are symbols: 

` hash = { :dog => "canine" } ` Another, possibly more idiomatic way, is to use ` hash = { dog: "canine" } `

The value of a symbol doesn't change, so symbols are often used as hash keys since they serve as reference points. Consider also, a shorter way to assign values to keys. Sometimes when creating a new hash, existing data stored as variables share the same name as the key they'll be mapped to in the hash. For instance: 


```
firstname = "Erika"
lastname = "Maker"
user = {firstname: firstname, lastname: lastname} 
```

The last line is equivalent to writing `user = {firstname:,lastname:} since the variables have the same name as the key's symbol. Ruby infers the value should come from a variable when it's written this way, and it will look for the variable with the same name. However, if there isn't a variable with the same name as the symbol key, it will crash. 

Arrays are advantageous in that they can use ANY object as an index. Ruby remembers the order in which an item is added to a hash. When you iterate over the entries, Ruby will return them in that order. 

> This surprised me-- don't arrays behave the same way? DOn't they remember the order in which something is added to the array? If something is pushed to an array, it's always pushed to the end. What other way would it order them (besides from the starting index)? 

