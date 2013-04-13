require 'spec_helper'

describe Magnum::Payload::Github do
  describe '#parse!' do
    let(:data)    { fixture('github.json') }
    let(:payload) { Magnum::Payload::Github.new(data) }

    it 'sets commit sha' do
      payload.commit.should eq '9d227f327e725164c3266be74cf5c00678edad13'
    end

    it 'sets commit branch' do
      payload.branch.should eq 'master'
    end

    it 'sets commit message' do
      payload.message.should eq 'Remove jruby from test matrix'
    end

    it 'sets author' do
      payload.committer.should eq 'Dan Sosedoff'
      payload.committer_email.should eq 'dan.sosedoff@gmail.com'
    end

    it 'sets committer' do
      payload.author.should eq 'Dan Sosedoff'
      payload.author_email.should eq 'dan.sosedoff@gmail.com'
    end

    it 'sets commit view url' do
      payload.commit_url.should eq 'https://github.com/sosedoff/lxc-ruby/commit/9d227f327e725164c3266be74cf5c00678edad13'
    end

    it 'sets commit compare url' do
      payload.compare_url.should eq 'https://github.com/sosedoff/lxc-ruby/compare/0e46f019e391...9d227f327e72'
    end

    context 'when push is forced' do
      let(:data) { fixture 'github/forced.json' }

      it 'parses head commit' do
        payload.commit.should eq 'e7508c4c70d2c5afc1e6c2f3a42ecc098f435103'
      end
    end

    context 'for deleted branch' do
      let(:data) { fixture 'github/deleted.json' }

      it 'marks payload as skipped' do
        payload.skip.should be_true
      end
    end

    context 'for new branch' do
      let(:data) { fixture 'github/new_branch.json' }

      it 'sets commit sha' do
        payload.commit.should eq 'd9cc46f9e7e6aa65df696d8d1efe86de755b46ae'
      end

      it 'sets branch' do
        payload.branch.should eq 'hello'
      end
    end

    context 'for new tag' do
      let(:data) { fixture 'github/new_tag.json' }

      it 'marks payload as skipped' do
        payload.skip.should be_true
      end
    end
  end
end