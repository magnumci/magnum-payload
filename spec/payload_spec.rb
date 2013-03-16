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

    #it 'returns payload instance for gitlab' do
    #  payload = Magnum::Payload.parse('gitlab', fixture('gitlab.json'))
    #  payload.should be_a Magnum::Payload::Gitlab
    #end

    it 'returns payload instance for bitbucket' do
      payload = Magnum::Payload.parse('bitbucket', fixture('bitbucket.json'))
      payload.should be_a Magnum::Payload::Bitbucket
    end

    it 'returns payload instance for beanstalk' do
      payload = Magnum::Payload.parse('beanstalk', fixture('beanstalk/git.json'))
      payload.should be_a Magnum::Payload::Beanstalk
    end
  end
end