require 'spec_helper'

describe Magnum::Payload::MessageParser do
  let(:klass) { class Klass ; include Magnum::Payload::MessageParser ; end }
  let(:subject) { klass.new }

  describe '#skip_message?' do
    it 'returns true when message contains "ci-skip"' do
      subject.stub(:message).and_return('Commit message [ci-skip]')
      subject.skip_message?.should eq true
    end

    it 'returns true when message contains "ci skip"' do
      subject.stub(:message).and_return('Commit message [ci skip]')
      subject.skip_message?.should eq true
    end

    it 'returns true when message contains "skip ci"' do
      subject.stub(:message).and_return('Commit message [skip ci]')
      subject.skip_message?.should eq true
    end

    it 'returns true when message contains "skip-ci"' do
      subject.stub(:message).and_return('Commit message [skip-ci]')
      subject.skip_message?.should eq true
    end
  end
end