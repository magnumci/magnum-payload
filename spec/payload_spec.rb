require 'spec_helper'

describe Magnum::Payload do
  describe '.parse' do
    it 'returns payload instance for github' do
      payload = Magnum::Payload.parse('github', fixture('github.json'))
      payload.should be_a Magnum::Payload::Github
    end

    it 'returns payload instance for gitslice' do
      payload = Magnum::Payload.parse('gitslice', fixture('gitslice.json'))
      payload.should be_a Magnum::Payload::Gitslice
    end

    it 'returns payload instance for gitlab' do
      payload = Magnum::Payload.parse('gitlab', fixture('gitlab/commits.json'))
      payload.should be_a Magnum::Payload::Gitlab
    end

    it 'returns payload instance for bitbucket' do
      payload = Magnum::Payload.parse('bitbucket', fixture('bitbucket/git.json'))
      payload.should be_a Magnum::Payload::Bitbucket
    end

    it 'returns payload instance for beanstalk' do
      payload = Magnum::Payload.parse('beanstalk', fixture('beanstalk/git.json'))
      payload.should be_a Magnum::Payload::Beanstalk
    end

    it 'raises error if source is invalid' do
      expect { Magnum::Payload.parse('foobar', 'bar') }.
        to raise_error Magnum::Payload::PayloadError, 'Invalid payload type: foobar'
    end
  end
end