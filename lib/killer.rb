
class DBDArchive::Killer < DBDArchive::Character
  
  attr_accessor :kill_name, :nickname, :power, :weapon
  
  def initialize(attr_hash)
    super
  end
  
  def self.all
    DBDArchive::Character.all.select {|char| char.class == DBDArchive::Killer}
  end
  
end