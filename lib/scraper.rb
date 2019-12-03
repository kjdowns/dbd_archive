
class DBDArchive::Scraper
  
  attr_accessor :doc 
  
  def initialize
    @doc = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
  end
  
  def scrape_surv_list
    name_array = []
    self.doc.css("#fpsurvivors div.fplinks div.link").each{|surv| name_array << surv.text}
    name_array
  end
  
end


# surv list => doc.css("#fpsurvivors div.fplinks div.link") ~~name => list[i].text
# links for pages => https://deadbydaylight.gamepedia.com/#{name.gsub(" ", "_")}
# killer list => doc.css("#fpkiller div.fplinks div.link") ~~name => list[i].text ~link list[i]
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
