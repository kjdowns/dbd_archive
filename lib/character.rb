
class DBDArchive::Character
  
  attr_accessor :name, :gender, :nationality, :speed, :perks, :lore 
  
  def initialize(attr_hash)
    attr_hash.each {|attr, value| self.send("#{attr}=", value)}
  end
  
end