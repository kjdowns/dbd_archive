
class DBDArchive::CLI
  
  attr_accessor :input, :menu
  
  MENU_ITEMS = {
    :main_menu => ["Characters", "Realms", "Items", "Addons", "Offerings", "Shrine of Secrets"],
    :character_menu => ["Killers", "Survivors"]
  }
  
  def initialize 
    initialize_environment
    update_menu_const
    @menu = "main_menu"
  end

  def call
    greeting
    #main_menu
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
  
  def display_menu(key)
    MENU_ITEMS[key].each.with_index(1) do |menu_item, i|
      puts "#{i}. #{menu_item}"
    end
  end
  
  def update_menu_const
    MENU_ITEMS[:killers_menu] = DBDArchive::Killer.all.map {|killer| killer.kill_name} 
    MENU_ITEMS[:survivors_menu] = DBDArchive::Survivor.all.map {|survivor| survivor.name}
  end
  
  def menu_handler
    case self.menu 
      when "main_menu"
        display_menu(self.menu.to_sym)
        get_input
    end
  end
  
  # def menu_handler
  #   case self.menu 
  #     when "main_menu"
  #       main_menu_input
  #     when "character_menu"
  #       character_menu_input
  #     when "killers_menu"
  #       #killers_menu_input
  #     when "survivors_menu"
  #       #survivors_menu_input
  #     when "help"
        
  #   end
  # end
  
  # def main_menu
  #   select_prompt
  #   puts "1. Characters"
  #   puts "2. Realms"
  #   puts "3. Items"
  #   puts "4. Addons"
  #   puts "5. Offerings"
  #   puts "6. Shrine of Secrets"
  #   puts ""
  #   set_menu("main_menu")
  #   get_input
  # end
  
  # def main_menu_input
  #   case self.input
  #     when "1"
  #       character_menu
  #     when "2"
  #       realm_menu
  #     when "3"
  #       item_menu
  #     when "4"
  #       addon_menu
  #     when "5"
  #       offering_menu
  #     when "6"
  #       shrine_menu
  #   end
  # end
  
  # def character_menu
  #   select_prompt
  #   puts "1. Killers"
  #   puts "2. Survivors"
  #   set_menu("character_menu")
  #   get_input
  # end
  
  # def character_menu_input
  #   case self.input
  #     when "1"
  #       killers_menu
  #     when "2"
  #       survivors_menu
  #   end
  # end
  
  # def killers_menu
  #   select_prompt
  #   DBDArchive::Killer.all.each.with_index(1) do |killer, i|
  #     puts "#{i}. #{killer.kill_name}"
  #   end
  #   set_menu("killers_menu")
  #   get_input
  # end
  
  # def survivors_menu
  #   select_prompt
  #   DBDArchive::Survivor.all.each.with_index(1) do |survivor, i|
  #     puts "#{i}. #{survivor.name}"
  #   end
  #   set_menu("survivors_menu")
  #   get_input
  # end
  
  def help_menu
    puts ""
    puts "==========================================="
    puts "==========================================="
    puts "Input the number of an item and press enter"
    puts "to select that item."
    puts ""
    puts "Commands listed below can be entered in any"
    puts "input field to navigate to the specified menu"
    puts "---------------------------------------------"
    puts "help - help menu"
    puts "main menu - main menu"
    puts "back - returns to current menu"
    puts "prev - returns to previous menu"
    puts "exit - exits the program"
    puts ""
    puts "==========================================="
    puts "==========================================="
    #killer - enter killer menu 
    #survivor - enter surv menu
    set_menu("help_menu")
    get_input
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
  
  def handle_special_inputs
    case self.input
      when "main menu"
      when "help"
    end
  end
  
  def initialize_environment
    a = DBDArchive::Scraper.new 
    a.initialize_survivors
    a.add_survivor_attr
    a.initialize_killers
    a.add_killer_attr
  end

end