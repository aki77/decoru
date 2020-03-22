module Decoru
  module Decoratable
    extend ActiveSupport::Concern

    class_methods do
      # Decorate collection with appropriate decorator
      def decorate
        all.map(&:decorate)
      end

      alias_method :decoru, :decorate

      # Infers the decorator class to be used by (e.g. `User` maps to `UserDecorator`).
      # adapted from https://github.com/drapergem/draper/blob/157eb955072a941e6455e0121fca09a989fcbc21/lib/draper/decoratable.rb#L71
      def decorator_class(called_on = self)
        prefix = respond_to?(:model_name) ? model_name : name
        decorator_name = "#{prefix}Decorator"
        decorator_name_constant = decorator_name.safe_constantize
        return decorator_name_constant unless decorator_name_constant.nil?

        return superclass.decorator_class(called_on) if superclass.respond_to?(:decorator_class)

        raise Decoru::UninferrableDecoratorError, "Could not infer a decorator for #{called_on.name}."
      end
    end

    # Decorate object with appropriate decorator
    def decorate
      self.class.decorator_class.new(self)
    end

    alias_method :decoru, :decorate

    def decorated?
      false
    end
  end
end
