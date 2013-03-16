require 'magnum/payload/version'

module Magnum
  module Payload
    autoload :Base,      'magnum/payload/base'
    autoload :Github,    'magnum/payload/github'
    autoload :Gitlab,    'magnum/payload/gitlab'
    autoload :Gitslice,  'magnum/payload/gitslice'
    autoload :Bitbucket, 'magnum/payload/bitbucket'
    autoload :Beanstalk, 'magnum/payload/beanstalk'

    # Shorthand method to initialize a new payload class
    #
    # Examples:
    #
    #     Magnum::Payload.parse(:github, 'data')   # => Magnum::Payload::Github
    #     Magnum::Payload.parse(:gitslice, 'data') # => Magnum::Payload::Gitslice
    #
    def self.parse(source, payload)
      Magnum::Payload.const_get(source.to_s.capitalize).new(payload)
    end
  end
end