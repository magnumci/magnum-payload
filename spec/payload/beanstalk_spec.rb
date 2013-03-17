require 'spec_helper'

describe Magnum::Payload::Beanstalk do
  let(:payload) { Magnum::Payload::Beanstalk.new(data) }

  describe '#parse!' do
    context 'with git payload' do
      let(:data) { fixture('beanstalk/git.json') }

      it 'sets commit SHA' do
        payload.commit.should eq '1111111111111111111111111111111111111111'
      end

      it 'sets commit branch' do
        payload.branch.should eq 'master'
      end

      it 'sets commit message' do
        payload.message.should eq 'Fake commit message'
      end

      it 'sets author and committer' do
        payload.author.should eq 'Mr Jones'
        payload.author_email.should eq 'john.jones@gmail.com'
      end

      it 'sets commit view url' do
        payload.commit_url.should eq 'http://sosedoff.beanstalkapp.com/xml-sitemap/changesets/1111111111111111111111111111111111111111'
      end

      it 'sets compare url' do
        payload.compare_url.should eq nil
      end
    end

    context 'with svn payload' do
      let(:data) { fixture('beanstalk/svn.json') }

      it 'sets commit number' do
        payload.commit.should eq 1
      end

      it 'sets commit message' do
        payload.message.should eq 'Creating initial repository structure'
      end

      it 'sets branch to master' do
        payload.branch.should eq 'master'
      end

      it 'sets author and committer' do
        payload.author.should eq 'admin'
        payload.committer.should eq 'admin'
      end

      it 'sets commit view url' do
        payload.commit_url.should_not eq nil
      end
    end

    context 'with mercurial payload' do
      let(:data) { fixture('beanstalk/hg.json') }

      it 'sets commit SHA' do
        payload.commit.should eq '1111111111111111111111111111111111111111'
      end

      it 'sets commit branch' do
        payload.branch.should eq 'default'
      end

      it 'sets commit message' do
        payload.message.should eq 'Fake commit message'
      end

      it 'sets author and committer' do
        payload.author.should eq 'Mr Jones'
        payload.author_email.should eq 'john.jones@gmail.com'
      end

      it 'sets commit view url' do
        payload.commit_url.should eq 'http://sosedoff.beanstalkapp.com/beanstalk-hg1/changesets/1111111111111111111111111111111111111111'
      end

      it 'sets compare url' do
        payload.compare_url.should eq nil
      end
    end
  end
end