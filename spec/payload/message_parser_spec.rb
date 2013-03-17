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

    it 'returns false if no skip points found' do
      subject.stub(:message).and_return('Commit message')
      subject.skip_message?.should eq false
    end

    context 'with multi-line message' do
      it 'returns true' do
        subject.stub(:message).and_return("Commit message [skip-ci]\nCommit comments")
        subject.skip_message?.should eq true
      end

      it 'returns false' do
        subject.stub(:message).and_return("Commit message\nLets skip [ci-skip]")
        subject.skip_message?.should eq false
      end
    end
  end
end