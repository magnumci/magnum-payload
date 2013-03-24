module Magnum
  class Payload::Gitlab < Payload::Base
    def parse!
      @commit          = data.after
      @branch          = data.ref.split('/').last
      @author          = last_commit.author.name
      @author_email    = last_commit.author.email
      @committer       = @author
      @committer_email = @author_email
      @message         = last_commit.message
      @commit_url      = last_commit.url
    end

    def last_commit
      @last_commit ||= Hashr.new(data.commits.last)
    end
  end
end