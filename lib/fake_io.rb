class FakeIO
  attr_accessor :input, :output

  def initialize 
    @input = []
    @output = []
  end

  def get_input 
    @input.shift
  end

  def print_output(output_line)
    @output << output_line
  end
end
