require 'spec_helper'

describe Magnum::Payload::Base do
  before do
    Magnum::Payload::Base.any_instance.stub(:parse!)
  end

  describe '#new' do
    it 'assigns raw data attribute' do
      Magnum::Payload::Base.any_instance.stub(:parse_payload)

      payload = Magnum::Payload::Base.new("raw data")
      payload.raw_data.should eq 'raw data'
    end

    it 'assigns data attribute' do
      payload = Magnum::Payload::Base.new({'foo' => 'bar'})
      payload.data.should be_a Hashr
    end

    it 'accepts a String' do
      payload = Magnum::Payload::Base.new('{"foo":"bar"}')
      payload.data.should be_a Hashr
      payload.data.foo.should eq 'bar'
    end

    it 'accepts a Hash' do
      payload = Magnum::Payload::Base.new({'foo' => 'bar'})
      payload.data.should be_a Hashr
      payload.data.foo.should eq('bar')
    end

    it 'raises error on invalid input type' do
      expect { Magnum::Payload::Base.new(nil) }.to raise_error "String or Hash required"
    end
  end
end