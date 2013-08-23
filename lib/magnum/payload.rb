require 'magnum/payload/version'

module Magnum
  module Payload
    SOURCES = %w(custom github gitlab gitslice bitbucket beanstalk)

    class ParseError   < StandardError ; end
    class PayloadError < StandardError ; end

    autoload :Base,          'magnum/payload/base'
    autoload :Custom,        'magnum/payload/custom'
    autoload :Github,        'magnum/payload/github'
    autoload :Gitlab,        'magnum/payload/gitlab'
    autoload :Gitslice,      'magnum/payload/gitslice'
    autoload :Bitbucket,     'magnum/payload/bitbucket'
    autoload :Beanstalk,     'magnum/payload/beanstalk'
    autoload :MessageParser, 'magnum/payload/message_parser'

    def self.valid_source?(source)
      SOURCES.include?(source.to_s)
    end

    def self.parse(source, payload)
      unless valid_source?(source)
        raise PayloadError, "Invalid payload type: #{source}"
      end

      klass = Magnum::Payload.const_get(source.to_s.capitalize)
      klass.new(payload)
    end
  end
end