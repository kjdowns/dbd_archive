
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
    DBDArchive::Survivor.all.each do |survivor|
      self.doc = survivor.link
      survivor.gender = self.doc.css(".infoboxtable td")[1].text.strip
      survivor.role = self.doc.css(".infoboxtable td")[3].text
      survivor.nationality = self.doc.css(".infoboxtable td")[5].text
      lore_section = self.doc.css("div.floatleft ~ p")
      lore_section.each do |section|
        section.text.strip.include?("These are Perks") ? return : survivor.lore << section.text.strip
      end
      
      #exception for feng - attr stucture is different
      if survivor.name == "Feng Min"
      
      end
      binding.pry
    end
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
