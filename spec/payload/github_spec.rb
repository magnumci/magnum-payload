require 'spec_helper'

describe Magnum::Payload::Github do
  describe '#parse!' do
    let(:data)    { fixture('github.json') }
    let(:payload) { Magnum::Payload::Github.new(data) }

    it 'sets commit SHA' do
      payload.commit.should eq('9d227f327e725164c3266be74cf5c00678edad13')
    end

    it 'sets commit branch' do
      payload.branch.should eq('master')
    end

    it 'sets commit message' do
      payload.message.should eq('Remove jruby from test matrix')
    end

    it 'sets author and committer' do
      payload.committer.should eq('Dan Sosedoff')
      payload.committer_email.should eq('dan.sosedoff@gmail.com')

      payload.author.should eq('Dan Sosedoff')
      payload.author_email.should eq('dan.sosedoff@gmail.com')
    end

    it 'sets commit view url' do
      payload.commit_url.should eq('https://github.com/sosedoff/lxc-ruby/commit/9d227f327e725164c3266be74cf5c00678edad13')
    end

    it 'sets compare url' do
      payload.compare_url.should eq('https://github.com/sosedoff/lxc-ruby/compare/0e46f019e391...9d227f327e72')
    end

    context 'when payload is forced' do
      let(:data) { fixture 'github/forced.json' }

      it 'does someting' do
        payload.commit.should eq 'e7508c4c70d2c5afc1e6c2f3a42ecc098f435103'
      end
    end
  end
end