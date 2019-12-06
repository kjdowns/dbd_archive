#this is a placeholder stub class
class DBDArchive::MenuArt
  
  def self.evan_splash
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
  
  def self.dwight_splash
    puts "======================================================================="
    puts "======================================================================="
    puts"  ____           _       _     _     _____     _       __ _      _     _ "
    puts" |  _ \__      _(_) __ _| |__ | |_  |  ___|_ _(_)_ __ / _(_) ___| | __| |"
    puts" | | | \ \ /\ / / |/ _` | '_ \| __| | |_ / _` | | '__| |_| |/ _ \ |/ _` |"
    puts" | |_| |\ V  V /| | (_| | | | | |_  |  _| (_| | | |  |  _| |  __/ | (_| |"
    puts" |____/  \_/\_/ |_|\__, |_| |_|\__| |_|  \__,_|_|_|  |_| |_|\___|_|\__,_|"
    puts"                   |___/                                                 "
    puts "======================================================================="
    puts "======================================================================="
  end
  
  def self.kill_attr_menu(killer)
    puts "Name: #{killer.name}"
    puts "Alias: #{killer.nickname}"
    puts "Gender: #{killer.gender}"
    puts "Nationality: #{killer.nationality}"
    puts "Power: #{killer.power}"
    puts "Weapon: #{killer.weapon}"
    puts "Perks: #{killer.perks[0][:name]}, #{killer.perks[1][:name]}, #{killer.perks[2][:name]}"
    puts "==================================================================="
    puts ""
    puts "Would you like to know more about #{killer.kill_name}?"
    puts ""
    puts "1. Lore"
    puts "2. Power"
    puts "3. Perks"
    puts "4. Addons"
  end
  
  def self.surv_attr_menu(surv)
    puts "Name: #{surv.name}"
    puts "Gender: #{surv.gender}"
    puts "Nationality: #{surv.nationality}"
    puts "Role: #{surv.role}"
    puts "Perks: #{surv.perks[0][:name]}, #{surv.perks[1][:name]}, #{surv.perks[2][:name]}"
    puts "======================================================================= "
    puts "Would you like to know more about #{surv.name}"
    puts ""
    puts "1. Lore"
    puts "2. Perks"
  end
  
  def self.realm_menu(realm)
    puts "realm menu stub"
    puts realm.name
    realm.maps.each{|map| puts "map"}
  end
  
end