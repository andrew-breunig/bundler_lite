# frozen_string_literal: true

require_relative 'initiate'
require_relative 'depend'
require_relative 'install'
require_relative 'remove'
require_relative 'list'
require_relative 'terminate'
require_relative 'unsupported'

class Command
  SUPPORTED_COMMANDS = {
    /^\d+$/ => Initiate,
    'DEPEND' => Depend,
    'INSTALL' => Install,
    'REMOVE' => Remove,
    'LIST' => List,
    'END' => Terminate
  }.freeze
  UNSUPPORTED_COMMAND = Unsupported

  def self.for(input)
    (SUPPORTED_COMMANDS.find { |(type, _)| type === input }.to_a.last || UNSUPPORTED_COMMAND)
  end
end
