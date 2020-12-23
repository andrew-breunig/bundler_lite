# frozen_string_literal: true

require_relative 'commands/command'
require_relative 'commands/initiate'
require_relative 'commands/terminate'
require_relative 'commands/unsupported'
require_relative 'packages/graph'

class Driver
  def initialize
    @graph = Graph.new
    @current_command = nil
  end

  def run
    puts 'Hello, welcome to BundlerLite. Please specify length of instructions followed by one instruction per line:'
    input_length = process_input { validate(Initiate, 'Please specify length of instructions.') }

    input_length.times { process_input }

    process_input { validate(Terminate, "Exceeded specified instructions length: #{input_length}.") }
  end

  private

  attr_reader :graph, :current_command

  def process_input
    current_input = gets.chomp.split || []
    @current_command = Command.for(current_input.first).new
    yield if block_given?
    current_command.process(graph, current_input)
  end

  def validate(expected_command, message)
    @current_command = Unsupported.new(message) unless current_command.is_a?(expected_command)
  end
end
