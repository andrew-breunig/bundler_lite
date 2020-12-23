# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/commands/initiate'
require_relative '../../lib/packages/graph'

class TestInitiate < Test::Unit::TestCase
  def test_process_converts_input_string_to_number
    graph = Graph.new
    initiate = Initiate.new
    assert_equal(100, initiate.process(graph, %w[100]))
  end

  def test_process_converts_strings_containing_negative_numbers
    graph = Graph.new
    initiate = Initiate.new
    assert_equal(-100, initiate.process(graph, %w[-100]))
  end

  def test_process_converts_only_initial_character_group_of_input
    graph = Graph.new
    initiate = Initiate.new
    assert_equal(1, initiate.process(graph, %w[1 2 3]))
  end

  def test_process_converts_non_numeric_strings_to_zero
    graph = Graph.new
    initiate = Initiate.new
    assert_equal(0, initiate.process(graph, %w[UNSUPPORTED]))
  end
end
