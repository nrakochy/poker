class FakeIO
  attr_accessor :input, :output
  MESSAGE_FOR_TEST = "Test Message"

  def initialize 
    @input = []
    @output = []
  end

  def get_input
    @input.shift
  end

  def print_output(output_line = MESSAGE_FOR_TEST)
    @output = output_line.split(" ")
  end
end
