RSpec.describe Decoru::Decoratable do
  class Product
    include Decoru::Decoratable

    def self.all
      %w[product1 product2 product3]
    end
  end

  class ProductDecorator < Decoru::Decorator
  end

  describe '#decorate' do
    it 'returns a decorator for self' do
      product = Product.new
      decorator = product.decorate

      expect(decorator).to be_a ProductDecorator
      expect(decorator.object).to be product
    end
  end

  describe '#decorated?' do
    it 'returns false' do
      expect(Product.new).not_to be_decorated
    end
  end

  describe '.decorate' do
    it 'delegates missing methods that exist on the object' do
      product = Product.new
      scoped = [product]
      allow(product).to receive(:decorate).and_return(:decorated)
      allow(Product).to receive(:all).and_return(scoped)

      expect(Product.decorate).to eq [:decorated]
    end
  end

  describe '.decorater_class' do
    class Person
      include Decoru::Decoratable
    end

    class Child < Person
    end

    it 'returns decorator class' do
      expect(Product.decorator_class).to eq ProductDecorator
    end

    it "specifies the class that #decorator_class was first called on (superclass)" do
      expect { Person.decorator_class }.to raise_error(Decoru::UninferrableDecoratorError, 'Could not infer a decorator for Person.')
    end

    it "specifies the class that #decorator_class was first called on (subclass)" do
      expect { Child.decorator_class }.to raise_error(Decoru::UninferrableDecoratorError, 'Could not infer a decorator for Child.')
    end
  end
end
