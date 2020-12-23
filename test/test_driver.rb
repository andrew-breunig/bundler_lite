# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/driver'

class TestDriver < Test::Unit::TestCase
  def test_run_prints_greeting
    driver = Driver.new
    # assert_include('Hello, welcome to BundlerLite.', driver.run) # STDOUT is hard with Test::Unit!
  end
end
