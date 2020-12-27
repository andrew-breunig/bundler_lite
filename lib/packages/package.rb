# frozen_string_literal: true

class Package
  attr_reader :name, :dependencies, :installed, :installed_directly
  alias installed? installed
  alias installed_directly? installed_directly

  class MissingNameError < StandardError; end

  def initialize(name = nil, dependencies = [])
    raise MissingNameError, 'Package name is required' if name.nil?

    @name = name
    @dependencies = dependencies
    @installed = false
    @installed_directly = false
  end

  def add_dependencies(dependencies)
    @dependencies |= dependencies
  end

  def install(installed_directly:)
    @installed = true
    @installed_directly = installed_directly
  end

  def remove
    @installed = false
    @installed_directly = false
  end
end
