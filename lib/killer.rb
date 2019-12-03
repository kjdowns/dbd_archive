
class DBDArchive::Killer < DBDArchive::Character
  
  attr_accessor :kill_name, :alias, :realm, :power, :alt_attack, :weapon, :terror_radius
  
  def initialize(attr_hash)
    super
  end
  
  def self.all
    DBDArchive::Character.all.select {|char| char.class == DBDArchive::Killer}
  end
  
end