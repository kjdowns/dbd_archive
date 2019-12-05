
class DBDArchive::CLI
  
  attr_accessor :input, :menu, :valid_menus
  
  MENU_ITEMS = {
    :main_menu => ["Characters", "Realms", "Items", "Addons", "Offerings", "Shrine of Secrets"],
    :characters_menu => ["Killers", "Survivors"],
    :context_menu => []
  }
  
  def initialize 
    initialize_environment
    update_menu_const
    @valid_menus = MENU_ITEMS.map{|k, v| k.to_s}
    @menu = "main_menu"
  end
  
  def initialize_environment
    a = DBDArchive::Scraper.new 
    a.initialize_survivors
    a.add_survivor_attr
    a.initialize_killers
    a.add_killer_attr
  end
  
  def update_menu_const
    MENU_ITEMS[:killers_menu] = DBDArchive::Killer.all.map {|killer| killer.kill_name} 
    MENU_ITEMS[:survivors_menu] = DBDArchive::Survivor.all.map {|survivor| survivor.name}
  end

  def call
    greeting
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
    when "killers_menu"
      display_menu(self.menu.to_sym)
      get_input
    when ":survivors_menu"
      display_menu(self.menu.to_sym)
      get_input
    when "context_menu"
    else
      display_menu(self.menu.to_sym)
      get_input
      update_menu(input_to_index)
    end
  end
  
  def display_menu(key)
    select_prompt
    MENU_ITEMS[key].each.with_index(1) do |menu_item, i|
      puts "#{i}. #{menu_item}"
    end
  end
  
  def update_menu(index)
    item_selected = MENU_ITEMS[self.menu.to_sym][index].downcase
    set_menu("#{item_selected}_menu")
  end
  
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
  
  # def validate_input
  #   if self.input.to_i == 0 
  #     self.menu = self.input
  #     if !self.valid_menus.include?(self.menu)
  #       puts "Invalid input - please try again or type `help` for a list of commands"
  #       get_input
  #       validate_input
  #     end
  #   else
  #     if self.input > MENU_ITEMS[self.menu.to_sym].length
  #       put "Invalid Input - no item with that list number - try again or type `help`"
  #       get_input
  #       validate_input
  #     end
  #   end
  # end
  
  def input_to_index
    self.input.to_i - 1
  end
  
  def select_prompt
    puts ""
    puts "Choose an item to learn more about."
  end

end