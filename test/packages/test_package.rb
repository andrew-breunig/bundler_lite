# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/package'

class TestPackage < Test::Unit::TestCase
  def test_name_default_is_unknown
    package = Package.new
    assert_equal('Unknown Package', package.name)
  end

  def test_name_set_on_initialization
    package = Package.new('A')
    assert_equal('A', package.name)
  end

  def test_dependencies_default_is_empty_list
    package = Package.new('A')
    assert_equal([], package.dependencies)
  end

  def test_dependencies_set_on_initialization
    package = Package.new('A', %w[B])
    assert_equal(%w[B], package.dependencies)
  end

  def test_add_dependencies_adds_dependencies_to_package
    package = Package.new('A')
    package.add_dependencies(%w[B])
    assert_equal(%w[B], package.dependencies)
  end

  def test_add_dependencies_adds_only_new_dependencies_to_package
    package = Package.new('A', %w[B])
    package.add_dependencies(%w[B C])
    assert_equal(%w[B C], package.dependencies)
  end

  def test_installed_default_is_false
    package = Package.new('A')
    assert_equal(false, package.installed?)
  end

  def test_installed_after_install
    package = Package.new('A')
    package.install('A')
    assert_equal(true, package.installed?)
  end

  def test_installed_after_remove
    package = Package.new('A')
    package.install('A')
    package.remove
    assert_equal(false, package.installed?)
  end

  def test_installed_directly_default_is_false
    package = Package.new('A')
    assert_equal(false, package.installed_directly?)
  end

  def test_installed_directly_after_installed_by_self
    package = Package.new('A')
    package.install('A')
    assert_equal(true, package.installed_directly?)
  end

  def test_installed_directly_after_installed_by_other
    package = Package.new('A')
    package.install('B')
    assert_equal(false, package.installed_directly?)
  end

  def test_installed_directly_after_remove
    package = Package.new('A')
    package.install('A')
    package.remove
    assert_equal(false, package.installed_directly?)
  end
end
