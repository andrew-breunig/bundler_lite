# frozen_string_literal: true

class Package
  attr_reader :name, :dependencies, :installed, :installed_directly
  alias installed? installed
  alias installed_directly? installed_directly

  def initialize(name = 'Unknown Package', dependencies = [])
    @name = name
    @dependencies = dependencies
    @installed = false
    @installed_directly = false
  end

  def add_dependencies(dependencies)
    @dependencies |= dependencies
  end

  def install(installer)
    @installed = true
    @installed_directly = true if installer == name
  end

  def remove
    @installed = false
    @installed_directly = false
  end
end
