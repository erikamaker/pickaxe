# Chapter 4: Collections, Blocks, and Iterators

The text explains that, naturally, most programs handle collections of data. It describes various examples (like songs in a jukebox playlist, books in a store, people in a course). It explains that there are two classes used to handle collections: arrays and hashes. I am reasonably familiar with this enough to be excited to see what new details I learn. Mastery of these and their large interfaces is an important part of being a Ruby developer.


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

> This surprised me-- don't arrays behave the same way? Don't they remember the order in which something is added to the array? If something is pushed to an array, it's always pushed to the end. What other way would it order them (besides from the starting index)? 


# DIGGING 

Sine data can be complicated, it doesn't always confined to a hash or array, but instead a complex package of both. Ruby helps make accessing such complicated structures easier with the `dig` method. This method is callable for arrays, hashes, and structs (I've briefly used and looked into structs before, but it was a long time ago and I _definitely_ didn't know what I was doing even a little bit). This method lets us, as its aptly named, dig through the structure. 

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

According to the text, this is useful because if an element is not in the data structure, it returns `nil` and not an exception. 

> I'm a little unclear about why this is an advantage. Doesn't Array also return `nil` if the element doesn't exist? I tested below to make sure I wasn't wrong about that, so I must be misinterpreting the text? 


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

   * Update: I'm thrilled to see that they also simply downcased the received string. But: 
   * I didn't use `scan` like they did, nor did I use the pattern `/[\w']+/` to match word characters. 
   * I learned that I could condense my own version, because `scan` returns an array based on that pattern.
   * In ADDITION, this method removes the need to eliminate punctuation, as it ONLY pattern matches for word characters. 
   * See: `words_from_string.rb`
   
2.) Step 2: Build a count fo reach distinct word, indexing a hash with each word and the count as its value. See 

   * The text describes an incrementer that will increase each found word by 1: `counts[next_word] += 1`
   * It notes that this wouldn't work when the word is encountered for the first time, however. It would crash the program. 
   * One solution is to check whether the entry exists before doing the increment, like this prescribed attempt: 
   
   
```
if counts.has_key?(next_word)     # the text does it this way, but I believe I can just use `.key?(next_word)` for the same effect. 
  counts[next_word] += 1
else 
  counts[next_word] = 1
end
```


   * This is how I would personally do it, so I thought I was on the right track. However, the text says there's an "tidier" way. 
   * See : count_frequency.rb


3.) Step 3: Decide the structure for how the words in this hash object are ordered. Currently, it's by appearance. 

   * The text explains that it would be better to sort by frequencies of the words. 
   * To do that, we'll use the `sort_by` method. I've briefly used this method before but only superficially understand it. 
   * The text explains that, when using `sort_by`, I give it a block that tells the sort what to use when making comparisons. 
   * In our case, we're using count. This results in an array bearing a set of two-element arrays: 
   * Each of these two-element arrays correspond to a key/count pair in the hash object. 
   * See: ugly_word_count.rb

Step 2 implements a loop, the first of which the text introduces. It briefly explains how the `each` method takes a block argument and executes the block once for each element in the array. In our case (a hash object), it's incrementing the value of each indexed word from the array of word characters. I commented on the program above to explain what was happening. I was familiar with it, and it's good to cross this off my list of things I understand (at least on a foundational level). 



# PICK UP AT BOTTOM OF PAGE 60

