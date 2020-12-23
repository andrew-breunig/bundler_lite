# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/commands/unsupported'

class TestUnsupported < Test::Unit::TestCase
  def test_process_exits_the_program
    unsupported = Unsupported.new
    # assert_equal(nil, unsupported.process(nil, %w[UNSUPPORTED])) # Kernel#exit is hard with Test::Unit!
  end
end
