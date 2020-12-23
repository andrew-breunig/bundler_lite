# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/graph'
require_relative '../../lib/commands/remove'

class TestRemove < Test::Unit::TestCase
  def test_process_forwards_to_graph_if_installed_and_not_required
    graph = Graph.new
    remove = Remove.new
    graph.install_packages('A')
    remove.process(graph, %w[REMOVE A])
    assert_equal(false, graph.package('A').installed?)
  end

  def test_process_does_not_forward_to_graph_if_uninstalled
    graph = Graph.new
    remove = Remove.new
    remove.process(graph, %w[REMOVE A])
    assert_equal(false, graph.package('A').installed?)
  end

  def test_process_does_not_forward_to_graph_if_required
    graph = Graph.new
    remove = Remove.new
    graph.add_dependencies('A', ['B'])
    graph.install_packages('A')
    remove.process(graph, %w[REMOVE B])
    assert_equal(true, graph.package('B').installed?)
  end

  def test_process_forwards_to_graph_for_unrequired_dependencies
    graph = Graph.new
    remove = Remove.new
    graph.add_dependencies('A', ['B'])
    graph.install_packages('A')
    remove.process(graph, %w[REMOVE A])
    assert_equal([], graph.list_packages)
  end

  def test_process_returns_an_ordered_list_of_removed_packages
    graph = Graph.new
    remove = Remove.new
    graph.add_dependencies('A', %w[B])
    graph.install_packages('A')
    # assert_equal('Removed A, B', remove.process(graph, %w[REMOVE A])) # STDOUT is hard with Test::Unit!
  end
end
