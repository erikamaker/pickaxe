#---
# Excerpted from "Programming Ruby 3.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/ruby5 for more book information.
#---

def words_from_string(string)       # Defines the method that accepts an string literal argument
  string.downcase.scan(/[\w']+/)    # I learned that `scan` returns an array of the given string in substring form based on the pattern. 
end                                 # In this case, the pattern is the [\w']+, which returns word characters.
