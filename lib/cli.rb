
class DBDArchive::CLI
  
  attr_accessor :input

  def call 
    greeting
    main_menu
  end
  
  def greeting
    puts ""
    puts "Welcome to the Dead by Daylight Archive!"
    puts ""
    puts "Make a selection using the number of the item you wish to select - "
    puts "or type help for a list of commands."
    puts ""
    puts "What would you like to know about?"
    puts ""
  end
  
  def main_menu
    puts "1. Characters"
    puts "2. Realms"
    puts "3. Items"
    puts "4. Addons"
    puts "5. Offerings"
    puts "6. Shrine of Secrets"
    puts "7. Trivia"
    puts ""
  end

end