# frozen_string_literal: true

require_relative 'package'

class Mutations
  def create_package(packages, name)
    Package.new(name).tap { |package| packages.append(package) }
  end

  def add_dependencies(package, dependencies)
    package.add_dependencies(dependencies)
  end

  def install_package(package, installer, installed)
    package.install(installer)
    installed.append(package.name)
  end

  def remove_package(package, removed)
    package.remove
    removed.append(package.name)
  end
end
