
class DBDArchive::Addon
  
  attr_accessor :rarity, :killer, :description
  
  def initalize
    #each addon belongs to a killer
    #each addon has a rarity and a description
    #each killer has many addons
  end
  
end