
class DBDArchive::CLI
  
  attr_accessor :input, :menu

  def call
    initialize_environment
    greeting
    main_menu
    menu_handler until self.input == "exit"
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
        main_menu_input
      when "character_menu"
        character_menu_input
      when "killers_menu"
        #killers_menu_input
      when "survivors_menu"
        #survivors_menu_input
      when "help"
        
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
    set_menu("main_menu")
    get_input
  end
  
  def main_menu_input
    case self.input
      when "1"
        character_menu
      when "2"
        realm_menu
      when "3"
        item_menu
      when "4"
        addon_menu
      when "5"
        offering_menu
      when "6"
        shrine_menu
      when "7"
        trivia_menu
    end
  end
  
  def character_menu
    select_prompt
    puts "1. Killers"
    puts "2. Survivors"
    set_menu("character_menu")
    get_input
  end
  
  def character_menu_input
    case self.input
      when "1"
        killers_menu
      when "2"
        survivors_menu
    end
  end
  
  def killers_menu
    select_prompt
    DBDArchive::Killer.all.each.with_index(1) do |killer, i|
      puts "#{i}. #{killer.kill_name}"
    end
    set_menu("killers_menu")
    get_input
  end
  
  def survivors_menu
    select_prompt
    DBDArchive::Survivor.all.each.with_index(1) do |survivor, i|
      puts "#{i}. #{survivor.name}"
    end
    set_menu("survivors_menu")
    get_input
  end
  
  def help_menu
    #list of commands
    #Input the number of a list item and press enter to learn more about that item 
    #or see more selections from that item 
    #menu - main menu
    #killer - enter killer menu 
    #survivor - enter surv menu 
    #exit - exit program
  end
  
  def set_menu(menu_value)
    self.menu = menu_value
  end
  
  def get_input
    self.input = gets.strip.downcase
  end
  
  def input_to_index
    self.input - 1
  end
  
  def select_prompt
    puts ""
    puts "Choose an item to learn more about."
  end
  
  def initialize_environment
    a = DBDArchive::Scraper.new 
    a.initialize_survivors
    a.add_survivor_attr
    a.initialize_killers
    a.add_killer_attr
  end

end