require "spec_helper"

class TestMessageParser
  include Magnum::Payload::MessageParser
end

describe Magnum::Payload::MessageParser do
  let(:subject) { TestMessageParser.new }

  describe "#skip_message?" do
    it "returns true when message contains 'ci-skip'" do
      subject.stub(:message).and_return("Commit message [ci-skip]")
      expect(subject.skip_message?).to be_true
    end

    it "returns true when message contains 'ci skip'" do
      subject.stub(:message).and_return("Commit message [ci skip]")
      expect(subject.skip_message?).to be_true
    end

    it "returns true when message contains 'skip ci'" do
      subject.stub(:message).and_return("Commit message [skip ci]")
      expect(subject.skip_message?).to be_true
    end

    it "returns true when message contains 'skip-ci'" do
      subject.stub(:message).and_return("Commit message [skip-ci]")
      expect(subject.skip_message?).to be_true
    end

    it "returns false if no skip points found" do
      subject.stub(:message).and_return("Commit message")
      expect(subject.skip_message?).to be_false
    end

    context "with multi-line message" do
      it "returns true" do
        subject.stub(:message).and_return("Commit message [skip-ci]\nCommit comments")
        expect(subject.skip_message?).to be_true
      end

      it "returns false" do
        subject.stub(:message).and_return("Commit message\nLets skip [ci-skip]")
        expect(subject.skip_message?).to be_false
      end
    end
  end
end