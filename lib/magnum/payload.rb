require 'magnum/payload/version'

module Magnum
  module Payload
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

    def self.parse(source, payload)
      klass = Magnum::Payload.const_get(source.to_s.capitalize)
      klass.new(payload)
    rescue NameError
      raise PayloadError, "Invalid payload type: #{source}"
    end
  end
end