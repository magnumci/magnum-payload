module Magnum
  class Payload::Beanstalk < Payload::Base
    def parse!
      @commit       = last_commit.id
      @branch       = data.branch
      @message      = last_commit.message
      @author       = last_commit.author.name
      @author_email = last_commit.author.email
      @commit_url   = last_commit.url
    end

    def last_commit
      @last_commit ||= Hashr.new(data.commits.last)
    end
  end
end