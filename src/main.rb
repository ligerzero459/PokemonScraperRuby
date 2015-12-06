require 'nokogiri'
require 'open-uri'

class Main
  previous_line = ""
  page = Nokogiri::HTML(open('http://www.serebii.net/pokedex-xy/004.shtml')).to_s

  page.each_line do |line|
    if line.include?("<title>")
      puts line[7,40].split(" - ")[0]
    end

    if previous_line.include?("<b>National")
      puts previous_line
      puts line
    elsif previous_line.include?("<b>Central")
      puts previous_line
      puts line
    elsif previous_line.include?("<b>Coastal")
      puts previous_line
      puts line
    elsif previous_line.include?("<b>Mountain")
      puts previous_line
      puts line
    elsif previous_line.include?("<b>Hoenn")
      puts previous_line
      puts line
    end

    previous_line = line
  end
end