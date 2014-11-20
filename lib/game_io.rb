class GameIO

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def get_input
    @input.gets.chomp
  end

  def print_output(output)
    @output.puts(output)
  end
end
