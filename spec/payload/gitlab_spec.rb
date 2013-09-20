require "spec_helper"

describe Magnum::Payload::Gitlab do
  let(:data)    { fixture("gitlab/commits.json") }
  let(:payload) { Magnum::Payload::Gitlab.new(data) }

  describe "#parse!" do
    it "sets commit SHA" do
      expect(payload.commit).to eq "a96a0df33262e2d2fd1b20162553aae6750f8c00"
    end

    it "sets commit branch" do
      expect(payload.branch).to eq "master"
    end

    it "sets commit message" do
      expect(payload.message).to eq "Commit 2"
    end

    it "sets commit author" do
      expect(payload.author).to eq "Dan Sosedoff"
    end

    it "sets commit committer" do
      expect(payload.committer).to eq "Dan Sosedoff"
    end

    it "sets commit view url" do
      expect(payload.commit_url).
        to eq "https://gitlab.com/sosedoff/bar/commit/a96a0df33262e2d2fd1b20162553aae6750f8c00"
    end

    it "does not set compare url" do
      expect(payload.compare_url).to eq nil
    end

    context "on new branch" do
      let(:data) { fixture("gitlab/create_branch.json") }

      it "sets commit SHA" do
        expect(payload.commit).to eq "0188ef243dd8083a4d4761766342b523d521247d"
      end

      it "sets branch to foobar" do
        expect(payload.branch).to eq "foobar"
      end
    end

    context "on deleted branch" do
      let(:data) { fixture("gitlab/delete_branch.json") }

      it "sets skip to true " do
        expect(payload.skip).to eq true
      end
    end

    context "on head with slash" do
      let(:data) { fixture("gitlab/branch_with_slash.json") }

      it "returns correct branch name" do
        expect(payload.branch).to eq "issue/broken-feature"
      end
    end
  end
end