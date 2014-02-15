module Magnum
  class Payload::Github < Payload::Base
    def parse!
      assign_payload unless skip_payload?
    end

    private

    def assign_payload
      @commit          = last_commit.id
      @author          = last_commit.author.name
      @author_email    = last_commit.author.email
      @committer       = last_commit.committer.name
      @committer_email = last_commit.committer.email
      @message         = last_commit.message
      @branch          = data.ref.gsub("refs/heads/", "")
      @commit_url      = last_commit.url
      @compare_url     = data.compare
    end

    def skip_payload?
      return @skip = true if data.zen
      @skip = true        if head_deleted? || last_commit.nil?
      @skip = true        if data.ref =~ /tags/

      @skip
    end

    # Check if push is forced
    def forced_push?
      data.forced == true
    end

    # Check if push head is deleted
    def head_deleted?
      data.deleted == true
    end

    # Get last commit in the push
    def last_commit
      if forced_push?
        data.head_commit
      else
        Hashr.new(data.commits.last)
      end
    end
  end
end