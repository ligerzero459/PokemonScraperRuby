class TwoDArray

  def initialize(x, y)
    @array = []
    (1..x).each do |counter|
      temp_array = []
      (1..y).each do |j|
        temp_array.push(nil)
      end
      @array.push(temp_array)
    end
  end

  def array=(array)
    @array = array
  end

  def array
    @array
  end

  def push(obj)
    @array.push(obj)
  end

  def push_x(x, obj)
    @array[x].push(obj)
  end

  def [](x)
    @array[x]
  end

  attr_accessor :array

  def to_s
    string = "[\n"

    @array.each do |items|
      string += "["
      items.each do |j|
        string += "{" + j.to_s + "}"
      end
      string += "]\n"
    end

    string += "]"

    string
  end
end