require 'spec_helper'

describe Magnum::Payload::Gitlab do
  let(:data)    { fixture('gitlab/commits.json') }
  let(:payload) { Magnum::Payload::Gitlab.new(data) }

  describe '#parse!' do
    it 'sets commit SHA' do
      payload.commit.should eq 'a96a0df33262e2d2fd1b20162553aae6750f8c00'
    end

    it 'sets commit branch' do
      payload.branch.should eq 'master'
    end

    it 'sets commit message' do
      payload.message.should eq 'Commit 2'
    end

    it 'sets author and committer' do
      payload.committer.should eq 'Dan Sosedoff'
      payload.author.should eq 'Dan Sosedoff'
    end

    it 'sets commit view url' do
      payload.commit_url.should eq 'https://gitlab.com/sosedoff/bar/commit/a96a0df33262e2d2fd1b20162553aae6750f8c00'
    end

    it 'does not set compare url' do
      payload.compare_url.should eq nil
    end
  end
end