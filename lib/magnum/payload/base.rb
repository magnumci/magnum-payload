require "json"
require "hashr"

module Magnum
  module Payload
    class Base
      include Magnum::Payload::MessageParser

      attr_reader :raw_data, :data

      attr_reader :skip,            # Flag to indicate payload skip
                  :test             # Flag to indicate a test payload

      attr_reader :commit,          # Commit SHA or ID
                  :branch,          # Commit branch name (master)
                  :author,          # Commit author name
                  :committer,       # Commit committer name
                  :message,         # Commit message text
                  :committer_email, # Committer email address
                  :author_email,    # Commit author email address
                  :commit_url,      # Url to view commit diff
                  :compare_url      # URL to view multiple commits diff

      def initialize(payload)
        @skip     = false # Do not skip by default
        @test     = false # Do not treat as test payload
        @raw_data = payload
        @data     = parse_payload(payload)

        parse!

        @skip = skip_message? unless @skip
      end

      def attributes_hash
        {
          "commit"      => commit,
          "branch"      => branch,
          "author"      => author,
          "committer"   => committer,
          "message"     => message,
          "commit_url"  => commit_url,
          "compare_url" => compare_url
        }
      end

      def parse!
        raise "Not implemented in base class"
      end

      def skip?
        skip == true
      end

      private

      def parse_payload(payload)
        if payload.kind_of?(String)
          Hashr.new(JSON.parse(payload))
        elsif payload.kind_of?(Hash)
          Hashr.new(payload)
        else
          raise ArgumentError, "String or Hash required"
        end
      rescue JSON::ParserError
        raise Magnum::Payload::ParseError, "Valid JSON required"
      end
    end
  end
end