# frozen_string_literal: true

class Install
  PACKAGE_INDEX = 1

  def process(graph, input)
    puts input.join(' ')
    installed = install_packages(graph, input[PACKAGE_INDEX])
    puts "Installed #{installed.join(', ')}" if installed
  end

  private

  def install_packages(graph, package)
    if graph.installed?(package)
      puts "#{package} is already installed, ignoring command"
    else
      graph.install_packages(package)
    end
  end
end
