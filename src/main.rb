# External libraries
require 'nokogiri'
require 'open-uri'

# Internal dependencies
require './lib/two_d_array'

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
page_source = []
damage_taken_array = init_damage_taken

level_moves_array = nil
xy_moves_array = nil
oras_moves_array = nil
hm_moves_array = nil


# Program start
temp_source = Nokogiri::HTML(open('http://www.serebii.net/pokedex-xy/183.shtml')).to_s

=begin
  Put entire page source into an array, line by line. Will allow for better
  controlled iteration than each_line, will improve parsing
=end

temp_source.each_line do |line|
  page_source.push(line)
end

line_number = 0
while line_number <= page_source.length do
  if page_source[line_number].to_s.include?('<title>')
    puts page_source[line_number][7,40].split(' - ')[0]

  # Pokedex number
  elsif page_source[line_number].to_s.include?("<b>National")
    line_number += 1
    puts page_source[line_number].to_s[5, 3]
  elsif page_source[line_number].to_s.include?("<b>Central")
    line_number += 1
    puts page_source[line_number].to_s[5, 3]
  elsif page_source[line_number].to_s.include?("<b>Coastal")
    line_number += 1
    puts page_source[line_number].to_s[5, 3]
  elsif page_source[line_number].to_s.include?("<b>Mountain")
    line_number += 1
    puts page_source[line_number].to_s[5, 3]
  elsif page_source[line_number].to_s.include?("<b>Hoenn")
    line_number += 1
    puts page_source[line_number].to_s[5, 3]

  # Pokemon weaknesses
  elsif page_source[line_number].to_s.include?('attackdex-xy/fairy')
    line_number += 4
    (0..17).each do |count|
      damage_taken_array[count][1] = page_source[line_number][24,4].to_s.split('<')[0]
      line_number += 1
    end

  # Pokemon Level Up moves
  # There are multiple generations, so there are multiple identifiers to find the move tables
  elsif page_source[line_number].to_s.include?('Generation VI Level Up')  # Gen VI Moves
    level_moves_array = TwoDArray.new(0,0)
    line_number += 12
    while !page_source[line_number].to_s.include?('<table')
      level = page_source[line_number].to_s.split('>')[1].split('<')[0]
      if level == '&mdash;'
        level = '--'
      end
      line_number += 1
      move = page_source[line_number].to_s.split('>')[2].to_s.split('<')[0]
      level_moves_array.push([level, move])
      line_number += 10
    end
  elsif page_source[line_number].to_s.include?('xylevel')                 # X/Y Moves
    xy_moves_array = TwoDArray.new(0,0)
    line_number += 18
    while !page_source[line_number].to_s.include?('<table')
      level = page_source[line_number].to_s.split('>')[1].to_s.split('<')[0]
      if level == '&mdash;'
        level = '--'
      end
      line_number += 1
      move = page_source[line_number].to_s.split('>')[2].to_s.split('<')[0]
      xy_moves_array.push([level, move])
      line_number += 10
    end
  elsif page_source[line_number].to_s.include?('oraslevel')               # Omega Ruby/Alpha Sapphire Moves
    oras_moves_array = TwoDArray.new(0,0)
    line_number += 13
    while !page_source[line_number].to_s.include?('<table')
      level = page_source[line_number].to_s.split('>')[1].to_s.split('<')[0]
      if level == '&mdash;'
        level = '--'
      end
      line_number += 1
      move = page_source[line_number].to_s.split('>')[2].to_s.split('<')[0]
      oras_moves_array.push([level, move])
      line_number += 10
    end

  # Pokemon TM/HM moves
  elsif page_source[line_number].to_s.include?("class=\"fooevo\">TM")
    hm_moves_array = TwoDArray.new(0,0)
    line_number += 12
    while !page_source[line_number].to_s.include?('<table')
      hm_tm = page_source[line_number].to_s.split('>')[1].to_s.split('<')[0]
      if page_source[line_number].to_s.include?('<br>')
        hm_tm += "\n" + page_source[line_number].to_s.split('>')[2].to_s.split('<')[0]
      end

      # Replace Omega and Alpha symbols
      # Won't throw exception if they don't exist
      hm_tm.sub!('&Omega;R&alpha;S', 'Ruby/Sapphire')

      line_number += 1
      move = page_source[line_number].to_s.split('>')[2].to_s.split('<')[0]
      hm_moves_array.push([hm_tm, move])
      line_number += 10
    end

  # Pokemon egg moves
  # TODO: Parse Egg Moves
  elsif page_source[line_number].to_s.include?('"class=\"fooevo\">Egg"')

  end
  line_number += 1
end

puts 'X/Y Moves'
puts xy_moves_array.to_s + "\n"
puts 'Omega Ruby/Alpha Sapphire Moves'
puts oras_moves_array.to_s + "\n"
puts 'HM Moves'
puts hm_moves_array.to_s + "\n"
