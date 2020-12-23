# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/graph'
require_relative '../../lib/commands/depend'

class TestDepend < Test::Unit::TestCase
  def test_process_forwards_to_graph_if_acyclic
    graph = Graph.new
    depend = Depend.new
    depend.process(graph, %w[DEPEND A B])
    assert_equal(%w[B], graph.package('A').dependencies)
  end

  def test_process_does_not_forward_to_graph_if_cyclic
    graph = Graph.new
    depend = Depend.new
    graph.add_dependencies('A', %w[B])
    graph.add_dependencies('B', %w[C])
    depend.process(graph, %w[DEPEND C D A])
    assert_equal([], graph.package('C').dependencies)
  end
end
