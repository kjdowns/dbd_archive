
class DBDArchive::CLI
  
  attr_accessor :input, :menu, :prev_menu, :valid_menus, :current_char
  
  MENU_ITEMS = {
    :main_menu => ["Characters", "Realms", "Items"],
    :characters_menu => ["Killers", "Survivors"],
    :char_attr_menu => ["Lore", "Perks"]
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
    a.initialize_realms
    a.add_realm_attr
  end
  
  def update_menu_const
    MENU_ITEMS[:killers_menu] = DBDArchive::Killer.all.map {|killer| killer.kill_name} 
    MENU_ITEMS[:survivors_menu] = DBDArchive::Survivor.all.map {|survivor| survivor.name}
    MENU_ITEMS[:realms_menu] = DBDArchive::Realm.all.map {|realm| realm.name}
    MENU_ITEMS[:items_menu] = DBDArchive::Survivor.items.map {|item| item[:name]}
  end

  def call
    greeting
    menu_handler until self.input == "exit"
    puts "Exiting the Archive..."
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
    when "killers_menu" , "survivors_menu"
      display_menu(self.menu.to_sym)
      get_input
      set_current_char(input_to_index)
      display_info_card(self.current_char)
      set_menu("char_attr_menu")
    when "char_attr_menu"
      if self.current_char.is_a?(DBDArchive::Survivor)
        DBDArchive::MenuArt.surv_attr_menu(self.current_char)
      elsif self.current_char.is_a?(DBDArchive::Killer)
        DBDArchive::MenuArt.kill_attr_menu(self.current_char)
      end
      get_input
      update_menu(input_to_index)
    when "realms_menu"
      display_menu(self.menu.to_sym)
      get_input
      set_current_char_as_realm(input_to_index)
      DBDArchive::MenuArt.realm_menu(current_char)
      set_menu("lore_menu")
    when "lore_menu"
      display_lore
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
  
  def display_info_card(current_char)
    DBDArchive::MenuArt.send("#{current_char.name.downcase.split(" ")[0]}_splash")
  end
  
  def display_lore
    index = 0
    while index < current_char.lore.length
      puts self.current_char.lore[index]
      puts "next? (y/n)..."
      get_input
      self.input == "y" ? index += 1 : set_menu(self.prev_menu); index = current_char.lore.length + 1
    end
    if self.input == "y"
      set_menu("main_menu")
      puts "End of available lore. Returning to main menu"
    else
      puts "Returning to previous menu"
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
  
  def set_current_char(index)
    char_name = MENU_ITEMS[self.menu.to_sym][index]
    if char_name.include? "The"
      self.current_char = DBDArchive::Killer.all.detect{|killer| killer.kill_name == char_name}
    else
      self.current_char = DBDArchive::Survivor.all.detect{|survivor| survivor.name == char_name}
    end
  end
  
  def set_current_char_as_realm(index)
    realm_name = MENU_ITEMS[self.menu.to_sym][index]
    self.current_char = DBDArchive::Realm.all.detect{|realm| realm.name == realm_name}
  end
  
  def set_menu(menu_value)
    self.prev_menu = self.menu
    self.menu = menu_value
  end
  
  def get_input
    self.input = gets.strip.downcase
  end
  
  def input_to_index
    self.input.to_i - 1
  end
  
  def select_prompt
    puts ""
    puts "Choose an item to learn more about."
  end

end