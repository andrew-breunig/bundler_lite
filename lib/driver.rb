# frozen_string_literal: true

require_relative 'commands/command'
require_relative 'commands/initiate'
require_relative 'commands/terminate'
require_relative 'commands/unsupported'
require_relative 'packages/graph'

class Driver
  def initialize
    @graph = Graph.new
  end

  def run
    puts 'Hello, welcome to BundlerLite. Please specify length of instructions followed by one instruction per line:'
    input_length = process_input { |command| validate(command, Initiate, 'Please specify length of instructions.') }

    input_length.times { process_input }

    process_input { |command| validate(command, Terminate, "Exceeded specified instruction length: #{input_length}.") }
  end

  private

  attr_reader :graph

  def process_input
    current_input = gets.chomp.split || []
    current_command = Command.for(current_input.first).new
    current_command = yield current_command if block_given?
    current_command.process(graph, current_input)
  end

  def validate(current_command, expected_command, message)
    current_command.is_a?(expected_command) ? current_command : Unsupported.new(message)
  end
end
