require 'multi_json'
require 'hashr'

module Magnum
  module Payload
    class Base
      include Magnum::Payload::MessageParser

      attr_reader :raw_data, :data
      attr_reader :skip, :test

      attr_reader :commit, :branch, :author, :committer, :message
      attr_reader :committer_email, :author_email
      attr_reader :commit_url, :compare_url

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
          'commit'      => commit,
          'branch'      => branch,
          'author'      => author,
          'committer'   => committer,
          'message'     => message,
          'commit_url'  => commit_url,
          'compare_url' => compare_url
        }
      end

      def parse!
        raise "Not Implemented"
      end

      def skip?
        skip == true
      end

      private

      def parse_payload(payload)
        if payload.kind_of?(String)
          Hashr.new(MultiJson.decode(payload))
        elsif payload.kind_of?(Hash)
          Hashr.new(payload)
        else
          raise ArgumentError, "String or Hash required"
        end
      end
    end
  end
end