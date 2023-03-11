#---
# Excerpted from "Programming Ruby 3.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/ruby5 for more book information.
#---

def count_frequency(word_list)    # Accept array of word characters
  counts = Hash.new(0)            # Create a new hash object with parameter 0 (potential key's default value)
  word_list.each do |word|        # For each word key in the word characters list... 
    counts[word] += 1             # Increment its count value by 1
  end
  counts                          # Return the hash object. 
end
