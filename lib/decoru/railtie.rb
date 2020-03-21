require 'rails/railtie'

module Decoru
  class Railtie < Rails::Railtie
    initializer :decoru do
      ActiveSupport.on_load :active_record do
        self.include Decoratable
      end
    end
  end
end
