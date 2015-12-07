# External libraries
require 'nokogiri'
require 'open-uri'

# Internal dependencies
require '../lib/two_d_array'

# Methods

def init_damage_taken
  # init new 2D array with library
  damage_taken = TwoDArray.new(18, 2)

  # push all damage types
  damage_taken[0][0] = "Normal"
  damage_taken[1][0] = "Fire"
  damage_taken[2][0] = "Water"
  damage_taken[3][0] = "Electric"
  damage_taken[4][0] = "Grass"
  damage_taken[5][0] = "Ice"
  damage_taken[6][0] = "Fighting"
  damage_taken[7][0] = "Poison"
  damage_taken[8][0] = "Ground"
  damage_taken[9][0] = "Flying"
  damage_taken[10][0] = "Psychic"
  damage_taken[11][0] = "Bug"
  damage_taken[12][0] = "Rock"
  damage_taken[13][0] = "Ghost"
  damage_taken[14][0] = "Dragon"
  damage_taken[15][0] = "Dark"
  damage_taken[16][0] = "Steel"
  damage_taken[17][0] = "Fairy"

  # return new array
  damage_taken
end

# Variable declarations
previous_line = ""
damage_taken_array = nil
damage_table_read = false
damage_table_count = 0

# Program start
page_source = Nokogiri::HTML(open('http://www.serebii.net/pokedex-xy/004.shtml')).to_s

page_source.each_line do |line|
  if line.include?("<title>")
    puts line[7,40].split(" - ")[0]
  elsif line.include?("attackdex-xy/fairy")
    damage_taken_array = init_damage_taken
    damage_table_read = true
  elsif line.include?("<td class=\"footype\">*") && damage_table_read
    damage_taken_array[damage_table_count][1] = line[24,4].split("<")[0]
    damage_table_count += 1
    if damage_table_count == 18
      damage_table_read = false
    end
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

puts damage_taken_array
puts damage_taken_array.length
puts damage_taken_array[0].length