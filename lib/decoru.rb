require 'decoru/version'
require 'decoru/railtie'
require 'decoru/decorator'
require 'decoru/decoratable'

module Decoru
  class UninferrableDecoratorError < NameError; end
end
