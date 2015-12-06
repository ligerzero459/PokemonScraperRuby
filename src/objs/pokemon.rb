class Pokemon

  def initialize(name, number)
    @name = name
    @number = number
  end

  def name=(name)
    @name = name
  end

  def name
    @name
  end

  def number=(number)
    @number = number
  end

  def number
    @number
  end

  attr_accessor :name
  attr_accessor :number

  def to_s
    number.to_s << ' ' << name
  end
end