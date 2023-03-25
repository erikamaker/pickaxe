#---
# Excerpted from "Programming Ruby 3.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/ruby5 for more book information.
#---
require_relative "words_from_string"
require "minitest/autorun"

class TestWordsFromString < Minitest::Test                  # Testing framework described in the text. 
  def test_empty_string                                     # The following are a series of tests that check if an expected value is equal to the actual value. 
    assert_equal([], words_from_string(""))                 # First, an empty array and an empty string. 
    assert_equal([], words_from_string("     "))
  end

  def test_single_word                                      # Next, an array containing "cat", and the string "cat" itself. 
    assert_equal(["cat"], words_from_string("cat"))
    assert_equal(["cat"], words_from_string("  cat   "))
  end

  def test_many_words                                       # Next, an array containing a set of words, and the set of words deliminted by a space in a single string. 
    assert_equal(
      ["the", "cat", "sat", "on", "the", "mat"],
      words_from_string("the cat sat on the mat")
    )
  end

  def test_ignores_punctuation                              # And finally, ignoring punctuation. 
    assert_equal(
      ["the", "cat's", "mat"],
      words_from_string("<the!> cat's, -mat-")
    )
  end
end
