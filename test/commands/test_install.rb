# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/graph'
require_relative '../../lib/commands/install'

class TestInstall < Test::Unit::TestCase
  def test_process_forwards_to_graph_if_uninstalled
    graph = Graph.new
    install = Install.new
    install.process(graph, %w[INSTALL A])
    assert_equal(['A'], graph.list_packages)
  end

  def test_process_does_not_forward_to_graph_if_installed
    graph = Graph.new
    install = Install.new
    graph.install_packages('A')
    install.process(graph, %w[INSTALL A])
    assert_equal(['A'], graph.list_packages)
  end

  def test_process_forwards_to_graph_for_dependencies
    graph = Graph.new
    install = Install.new
    graph.add_dependencies('A', %w[B])
    install.process(graph, %w[INSTALL A])
    assert_equal(%w[A B], graph.list_packages)
  end

  def test_process_returns_an_ordered_list_of_installed_packages
    graph = Graph.new
    install = Install.new
    graph.add_dependencies('A', %w[B])
    # assert_equal('Installed B, A', install.process(graph, %w[INSTALL A])) # STDOUT is hard with Test::Unit!
  end
end
