module Magnum
  class Payload::Github < Payload::Base
    def parse!
      if deleted?
        @skip = true
        return
      end

      if forced?
        commit = data.head_commit
      else
        commit = Hashr.new(data.commits.last)
      end

      @commit          = commit.id
      @author          = commit.author.name
      @author_email    = commit.author.email
      @committer       = commit.committer.name
      @committer_email = commit.committer.email
      @message         = commit.message
      @branch          = data.ref.split('/').last
      @commit_url      = commit.url
      @compare_url     = data.compare
    end

    private

    def forced?
      data.forced == true
    end

    def deleted?
      data.deleted == true
    end
  end
end