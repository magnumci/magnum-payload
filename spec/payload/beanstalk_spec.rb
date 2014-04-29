require "spec_helper"

describe Magnum::Payload::Beanstalk do
  let(:payload) { Magnum::Payload::Beanstalk.new(data) }

  describe "#parse!" do
    context "with git payload" do
      let(:data) { fixture "beanstalk/git.json" }

      it "sets commit SHA" do
        expect(payload.commit).to eq "1111111111111111111111111111111111111111"
      end

      it "sets commit branch" do
        expect(payload.branch).to eq "master"
      end

      it "sets commit message" do
        expect(payload.message).to eq "Fake commit message"
      end

      it "sets author name" do
        expect(payload.author).to eq "Mr Jones"
      end

      it "sets auther email" do
        expect(payload.author_email).to eq "john.jones@gmail.com"
      end

      it "sets commit view url" do
        expect(payload.commit_url).to eq "http://sosedoff.beanstalkapp.com/xml-sitemap/changesets/1111111111111111111111111111111111111111"
      end

      it "sets compare url" do
        expect(payload.compare_url).to be_nil
      end

      context "when fake" do
        let(:data) { fixture "beanstalk/git.json" }

        it "sets skip to true" do
          expect(payload.skip).to be_true
        end

        it "sets test to true" do
          expect(payload.test).to be_true
        end
      end

      context "when deleted branch" do
        let(:data) { fixture "beanstalk/git_branch_delete.json" }

        it "sets skip to true" do
          expect(payload.skip).to be_true
        end
      end
    end

    context "with svn payload" do
      let(:data) { fixture "beanstalk/svn.json" }

      it "sets commit number" do
        expect(payload.commit).to eq 1
      end

      it "sets commit message" do
        expect(payload.message).to eq "Creating initial repository structure"
      end

      it "sets branch to master" do
        expect(payload.branch).to eq "master"
      end

      it "sets author" do
        expect(payload.author).to eq "admin"
      end

      it "sets committer" do
        expect(payload.committer).to eq "admin"
      end

      it "sets commit view url" do
        expect(payload.commit_url).not_to be_nil
      end
    end

    context "with mercurial payload" do
      let(:data) { fixture "beanstalk/hg.json" }

      it "sets commit SHA" do
        expect(payload.commit).to eq "1111111111111111111111111111111111111111"
      end

      it "sets commit branch" do
        expect(payload.branch).to eq "default"
      end

      it "sets commit message" do
        expect(payload.message).to eq "Fake commit message"
      end

      it "sets author and committer" do
        expect(payload.author).to eq "Mr Jones"
      end

      it "sets author email" do
        expect(payload.author_email).to eq "john.jones@gmail.com"
      end

      it "sets commit view url" do
        expect(payload.commit_url).to eq "http://sosedoff.beanstalkapp.com/beanstalk-hg1/changesets/1111111111111111111111111111111111111111"
      end

      it "sets compare url" do
        expect(payload.compare_url).to be_nil
      end

      context "when fake" do
        let(:data) { fixture "beanstalk/hg.json" }

        it "sets skip to true" do
          expect(payload.skip).to be_true
        end

        it "sets test to true" do
          expect(payload.test).to be_true
        end
      end
    end
  end
end