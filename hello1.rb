
# Passing `name` as an argument and concatenating it to the string literals in `result`

def say_hello_goodbye(name)
    result = "I don't know why you say goodbye, " + name + ", I say hello"
    return result
end

puts say_hello_goodbye("Erika")         # => I don't know why you say goodbye, Erika, I say hello
puts say_hello_goodbye("Skylar")        # => I don't know why you say goodbye, Skylar, I say hello


# Refactored the above using expression interpolation and removing redundant return `result`
# This is called being more idiomatic: 

def say_hello_goodbye(name)
    puts "I don't know why you say goodbye, #{name.capitalize}, I say hello"        # sending the message `capitalize` to variable `name` capitalizes the first letter (see below)
end

puts say_hello_goodbye("tina")          # => I don't know why you say goodbye, Tina, I say hello

