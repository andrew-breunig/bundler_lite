# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/graph'

class TestGraph < Test::Unit::TestCase
  def test_package_finds_package_if_it_exists
    graph = Graph.new
    graph.install_packages('A')
    assert_equal('A', graph.package('A').name)
  end

  def test_package_forwards_to_mutations_if_package_does_not_exist
    graph = Graph.new
    assert_equal('A', graph.package('A').name)
  end

  def test_add_dependencies_forwards_to_mutations_if_acyclic
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    assert_equal(['B'], graph.package('A').dependencies)
  end

  def test_add_dependencies_does_not_forward_to_mutations_if_cyclic
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.add_dependencies('B', %w[C])
    graph.add_dependencies('C', %w[D A])
    assert_equal([], graph.package('C').dependencies)
  end

  def test_install_packages_forwards_to_mutations_if_uninstalled
    graph = Graph.new
    graph.install_packages('A')
    assert_equal(['A'], graph.list_packages)
  end

  def test_install_packages_does_not_forward_to_mutations_if_installed
    graph = Graph.new
    graph.install_packages('A')
    graph.install_packages('A')
    assert_equal(['A'], graph.list_packages)
  end

  def test_remove_packages_forwards_to_mutations_if_removable
    graph = Graph.new
    graph.install_packages('A')
    graph.remove_packages('A')
    assert_equal([], graph.list_packages)
  end

  def test_remove_packages_does_not_forward_to_mutations_if_required
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.install_packages('A')
    graph.remove_packages('B')
    assert_equal(%w[A B], graph.list_packages)
  end

  def test_remove_packages_does_not_forward_to_mutations_if_installed_directly
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.install_packages('B')
    graph.install_packages('A')
    graph.remove_packages('A')
    assert_equal(['B'], graph.list_packages)
  end

  def test_list_packages_includes_installed_packages
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.add_dependencies('B', %w[C])
    graph.install_packages('A')
    assert_equal(%w[A B C], graph.list_packages)
  end

  def test_list_packages_does_not_include_removed_packages
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.add_dependencies('B', %w[C])
    graph.install_packages('A')
    graph.remove_packages('A')
    assert_equal([], graph.list_packages)
  end

  def test_list_packages_includes_packages_installed_directly_and_their_dependencies
    graph = Graph.new
    graph.add_dependencies('A', %w[B])
    graph.add_dependencies('B', %w[C])
    graph.install_packages('B')
    graph.install_packages('A')
    graph.remove_packages('A')
    assert_equal(%w[B C], graph.list_packages)
  end
end
