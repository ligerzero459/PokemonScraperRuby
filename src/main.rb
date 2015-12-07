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

def method_name
  puts "method called for #{object_id}"
end

# Variable declarations
previous_line = ""
damage_taken_array = nil
damage_table_read = false
damage_table_count = 0

level_moves_array = TwoDArray.new(0,0)
temp_moves_array = []
level_moves_read = false
move_read = false

hm_moves_array = TwoDArray.new(0,0)
hm_moves_read = false

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
  elsif line.include?("Generation VI Level Up")
    level_moves_read = true
  elsif line.include?("rowspan=\"2\"") && level_moves_read && !move_read
    level = line.split(">")[1].split("<")[0]
    if level == "&mdash;"
      level = "--"
    end
    temp_moves_array = [level, ""]
    move_read = true
  elsif line.include?("attackdex") && level_moves_read && move_read
    move = line.split(">")[2].split("<")[0]
    temp_moves_array[1] = move
    level_moves_array.push(temp_moves_array)
    move_read = false
  elsif line.include?("class=\"fooevo\">TM")
    level_moves_read = false
    move_read = false
    hm_moves_read = true
  elsif line.include?("rowspan=\"2\"") && hm_moves_read && !move_read
    hm_tm = line.split(">")[1].split("<")[0]
    if hm_tm == "&mdash;"
      hm_tm = "--"
    end
    temp_moves_array = [hm_tm, ""]
    move_read = true
  elsif line.include?("attackdex") && hm_moves_read && move_read
    move = line.split(">")[2].split("<")[0]
    temp_moves_array[1] = move
    hm_moves_array.push(temp_moves_array)
    move_read = false
  elsif line.include?("class=\"fooevo\">Egg")
    hm_moves_read = false
    move_read = false
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