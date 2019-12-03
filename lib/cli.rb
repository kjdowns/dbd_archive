
class DBDArchive::CLI
  
  attr_accessor :input, :menu

  def call 
    greeting
    menu_handler
    self.input = gets.strip.downcase
  end
  
  def greeting
    puts ""
    puts "Welcome to the Dead by Daylight Archive!"
    puts ""
    puts "Make a selection using the number of the item you wish to select - "
    puts "or type help for a list of commands."
    puts ""
  end
  
  def menu_handler
    case self.menu 
      when "main_menu"
        case self.input
          when "1"
            character_menu
          when "2"
            realm_menu
        end
      when "character_menu"
        
      when "help"
        help_menu
      else
        main_menu
    end
  end
  
  def main_menu
    select_prompt
    puts "1. Characters"
    puts "2. Realms"
    puts "3. Items"
    puts "4. Addons"
    puts "5. Offerings"
    puts "6. Shrine of Secrets"
    puts "7. Trivia"
    puts ""
    self.menu = "main_menu"
  end
  
  def character_menu
    select_prompt
    puts "1. Killers"
    puts "2. Survivors"
    puts "3. Lore Characters"
    self.menu = "character_menu"
  end
  
  def help_menu
    #list of commands
  end
  
  def select_prompt
    puts ""
    puts "Choose an item to learn more about."
  end

end