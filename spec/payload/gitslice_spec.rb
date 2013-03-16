require 'spec_helper'

describe Magnum::Payload::Gitslice do
  let(:data)    { fixture('gitslice.json') }
  let(:payload) { Magnum::Payload::Gitslice.new(data) }

  describe '#parse!' do
    it 'sets commit SHA' do
      payload.commit.should eq('177d757ad97214f4546fb999e0be0783360e614e')
    end

    it 'sets commit branch' do
      payload.branch.should eq('source-type')
    end

    it 'sets commit message' do
      payload.message.should eq('Add initial 404 page')
    end

    it 'sets author and committer' do
      payload.committer.should eq('Dan Sosedoff')
      payload.author.should eq('Dan Sosedoff')
    end

    it 'sets commit view url' do
      payload.commit_url.should eq('http://gitslice.com/magnum-ci/commit/177d757ad97214f4546fb999e0be0783360e614e')
    end

    it 'sets compare url' do
      payload.compare_url.should eq('http://gitslice.com/magnum-ci/compare/b0445d963b7e3efaf47610ef710acc0ba3067a39...177d757ad97214f4546fb999e0be0783360e614e')
    end
  end
end