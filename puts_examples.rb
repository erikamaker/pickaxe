
# Testing built-in methods.

"gin joint".length # => 9 (representing the integer value of the counted characters in this string literal)
"Rick".index("c") # => 2 (2 is the index following 0 (R) and 1 (i) in "Rick")
42.even? # => true # (42 is indeed an even number)

# Class Jukebox has a method that accepts an argument for parameter `song`

class Jukebox                           
    def play(song)
        puts song
    end
end

sam = Jukebox.new
sam.play("duh dum, da dum de dum ...")    # The book didn't ask us to imagine how to get that to work, I just guessed a bit. 

"gin joint".length # => 9
"Rick".index("c") # => 2
42.even? # => true
