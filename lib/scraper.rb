
class DBDArchive::Scraper
  
  attr_accessor :doc 
  
  def initialize
    @doc = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
  end
  
  def initialize_survivors
    self.doc.css("#fpsurvivors div.fplinks div.link").each do |surv| 
      DBDArchive::Survivor.new({:name => surv.text, :link => "https://deadbydaylight.gamepedia.com/#{surv.text.gsub(" ", "_")}"})
    end
    DBDArchive::Survivor.all
  end
  
  def initialize_killers
    self.doc.css("#fpkiller div.fplinks div.link").each do |kill| 
      DBDArchive::Killer.new({:name => kill.text, :link => "https://deadbydaylight.gamepedia.com/#{kill.text.gsub(" ", "_")}"})
    end
    DBDArchive::Killer.all
  end
  
  def add_surv_attr
    self.doc = Nokogiri::HTML(open(DBDArchive::Survivor.all[0].link))
    binding.pry
  end
  
end


# surv list => doc.css("#fpsurvivors div.fplinks div.link") ~~name => list[i].text
# links for pages => https://deadbydaylight.gamepedia.com/#{name.gsub(" ", "_")}
# killer list => doc.css("#fpkiller div.fplinks div.link") ~~name => list[i].text ~link list[i]
# surv attr =>  ~~lore => doc.css("div.floatleft + p").text.strip 
# FENG IS AN EXCEPTION FOR THESE
# ~~gender => .css(".infoboxtable td")[1].text.strip ~~ role => .css(".infoboxtable td")[3].text ~~nat => .css(".infoboxtable td")[5].text
# 
# 
#
# 