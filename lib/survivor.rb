
class DBDArchive::Survivor < DBDArchive::Character
  
  attr_accessor :role 
  
  def initialize(attr_hash)
    super
  end
  
  def self.all
    DBDArchive::Character.all.select {|char| char.class == DBDArchive::Survivor}
  end
  
end