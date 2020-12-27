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

  def test_create_package_returns_package
    packages = []
    mutations = Mutations.new
    assert_equal('A', mutations.create_package(packages, 'A').name)
  end

  def test_add_dependencies_forwards_to_package
    mutations = Mutations.new
    package = Package.new('A')
    mutations.add_dependencies(package, %w[B])
    assert_equal(%w[B], package.dependencies)
  end

  def test_install_package_forwards_to_package
    mutations = Mutations.new
    package = Package.new('A')
    mutations.install_package(package, 'A', [])
    assert_equal(true, package.installed?)
  end

  def test_install_package_indicates_installed_directly_when_installer_is_self
    mutations = Mutations.new
    package = Package.new('A')
    mutations.install_package(package, 'A', [])
    assert_equal(true, package.installed_directly?)
  end

  def test_install_package_indicates_not_installed_directly_when_installer_is_other
    mutations = Mutations.new
    package = Package.new('A')
    mutations.install_package(package, 'B', [])
    assert_equal(false, package.installed_directly?)
  end

  def test_install_package_appends_package_name_to_installed_packages
    mutations = Mutations.new
    package = Package.new('A')
    installed_packages = []
    mutations.install_package(package, 'A', installed_packages)
    assert_equal(%w[A], installed_packages)
  end

  def test_remove_package_forwards_to_package
    mutations = Mutations.new
    package = Package.new('A')
    mutations.install_package(package, 'A', [])
    mutations.remove_package(package, [])
    assert_equal(false, package.installed?)
  end

  def test_remove_package_appends_package_name_to_removed_packages
    mutations = Mutations.new
    package = Package.new('A')
    removed_packages = []
    mutations.install_package(package, 'A', [])
    mutations.remove_package(package, removed_packages)
    assert_equal(%w[A], removed_packages)
  end
end
