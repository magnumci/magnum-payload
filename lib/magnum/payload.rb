require 'magnum/payload/version'

module Magnum
  module Payload
    autoload :Base,      'magnum/payload/base'
    autoload :Github,    'magnum/payload/github'
    autoload :Gitlab,    'magnum/payload/gitlab'
    autoload :Gitslice,  'magnum/payload/gitslice'
    autoload :Bitbucket, 'magnum/payload/bitbucket'
    autoload :Beanstalk, 'magnum/payload/beanstalk'
  end
end