RSpec.describe Decoru::Decorator do
  describe '#object' do
    it 'exposes the decorated object' do
      obj = Object.new
      expect(described_class.new(obj).object).to be(obj)
    end
  end

  describe '#decorated?' do
    it 'returns true' do
      obj = Object.new
      expect(described_class.new(obj).decorated?).to be(true)
    end
  end

  describe 'delegate' do
    let(:user) { double('user', first_name: 'Alice', last_name: 'Ruby') }

    class UserDecorator < Decoru::Decorator
      def full_name
        [first_name, last_name].join(' ')
      end
    end

    it 'delegates missing methods that exist on the object' do
      expect(UserDecorator.new(user).full_name).to eq 'Alice Ruby'
    end
  end
end
