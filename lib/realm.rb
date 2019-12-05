
class DBDArchive::Realm 
  
  attr_accessor :name, :maps, :killer
  
  @@all = []
  
  def initialize(attr_hash)
    attr_hash.each {|attr, value| self.send("#{attr}=", value)}
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end