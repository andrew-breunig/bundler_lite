# frozen_string_literal: true

require_relative 'mutations'

class Graph
  def initialize
    @packages = []
    @mutations = Mutations.new
  end

  def package(name)
    packages.find { |package| package.name == name } || mutations.create_package(packages, name)
  end

  def cycle(depender, dependencies)
    dependencies.find { |dependency| dependency_tree(dependency).map(&:name).include?(depender) }
  end

  def add_dependencies(depender, dependencies)
    mutations.add_dependencies(package(depender), dependencies) unless cycle(depender, dependencies)
  end

  def installed?(name)
    package(name).installed?
  end

  def install_packages(installer)
    dependency_tree(installer).reverse.each_with_object([]) do |dependency, installed|
      mutations.install_package(dependency, installer, installed) unless dependency.installed?
    end
  end

  def required?(name)
    packages.any? { |package| package.installed? && package.dependencies.include?(name) }
  end

  def remove_packages(remover)
    dependency_tree(remover).each_with_object([]) do |dependency, removed|
      mutations.remove_package(dependency, removed) if removable?(dependency, remover)
    end
  end

  def list_packages
    packages.select(&:installed?).map(&:name).sort
  end

  private

  attr_reader :packages, :mutations

  def dependency_tree(name)
    package = package(name)
    [package] | package.dependencies.flat_map { |dependency| dependency_tree(dependency) }
  end

  def removable?(package, remover)
    package.installed? && !required?(package.name) && !separate_installation?(package, remover)
  end

  def separate_installation?(package, remover)
    (package.name != remover) && package.installed_directly?
  end
end
