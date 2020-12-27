# frozen_string_literal: true

class Depend
  PACKAGE_INDEX = 1
  DEPENDENCIES_INDEX_RANGE = (2..-1).freeze

  def process(graph, input)
    puts input.join(' ')
    add_dependencies(graph, input[PACKAGE_INDEX], input[DEPENDENCIES_INDEX_RANGE])
  end

  private

  def add_dependencies(graph, package, dependencies)
    cycle = graph.cycle(package, dependencies)
    if cycle
      puts "#{cycle} depends on #{package}, ignoring command"
    else
      graph.add_dependencies(package, dependencies)
      install_dependencies(graph, package) if graph.installed?(package)
    end
  end

  def install_dependencies(graph, package)
    installed = graph.install_packages(package)
    puts "#{package} is currently installed, installed #{installed.join(', ')}" if installed
  end
end
