
class DBDArchive::Character
  
  attr_accessor :name, :gender, :nationality, :speed, :perks, :lore 
  
  @@all = []
  
  def initialize(attr_hash)
    attr_hash.each {|attr, value| self.send("#{attr}=", value)}
    @@all << self
  end
  
  def self.all 
    @@all 
  end
  
end