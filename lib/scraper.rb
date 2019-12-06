
class DBDArchive::Scraper
  
  attr_accessor :doc 
  
  def initialize
    self.set_base_path
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
      elsif killer.kill_name == "The Legion" || killer.kill_name == "The Spirit" || killer.kill_name == "The Oni"
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
    #last item is empty and should be removed
    character.lore.pop()
  end
  
  def add_realm_lore(realm)
      self.doc.css("p i").each do |section|
        section.text.strip.include?("This piece of Lore") ? return : realm.lore << section.text.strip
      end
  end
  
  def initialize_realms
    self.doc.css("div#fpRealms div.fplinks a").each do |realm|
      unless realm.text.empty?
        DBDArchive::Realm.new({:name => realm.text, :link => "https://deadbydaylight.gamepedia.com/#{realm.text.gsub(" ", "_")}"})
      end
    end
    DBDArchive::Realm.all
  end
  
  def add_realm_attr
    DBDArchive::Realm.all.each do |realm|
      #special case to handle non ascii character
      if realm.name.include?("é")
        realm.link = "https://deadbydaylight.gamepedia.com/L%C3%A9ry%27s_Memorial_Institute"
      end
      self.doc = Nokogiri::HTML(open(realm.link))
      self.doc.css(".wikitable")[0].css("td center a").each{|node| realm.maps << node.text}
      lore = self.doc.css("p i")
      add_realm_lore(realm)
      realm.lore.shift
      
      #normalize Red Forest Lore 
      if realm.name == "Red Forest"
        realm.lore.pop(2)
      end
    end
    DBDArchive::Realm.all
  end
  
end

