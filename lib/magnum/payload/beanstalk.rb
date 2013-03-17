module Magnum
  class Payload::Beanstalk < Payload::Base
    def parse!
      data.revision ? parse_svn! : parse_git!
    end

    def last_commit
      @last_commit ||= Hashr.new(data.commits.last)
    end

    private

    def parse_git!
      @commit       = last_commit.id
      @branch       = data.branch
      @message      = last_commit.message
      @author       = last_commit.author.name
      @author_email = last_commit.author.email
      @commit_url   = last_commit.url
    end

    def parse_svn!
      @commit          = data.revision
      @branch          = 'master'
      @author          = data.author_full_name || data.author
      @author_email    = data.author_email
      @committer       = @author
      @committer_email = @author_email
      @commit_url      = data.changeset_url
      @message         = data.message
    end
  end
end