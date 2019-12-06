
class DBDArchive::Realm 
  
  attr_accessor :name, :maps, :link, :lore
  
  @@all = []
  
  def initialize(attr_hash)
    attr_hash.each {|attr, value| self.send("#{attr}=", value)}
    @maps = []
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end