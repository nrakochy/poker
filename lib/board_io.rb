class BoardIO

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def get_input
    @input.gets
  end

  def print_output(output)
    @output.puts(output)
  end
end
