module Magnum
  class Payload::Gitlab < Payload::Base
    def parse!
      if deleted?
        @skip = true
        return
      end

      @commit = data.after
      @branch = data.ref.split('/').last

      if data.commits.any?
        @author          = last_commit.author.name
        @author_email    = last_commit.author.email
        @committer       = @author
        @committer_email = @author_email
        @message         = last_commit.message
        @commit_url      = last_commit.url
      end
    end

    def last_commit
      @last_commit ||= Hashr.new(data.commits.last)
    end

    private

    def deleted?
      data.before != '0000000000000000000000000000000000000000' &&
      data.after == '0000000000000000000000000000000000000000'
    end
  end
end