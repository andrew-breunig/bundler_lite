# frozen_string_literal: true

class Terminate
  def process(_, input)
    puts input.join(' ')
    exit
  end
end
