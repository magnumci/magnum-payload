require "spec_helper"

describe Magnum::Payload::Bitbucket do
  let(:data)    { fixture("bitbucket/git.json") }
  let(:payload) { described_class.new(data) }

  describe "#parse!" do
    context "with git payload" do
      let(:data) { fixture("bitbucket/git.json") }

      it "parses payload" do
        expect(payload.commit).to eq "f15566c42759198fd32a70963d2509f3f8309586"
        expect(payload.branch).to eq "master"
        expect(payload.message).to eq "Commit Sat Jan 19 18:42:40 CST 2013"
        expect(payload.committer).to eq nil
        expect(payload.committer_email).to eq nil
        expect(payload.author).to eq "Dan Sosedoff"
        expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
        expect(payload.commit_url).to eq "https://bitbucket.org/sosedoff/test1/commits/f15566c42759198fd32a70963d2509f3f8309586"
        expect(payload.compare_url).to eq "https://bitbucket.org/sosedoff/test1/compare/e15c6013c0f6232153e53b003b97da51d338da3a..f15566c42759198fd32a70963d2509f3f8309586"
      end

      context "when no commits" do
        let(:data) { fixture("bitbucket/git_no_commits.json") }

        it "raises an exception" do
          expect { described_class.new(data) }.
            to raise_error Magnum::Payload::PayloadError, "Payload has no commits"
        end
      end
    end

    context "with new git payload" do
      let(:data) { fixture "bitbucket/git_new.json" }

      it "parses payload" do
        expect(payload.commit).to eq "9a8349584a87d4760519beb30de938bcf56739f5"
        expect(payload.branch).to eq "master"
        expect(payload.message).to eq "Update"
        expect(payload.committer).to eq nil
        expect(payload.committer_email).to eq nil
        expect(payload.author).to eq "Dan Sosedoff"
        expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
        expect(payload.commit_url).to eq "https://bitbucket.org/sosedoff/test-bitbucket-repo/commits/9a8349584a87d4760519beb30de938bcf56739f5"
        expect(payload.compare_url).to eq "https://bitbucket.org/sosedoff/test-bitbucket-repo/branches/compare/9a8349584a87d4760519beb30de938bcf56739f5..4da3ecc3e168597d1485ea5c84cee859ebfde5b4"
      end
    end

    context "with mercurial payload" do
      let(:data) { fixture("bitbucket/hg.json") }

      it "parses payload" do
        expect(payload.commit).to eq 4
        expect(payload.branch).to eq "default"
        expect(payload.message).to eq "Commit 2"
        expect(payload.author).to eq "Dan Sosedoff"
        expect(payload.author_email).to eq "dan.sosedoff@gmail.com"
        expect(payload.commit_url).to eq "https://bitbucket.org/sosedoff/mercurial-test/commits/4"
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