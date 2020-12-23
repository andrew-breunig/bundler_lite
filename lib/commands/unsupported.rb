# frozen_string_literal: true

class Unsupported
  def initialize(message = 'Unsupported command:')
    @message = message
  end

  def process(_, input)
    puts "#{message}\n#{input.join(' ')}"
    exit
  end

  private

  attr_reader :message
end
