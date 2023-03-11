#---
# Excerpted from "Programming Ruby 3.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/ruby5 for more book information.
#---
require_relative "words_from_string"
require_relative "count_frequency"

raw_text = "The problem breaks down into two parts. First, given some text
as a string, return a list of words. That sounds like an array. Then, build
a count for each distinct word. That sounds like a use for a hash---we can
index it with the word and use the corresponding entry to keep a count."

word_list = words_from_string(raw_text)             # assigns the array result from words_from_string.rb after processing raw_text
counts = count_frequency(word_list)                 # using words_list above as an argument, count_frequency.rb returns a hash object
sorted = counts.sort_by { |word, count| count }     # Sort an enumerable object (in this case, a hash), by `...count }`). 
top_five = sorted.last(5)                           # Create a new array of the last 5 key-value pairs from sorted counts hash. 
                                                    # These would be the highest frequencies, since they're the last from the sorted hash.


top_five.reverse_each do |word, count|              # Iterate over top_five array in reverse order. Assign its key to word, and its value to count.   
  puts "#{word}:  #{count}"                         # Print the key (word) and its corresponding value (count) with a ":"" separating them.
end


