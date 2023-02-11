

instrument_section = {              # This hash has symbol literals for keys, and string literals for their values. 
    cello: "string",
    clarinet: "woodwind",
    drum: "percussion",
    oboe: "woodwind",
    trumpet: "brass",
    violin: "string"
}

puts "An oboe is a #{instrument_section[:oboe]} instrument"         # => An oboe is a woodwind instrument 
puts "A violin is a #{instrument_section[:violin]} instrument"      # => A violin is a woodwind instrument 


# I thought it might be better for the entire example to be written as a method, but
# maybe that unnecessarily complicates it? It's just easier / faster to get the key's value. 
# The downside of mine is that I had to change the opening "A" to "The" to account for noun / vowels. 



def give_section(type)
    instrument_section = {
        cello: "string",
        clarinet: "woodwind",
        drum: "percussion",
        oboe: "woodwind",
        trumpet: "brass",
        violin: "string"
    }
    puts "The #{type} is a #{instrument_section[(type)]} instrument."
end

give_section(:cello)
give_section(:clarient)
give_section(:trumpet)
