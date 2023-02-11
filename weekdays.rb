
# Using control structure if/elsif/else and capping with an end...

today = Time.now                            # assigns the current time to local variable `today`
if today.saturday?                          # if today is saturday...
    puts "Do chores around the house"       # ... output this string literal
elsif today.sunday?                         # otherwise, if today is sunday...
    puts "Relax"                            # ... output this string literal.
else    
    puts "Go to work"                       # For any weekdays, just output "go to work"
end                                        