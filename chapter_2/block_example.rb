
# This method definition outputs a string indicating its start. 
# yield is called twice below, the expression placed in the braces outputs its string each time. 

def call_block
    puts "Start of method"
    yield
    yield
    puts "End of method"
end

call_block { puts "In the block" }


# I'm making my own to help this crystalize in my head: 
puts "\n\n"


def call_block
    puts "Hey Mickey!"
    yield
    yield
    yield
    puts "You blow my mind!"
    puts "Hey Mickey!"
end

call_block { puts "You're so fine!" }
