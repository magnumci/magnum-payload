require 'spec_helper'

describe Magnum::Payload do
  describe ".valid_source?" do
    it "returns true if valid" do
      expect(Magnum::Payload.valid_source?("github")).to eq true
      expect(Magnum::Payload.valid_source?("gitlab")).to eq true
      expect(Magnum::Payload.valid_source?("bitbucket")).to eq true
      expect(Magnum::Payload.valid_source?("beanstalk")).to eq true
      expect(Magnum::Payload.valid_source?("custom")).to eq true
    end

    it "returns false if not valid" do
      expect(Magnum::Payload.valid_source?("foobar")).to eq false
    end
  end

  describe '.parse' do
    it 'returns payload instance for github' do
      payload = Magnum::Payload.parse('github', fixture('github.json'))
      expect(payload).to be_a Magnum::Payload::Github
    end

    it 'returns payload instance for gitlab' do
      payload = Magnum::Payload.parse('gitlab', fixture('gitlab/commits.json'))
      expect(payload).to be_a Magnum::Payload::Gitlab
    end

    it 'returns payload instance for bitbucket' do
      payload = Magnum::Payload.parse('bitbucket', fixture('bitbucket/git.json'))
      expect(payload).to be_a Magnum::Payload::Bitbucket
    end

    it 'returns payload instance for beanstalk' do
      payload = Magnum::Payload.parse('beanstalk', fixture('beanstalk/git.json'))
      expect(payload).to be_a Magnum::Payload::Beanstalk
    end

    it 'raises error if source is invalid' do
      expect { Magnum::Payload.parse('foobar', 'bar') }.
        to raise_error Magnum::Payload::PayloadError, 'Invalid payload type: foobar'
    end
  end
end