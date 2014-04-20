require "spec_helper"

describe Magnum::Payload::MessageParser do
  let(:subject) { TestMessageParser.new }

  before do
    subject.stub(:message) { message }
  end

  describe "#skip_message?" do
    context "when no skip points" do
      let(:message) { "Commit message" }

      it "returns false" do
        expect(subject.skip_message?).to be_false
      end
    end
    
    ["[ci-skip]", "[ci skip]", "[skip ci]", "[skip-ci]"].each do |val|
      context "when message contains #{val}" do
        let(:message) { val }

        it "returns true" do
          expect(subject.skip_message?).to be_true
        end
      end
    end

    context "with multi-line message" do
      context "when first line is a skip" do
        let(:message) { "Commit message [skip-ci]\nCommit comments" }

        it "returns true" do
          expect(subject.skip_message?).to be_true
        end
      end

      context "when first lie is not a skip" do
        let(:message) { "Commit message\nLets skip [ci-skip]" }

        it "returns false" do
          expect(subject.skip_message?).to be_false
        end
      end
    end
  end
end