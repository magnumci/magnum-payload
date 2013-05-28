module Magnum
  class Payload::Custom < Payload::Base
    def parse!
      assign_payload
    end

    private

    def assign_payload
      @commit          = data.commit
      @author          = data.author
      @committer       = data.committer
      @message         = data.message
      @branch          = data.branch
      @commit_url      = data.commit_url
      @compare_url     = data.compare_url
    end
  end
end