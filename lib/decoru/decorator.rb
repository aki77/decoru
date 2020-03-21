require 'active_model'

module Decoru
  # adapted from https://github.com/thepracticaldev/dev.to/blob/2dbb558b30c15b2b77a7d67c41f8c9a303567e1f/app/decorators/application_decorator.rb
  class Decorator
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    delegate_missing_to :@object

    # ActiveModel compatibility
    delegate :to_param, :to_partial_path, to: :@object

    attr_reader :object

    def initialize(object)
      @object = object
    end

    def decorated?
      true
    end
  end
end
