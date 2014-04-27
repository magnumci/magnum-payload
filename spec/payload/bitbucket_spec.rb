require "spec_helper"

describe Magnum::Payload::Bitbucket do
  let(:data)    { fixture("bitbucket/git.json") }
  let(:payload) { described_class.new(data) }

  describe "#parse!" do
    context "with git payload" do
      let(:data) { fixture("bitbucket/git.json") }

      it "sets commit SHA" do
        expect(payload.commit).to eq "f15566c42759198fd32a70963d2509f3f8309586"
      end

      it "sets commit branch" do
        expect(payload.branch).to eq "master"
      end

      it "sets commit message" do
        expect(payload.message).to eq "Commit Sat Jan 19 18:42:40 CST 2013"
      end

      it "sets committer name" do
        expect(payload.committer).to eq nil
      end

      it "sets committer email" do
        expect(payload.committer_email).to eq nil
      end

      it "sets author name" do
        expect(payload.author).to eq "Dan Sosedoff"
      end

      it "sets author email" do
        expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
      end

      it "sets commit view url" do
        expect(payload.commit_url).to eq "https://bitbucket.org/sosedoff/test1/commits/f15566c42759198fd32a70963d2509f3f8309586"
      end

      it "sets compare url" do
        expect(payload.compare_url).to eq "https://bitbucket.org/sosedoff/test1/compare/e15c6013c0f6232153e53b003b97da51d338da3a..f15566c42759198fd32a70963d2509f3f8309586"
      end

      context "that does not have commits" do
        let(:data) { fixture("bitbucket/git_no_commits.json") }

        it "raises PayloadError exception" do
          expect { described_class.new(data) }.
            to raise_error Magnum::Payload::PayloadError, "Payload has no commits"
        end
      end
    end

    context "with mercurial payload" do
      let(:data) { fixture("bitbucket/hg.json") }

      it "sets commit SHA" do
        expect(payload.commit).to eq 4
      end

      it "sets commit branch" do
        expect(payload.branch).to eq "default"
      end

      it "sets commit message" do
        expect(payload.message).to eq "Commit 2"
      end

      it "sets author name" do
        payload.author.should eq "Dan Sosedoff"
      end

      it "sets author email" do
        expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
      end

      it "sets commit view url" do
        expect(payload.commit_url).to eq "https://bitbucket.org/sosedoff/mercurial-test/commits/4"
      end

      it "sets compare url" do
        expect(payload.compare_url).to eq "https://bitbucket.org/sosedoff/mercurial-test/compare/3..4"
      end
    end
  end

  describe "#site_url" do
    it "returns website url without a path" do
      expect(payload.site_url).to eq "https://bitbucket.org"
    end
  end

  describe "#repo_url" do
    it "return relative repository path" do
      expect(payload.repo_url).to eq "/sosedoff/test1/"
    end
  end

  describe "#make_url" do
    it "returns a full url to the repository" do
      expect(payload.make_url).to eq "https://bitbucket.org/sosedoff/test1/"
    end 

    it "returns a full url to the repository action" do
      expect(payload.make_url("commits/1234")).to eq "https://bitbucket.org/sosedoff/test1/commits/1234"
    end
  end
end