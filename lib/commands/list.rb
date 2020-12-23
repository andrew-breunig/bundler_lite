# frozen_string_literal: true

class List
  def process(graph, input)
    puts input.join(' ')
    listed_packages = list_packages(graph)
    puts listed_packages.join("\n")
  end

  private

  def list_packages(graph)
    graph.list_packages
  end
end
