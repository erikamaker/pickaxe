
# Much like the first block example, yield is taking control of what gets executed in this method. 
# Since yield can have parameters, passing arguments in the method (like "Dave", for person, and "hello" for phrase)
# will output the arguments in order of the interpolated strings that the block contains. 

def who_says_what
    yield("Dave", "hello")
    yield("Andy", "goodbye")
end

who_says_what { |person, phrase| puts "#{person} says #{phrase}" }
