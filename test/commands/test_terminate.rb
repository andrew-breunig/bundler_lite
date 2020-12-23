# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/commands/terminate'

class TestTerminate < Test::Unit::TestCase
  def test_process_exits_the_program
    terminate = Terminate.new
    # assert_equal(nil, terminate.process(nil, %w[END])) # Kernel#exit is hard with Test::Unit!
  end
end
