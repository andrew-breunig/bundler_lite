# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/packages/mutations'
require_relative '../../lib/packages/package'

class TestMutations < Test::Unit::TestCase
  def test_create_package_creates_package_and_appends_to_list
    packages = []
    mutations = Mutations.new
    mutations.create_package(packages, 'A')
    assert_equal('A', packages.first.name)
  end

  def test_create_package_returns_package_name
    packages = []
    mutations = Mutations.new
    package = mutations.create_package(packages, 'A')
    assert_equal(package.name, packages.first.name)
  end

  def test_add_dependencies_adds_dependencies
    mutations = Mutations.new
    package = Package.new
    mutations.add_dependencies(package, %w[B])
    assert_equal(['B'], package.dependencies)
  end

  def test_add_dependencies_adds_only_new_dependencies
    mutations = Mutations.new
    package = Package.new
    mutations.add_dependencies(package, %w[B C])
    mutations.add_dependencies(package, ['B'])
    assert_equal(%w[B C], package.dependencies)
  end

  def test_install_package_installs_package
    mutations = Mutations.new
    package = Package.new
    mutations.install_package(package, package.name, [])
    assert_equal(true, package.installed?)
  end

  def test_install_package_appends_package_name_to_installed_packages
    mutations = Mutations.new
    package = Package.new
    installed_packages = []
    mutations.install_package(package, package.name, installed_packages)
    assert_equal([package.name], installed_packages)
  end

  def test_remove_package_removes_package
    mutations = Mutations.new
    package = Package.new
    mutations.install_package(package, package.name, [])
    mutations.remove_package(package, [])
    assert_equal(false, package.installed?)
  end

  def test_remove_package_appends_package_name_to_removed_packages
    mutations = Mutations.new
    package = Package.new
    removed_packages = []
    mutations.install_package(package, package.name, [])
    mutations.remove_package(package, removed_packages)
    assert_equal([package.name], removed_packages)
  end
end
