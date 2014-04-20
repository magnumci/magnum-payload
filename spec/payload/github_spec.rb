require "spec_helper"

describe Magnum::Payload::Github do
  describe "#parse!" do
    let(:data)    { fixture("github.json") }
    let(:payload) { Magnum::Payload::Github.new(data) }

    it "sets commit sha" do
      expect(payload.commit).to eq "9d227f327e725164c3266be74cf5c00678edad13"
    end

    it "sets commit branch" do
      expect(payload.branch).to eq "master"
    end

    it "sets commit message" do
      expect(payload.message).to eq "Remove jruby from test matrix"
    end

    it "sets author name" do
      expect(payload.committer).to eq "Dan Sosedoff"
    end

    it "sets author email" do
      expect(payload.committer_email).to eq "dan.sosedoff@gmail.com"
    end

    it "sets committer name" do
      expect(payload.author).to eq "Dan Sosedoff"
    end

    it "sets committer email" do
      expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
    end

    it "sets commit view url" do
      expect(payload.commit_url).to eq "https://github.com/sosedoff/lxc-ruby/commit/9d227f327e725164c3266be74cf5c00678edad13"
    end

    it "sets commit compare url" do
      expect(payload.compare_url).to eq "https://github.com/sosedoff/lxc-ruby/compare/0e46f019e391...9d227f327e72"
    end

    context "when push is forced" do
      let(:data) { fixture "github/forced.json" }

      it "parses head commit" do
        expect(payload.commit).to eq "e7508c4c70d2c5afc1e6c2f3a42ecc098f435103"
      end
    end

    context "for deleted branch" do
      let(:data) { fixture "github/deleted.json" }

      it "marks payload as skipped" do
        expect(payload.skip).to be_true
      end
    end

    context "for new branch" do
      let(:data) { fixture "github/new_branch.json" }

      it "sets commit sha" do
        expect(payload.commit).to eq "d9cc46f9e7e6aa65df696d8d1efe86de755b46ae"
      end

      it "sets branch" do
        expect(payload.branch).to eq "hello"
      end
    end

    context "for new tag" do
      let(:data) { fixture "github/new_tag.json" }

      it "marks payload as skipped" do
        expect(payload.skip).to be_true
      end
    end

    context "for ping payload" do
      let(:data) { fixture "github/test.json" }

      it "marks payload as skipped" do
        expect(payload.skip).to be_true
      end
    end
  end
end