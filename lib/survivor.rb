
class DBDArchive::Survivor < DBDArchive::Character
  
  attr_accessor :role
  @@items = [{},{},{},{},{},{}]
  
  def initialize(attr_hash)
    super
  end
  
  def self.all
    DBDArchive::Character.all.select {|char| char.class == DBDArchive::Survivor}
  end
  
  def self.items
    @@items
  end
  
end