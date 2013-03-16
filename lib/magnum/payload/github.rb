module Magnum
  class Payload::Github < Payload::Base
    def parse!
      commit = Hashr.new(data.commits.last)

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
  end
end