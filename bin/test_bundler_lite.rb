#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'

Dir[File.join(File.expand_path('../test/**/test_*.rb', __dir__))].sort.each { |test_file| require test_file }
