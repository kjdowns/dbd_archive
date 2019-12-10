
class DBDArchive::CLI
  
  attr_accessor :input, :menu, :prev_menu, :valid_menus, :current_char
  
  MENU_ITEMS = {
    :main_menu => ["Characters", "Realms", "Items", "About"],
    :characters_menu => ["Killers", "Survivors"],
    :char_attr_menu => ["Lore", "Perks"]
  }
  
  def initialize 
    initialize_environment
    update_menu_const
    @valid_menus = MENU_ITEMS.map{|k, v| k.to_s}
    @valid_menus.push("about_menu", "help_menu", "back_menu", "exit_menu")
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
    DBDArchive::MenuArt.greeting_splash
    menu_handler until self.input == "exit"
    DBDArchive::MenuArt.exit_splash
  end
  
  def menu_handler
    case self.menu
    when "killers_menu" , "survivors_menu"
      display_menu(self.menu.to_sym)
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        set_current_char(input_to_index)
        display_info_card(self.current_char)
        set_menu("char_attr_menu")
      end
    when "char_attr_menu"
      if self.current_char.is_a?(DBDArchive::Survivor)
        DBDArchive::MenuArt.surv_attr_menu(self.current_char)
      elsif self.current_char.is_a?(DBDArchive::Killer)
        DBDArchive::MenuArt.kill_attr_menu(self.current_char)
      end
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        update_menu(input_to_index)
      end
    when "realms_menu"
      display_menu(self.menu.to_sym)
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        set_current_char_as_realm(input_to_index)
        DBDArchive::MenuArt.realm_menu(current_char)
        set_menu("lore_menu")
      end
    when "lore_menu"
      display_lore
    when "perks_menu"
      display_perks
      select_prompt
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        DBDArchive::MenuArt.perk_description(self.current_char, input_to_index)
        set_menu("perks_menu")
      end
    when "items_menu"
      display_menu(self.menu.to_sym)
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        DBDArchive::MenuArt.item_description(DBDArchive::Survivor.items[input_to_index])
        set_menu("items_menu")
      end
    when "about_menu"
      DBDArchive::MenuArt.about_menu
      set_menu("main_menu")
    when "help_menu"
      DBDArchive::MenuArt.help_menu
      set_menu("main_menu")
    when "back_menu"
      set_menu(self.prev_menu)
    else
      display_menu(self.menu.to_sym)
      get_input
      if self.input.to_i == 0 
        handle_text_input
      else
        update_menu(input_to_index)
      end
    end
  end
  
  def display_menu(key)
    select_prompt
    MENU_ITEMS[key].each.with_index(1) do |menu_item, i|
      puts "#{i}. #{menu_item}"
    end
  end
  
  def display_info_card(current_char)
    #there are two davids - if statement assigns last name for method call
    if current_char.name == "David Tapp"
      DBDArchive::MenuArt.send("#{current_char.name.downcase.split(" ")[1]}_splash")
    else
      DBDArchive::MenuArt.send("#{current_char.name.downcase.split(" ")[0]}_splash")
    end
  end
  
  def display_lore
    index = 0
    while index < current_char.lore.length
      puts self.current_char.lore[index]
      if index == current_char.lore.length - 1
        puts "End of available lore - press enter to return to main menu"
        gets
        set_menu("main_menu")
      else
        puts "continue? (y/n)..."
        temp_input = gets.strip.downcase
      end
      case temp_input
        when "y"
          index += 1
        when "n"
          index = current_char.lore.length + 1
          puts "returning to previous menu..."
          set_menu(self.prev_menu)
        else
          puts "Invalid input - select either y or n\n"
      end
    end
  end
  
  def display_perks
    DBDArchive::MenuArt.perk_list(self.current_char)
  end
  
  def update_menu(index)
    item_selected = MENU_ITEMS[self.menu.to_sym][index].downcase
    set_menu("#{item_selected}_menu")
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
    if self.input.to_i > MENU_ITEMS[self.menu.to_sym].length || (self.input.to_i == 0 && !self.valid_menus.include?("#{self.input}_menu"))
      puts "Invalid input, please try again."
      get_input
    end
  end
  
  def handle_text_input
    if self.valid_menus.include?("#{self.input}_menu") 
      self.menu = "#{self.input}_menu"
    end
  end
  
  def input_to_index
    self.input.to_i - 1
  end
  
  def select_prompt
    puts "Choose an item to learn more about."
  end

end