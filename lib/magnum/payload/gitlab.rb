module Magnum
  class Payload::Gitlab < Payload::Base
    ZERO_SHA = /\A[0]{40}\z/

    def parse!
      assign_payload unless skip_payload?
    end

    def last_commit
      @last_commit ||= Hashr.new(data.commits.last)
    end

    private

    def assign_payload
      @commit = data.after
      @branch = data.ref.gsub("refs/heads/", "")

      if data.commits.any?
        @author          = last_commit.author.name
        @author_email    = last_commit.author.email
        @committer       = @author
        @committer_email = @author_email
        @message         = last_commit.message
        @commit_url      = last_commit.url
      end
    end

    def skip_payload?
      @skip = true if deleted?
      @skip
    end

    def deleted?
      data.before !~ ZERO_SHA && data.after =~ ZERO_SHA
    end
  end
end