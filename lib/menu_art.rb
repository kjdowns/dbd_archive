#this is a placeholder stub class
class DBDArchive::MenuArt
  
  def self.trapper_splash
    puts "====================================================================="
    puts "====================================================================="
    puts "@@@@@@@  @@@  @@@  @@@@@@@@  "
    puts "@@@@@@@  @@@  @@@  @@@@@@@@  "
    puts "  @@!    @@!  @@@  @@!       "
    puts "  !@!    !@!  @!@  !@!       "
    puts "  @!!    @!@!@!@!  @!!!:!    "
    puts "  !!!    !!!@!!!!  !!!!!:    "
    puts "  !!:    !!:  !!!  !!:       "
    puts "  :!:    :!:  !:!  :!:       "
    puts "   ::    ::   :::   :: ::::  "
    puts "   :      :   : :  : :: ::   "
    puts "                             "
    puts "                                                                    "
    puts "@@@@@@@  @@@@@@@    @@@@@@   @@@@@@@   @@@@@@@   @@@@@@@@  @@@@@@@   "
    puts "@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  "
    puts "  @@!    @@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!       @@!  @@@  "
    puts "  !@!    !@!  @!@  !@!  @!@  !@!  @!@  !@!  @!@  !@!       !@!  @!@  "
    puts "  @!!    @!@!!@!   @!@!@!@!  @!@@!@!   @!@@!@!   @!!!:!    @!@!!@!   "
    puts "  !!!    !!@!@!    !!!@!!!!  !!@!!!    !!@!!!    !!!!!:    !!@!@!    "
    puts "  !!:    !!: :!!   !!:  !!!  !!:       !!:       !!:       !!: :!!   "
    puts "  :!:    :!:  !:!  :!:  !:!  :!:       :!:       :!:       :!:  !:!  "
    puts "   ::    ::   :::  ::   :::   ::        ::        :: ::::  ::   :::  "
    puts "   :      :   : :   :   : :   :         :        : :: ::    :   : : "
    puts ""
    puts "==================================================================="
    puts "==================================================================="
  end
  
  def self.kill_attr_menu(killer)
    puts "Name: #{killer.name}"
    puts "Alias: #{killer.nickname}"
    puts "Gender: #{killer.gender}"
    puts "Nationality: #{killer.nationality}"
    puts "Realm: #{killer.realm}"
    puts "Power: #{killer.power}"
    puts "Weapon: #{killer.weapon}"
    puts "==================================================================="
    puts ""
    puts "Would you like to know more about #{killer.kill_name}?"
    puts ""
    puts "1. Lore"
    puts "2. Power"
    puts "3. Perks"
    puts "4. Addons"
  end
  
end