
class DBDArchive::Character
  
  attr_accessor :name, :gender, :nationality, :perks, :lore, :link 
  
  @@all = []
  
  def initialize(attr_hash)
    attr_hash.each {|attr, value| self.send("#{attr}=", value)}
    @lore = []
    @@all << self
  end
  
  def self.all 
    @@all 
  end
  
end

