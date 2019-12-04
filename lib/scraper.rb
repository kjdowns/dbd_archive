
class DBDArchive::Scraper
  
  attr_accessor :doc 
  
  def initialize
    self.set_base_path
    #@doc = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
  end
  
  def set_base_path
    self.doc = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
  end
  
  def initialize_survivors
    self.doc.css("#fpsurvivors div.fplinks div.link").each do |surv| 
      DBDArchive::Survivor.new({:name => surv.text, :link => "https://deadbydaylight.gamepedia.com/#{surv.text.gsub(" ", "_")}"})
    end
    self.set_base_path
    DBDArchive::Survivor.all
  end
  
  def initialize_killers
    self.doc.css("#fpkiller div.fplinks div.link").each do |kill| 
      DBDArchive::Killer.new({:kill_name => kill.text, :link => "https://deadbydaylight.gamepedia.com/#{kill.text.gsub(" ", "_")}"})
    end
    self.set_base_path
    DBDArchive::Killer.all
  end
  
  def add_survivor_attr
    DBDArchive::Survivor.all.each do |survivor|
      self.doc = Nokogiri::HTML(open(survivor.link))
      survivor.gender = self.doc.css(".infoboxtable td")[1].text.strip
      survivor.role = self.doc.css(".infoboxtable td")[3].text.strip
      survivor.nationality = self.doc.css(".infoboxtable td")[5].text.strip
      lore_section = self.doc.css("div.floatleft ~ p")
      add_lore(survivor, lore_section)
      
      #normalize Jane's lore - structured differently
      if survivor.name == "Jane Romero"
        survivor.lore.shift(5)
      end
      
      # #exception for feng and laurie - attr stucture is different
      if survivor.name == "Feng Min" || survivor.name == "Laurie Strode"
        survivor.gender = self.doc.css(".infoboxtable td")[3].text.strip
        survivor.role = self.doc.css(".infoboxtable td")[5].text.strip
        survivor.nationality = self.doc.css(".infoboxtable td")[7].text.strip
      end
    end
    self.set_base_path
    DBDArchive::Survivor.all
  end
  
  def add_killer_attr
    DBDArchive::Killer.all.each do |killer|
      self.doc = Nokogiri::HTML(open(killer.link))
      killer.name = self.doc.css(".infoboxtable td")[1].text.strip
      killer.nickname = self.doc.css(".infoboxtable td")[3].text.strip
      killer.gender = self.doc.css(".infoboxtable td")[5].text.strip
      killer.nationality = self.doc.css(".infoboxtable td")[7].text.strip
      killer.weapon = self.doc.css(".infoboxtable td")[15].text.strip
      lore_section = self.doc.css("div.floatleft ~ p")
      add_lore(killer, lore_section)
      
      #normalize lore - structured differently
      if killer.kill_name == "The Plague" || killer.kill_name == "The Ghost Face"
        killer.lore.shift(5)
      end
      
      ##fixes exceptions##
      if killer.kill_name == "The Nurse" || killer.kill_name == "The Pig"
        killer.nickname = "None"
        killer.gender = self.doc.css(".infoboxtable td")[3].text.strip
        killer.nationality = self.doc.css(".infoboxtable td")[5].text.strip
        killer.weapon = self.doc.css(".infoboxtable td")[9].text.strip
      elsif killer.kill_name == "The Legion" || killer.kill_name == "The Spirit"
        killer.nickname = "None"
        killer.gender = self.doc.css(".infoboxtable td")[3].text.strip
        killer.nationality = self.doc.css(".infoboxtable td")[5].text.strip
        killer.weapon = self.doc.css(".infoboxtable td")[13].text.strip
      elsif killer.kill_name == "The Nightmare"
        killer.weapon = self.doc.css(".infoboxtable td")[13].text.strip
      end
    end
    self.set_base_path
    DBDArchive::Killer.all
  end
  
  def add_lore(character, lore_section)
    lore_section.each do |section|
      section.text.strip.include?("These are Perks") ? return : character.lore << section.text.strip
    end
  end
  
end


# surv list => doc.css("#fpsurvivors div.fplinks div.link") ~~name => list[i].text
# links for pages => https://deadbydaylight.gamepedia.com/#{name.gsub(" ", "_")}
# killer list => doc.css("#fpkiller div.fplinks div.link") ~~name => list[i].text ~link list[i]
# surv attr =>  ~~lore => doc.css("div.floatleft + p").text.strip 
# ~~gender => .css(".infoboxtable td")[1].text.strip ~~ role => .css(".infoboxtable td")[3].text ~~nat => .css(".infoboxtable td")[5].text
# killer attr => ~~name .css(".infoboxtable td")[1].text.strip ~~alias [3] ~~ gender [5] ~~nationality [7] ~~weapon [15]
# ~~speed css(".infoboxtable td")[17].text.strip.split("| ")[1] ~~terror_radius [19]
# 
#
# 
