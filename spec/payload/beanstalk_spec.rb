require 'spec_helper'

describe Magnum::Payload::Beanstalk do
  let(:data)    { fixture('beanstalk/git.json') }
  let(:payload) { Magnum::Payload::Beanstalk.new(data) }

  describe '#parse!' do
    it 'sets commit SHA' do
      payload.commit.should eq('1111111111111111111111111111111111111111')
    end

    it 'sets commit branch' do
      payload.branch.should eq('master')
    end

    it 'sets commit message' do
      payload.message.should eq('Fake commit message')
    end

    it 'sets author and committer' do
      payload.author.should eq('Mr Jones')
      payload.author_email.should eq('john.jones@gmail.com')
    end

    it 'sets commit view url' do
      payload.commit_url.should eq('http://sosedoff.beanstalkapp.com/xml-sitemap/changesets/1111111111111111111111111111111111111111')
    end

    it 'sets compare url' do
      payload.compare_url.should be_nil
    end
  end
end