class Color
  attr_reader :code, :name

  def initialize(color_name, color_code)
    @name = color_name
    @code = color_code
  end
end
