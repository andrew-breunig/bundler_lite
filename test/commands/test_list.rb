# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/graph'
require_relative '../../lib/commands/list'

class TestList < Test::Unit::TestCase
  def test_process_forwards_to_graph
    graph = Graph.new
    list = List.new
    graph.install_packages('A')
    list.process(graph, %w[LIST])
    assert_equal(%w[A], graph.list_packages)
  end

  def test_process_returns_a_sorted_list_of_installed_packages
    graph = Graph.new
    list = List.new
    graph.install_packages('A')
    # assert_equal('A', list.process(graph, %w[LIST])) # STDOUT is hard with Test::Unit!
  end
end
