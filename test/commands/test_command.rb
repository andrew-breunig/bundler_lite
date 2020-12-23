# frozen_string_literal: true

require 'test/unit'
require_relative '../../lib/commands/command'
require_relative '../../lib/commands/initiate'
require_relative '../../lib/commands/depend'
require_relative '../../lib/commands/install'
require_relative '../../lib/commands/remove'
require_relative '../../lib/commands/list'
require_relative '../../lib/commands/terminate'
require_relative '../../lib/commands/unsupported'

class TestCommand < Test::Unit::TestCase
  def test_for_when_provided_a_number
    assert_equal(Initiate, Command.for('100'))
  end

  def test_for_when_provided_depend
    assert_equal(Depend, Command.for('DEPEND'))
  end

  def test_for_when_provided_install
    assert_equal(Install, Command.for('INSTALL'))
  end

  def test_for_when_provided_remove
    assert_equal(Remove, Command.for('REMOVE'))
  end

  def test_for_when_provided_list
    assert_equal(List, Command.for('LIST'))
  end

  def test_for_when_provided_end
    assert_equal(Terminate, Command.for('END'))
  end

  def test_for_when_unsupported
    assert_equal(Unsupported, Command.for('UNSUPPORTED'))
  end

  def test_for_is_case_sensitive
    assert_equal(Unsupported, Command.for('Depend'))
  end
end
