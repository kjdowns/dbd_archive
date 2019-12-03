
class DBDArchive::Scraper
  
  attr_accessor :doc 
  
  def initialize
    @doc = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
  end
  
end