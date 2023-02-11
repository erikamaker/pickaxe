
# This program accepts arguments into a global array built into the language. 

puts "You gave #{ARGV.size} arguments"
p ARGV

# I added three arguments to it, and this is what it output: 

#  $ruby cmd_line.rb uno dos tres
#  You gave 3 arguments
#  ["uno", "dos", "tres"]
