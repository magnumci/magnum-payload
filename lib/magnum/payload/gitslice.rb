module Magnum
  class Payload::Gitslice < Payload::Base
    def parse!
      assign_payload
    end

    private

    def assign_payload
      @commit          = data.commit
      @author          = data.author
      @author_email    = data.author_email
      @committer       = data.committer
      @committer_email = data.committer_email
      @message         = data.message
      @branch          = data.branch
      @commit_url      = data.commit_url
      @compare_url     = data.compare_url
    end
  end
end