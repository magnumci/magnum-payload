require "spec_helper"

describe Magnum::Payload do
  describe ".valid_source?" do
    %w(github gitlab bitbucket beanstalk custom).each do |source|
      it "returns true for #{source}" do
        expect(described_class.valid_source?(source)).to be_true
      end
    end
    
    it "returns false if not valid" do
      expect(described_class.valid_source?("foobar")).to eq false
    end
  end

  describe ".parse" do
    it "returns payload instance for github" do
      payload = described_class.parse("github", fixture("github.json"))
      expect(payload).to be_a Magnum::Payload::Github
    end

    it "returns payload instance for gitlab" do
      payload = described_class.parse("gitlab", fixture("gitlab/commits.json"))
      expect(payload).to be_a Magnum::Payload::Gitlab
    end

    it "returns payload instance for bitbucket" do
      payload = described_class.parse("bitbucket", fixture("bitbucket/git.json"))
      expect(payload).to be_a Magnum::Payload::Bitbucket
    end

    it "returns payload instance for beanstalk" do
      payload = described_class.parse("beanstalk", fixture("beanstalk/git.json"))
      expect(payload).to be_a Magnum::Payload::Beanstalk
    end

    it "raises error if source is invalid" do
      expect { described_class.parse("foobar", "bar") }.
        to raise_error Magnum::Payload::PayloadError, "Invalid payload type: foobar"
    end
  end
end