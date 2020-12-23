# frozen_string_literal: true

class Remove
  PACKAGE_INDEX = 1

  def process(graph, input)
    puts input.join(' ')
    removed = remove_packages(graph, input[PACKAGE_INDEX])
    puts "Removed #{removed.join(', ')}" if removed
  end

  private

  def remove_packages(graph, package)
    if !graph.installed?(package)
      puts "#{package} is not currently istalled"
    elsif graph.required?(package)
      puts "#{package} is required, ignoring command"
    else
      graph.remove_packages(package)
    end
  end
end
