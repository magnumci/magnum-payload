# magnum-payload

Ruby library to parse and process JSON-formatted payloads from code hosting providers. 
It accepts any commits payloads and transforms them into identical data structures. 

If you need to integrate web-hooks from Github, Bitbucket or Gitlab this is definitely
worth checking out. Check examples for details.

[![Build Status](https://magnum-ci.com/status/1f87bb33961c21de5940142e86a741f1.png)](https://magnum-ci.com/public/0cb3a398347ebeeb90fb/builds) 
[![Code Climate](https://codeclimate.com/github/magnumci/magnum-payload.png)](https://codeclimate.com/github/magnumci/magnum-payload)

## Supported platforms

You can integrate with the following providers:

- [Github](https://github.com) - git
- [Bitbucket](https://bitbucket.org) - git, mercurial
- [Gitlab](http://gitlab.org/) - git
- [Beanstalkapp](http://beanstalkapp.com/) - git, mercurial, subversion
- Your own server - git

## Installation

Install via rubygems:

```
gem install magnum-payload
```

Or with bundler:

```
gem 'magnum-payload', require: 'magnum/payload'
```

## Usage

Example:

```ruby
require 'magnum/payload'

# Shorthand method to parse payload
Magnum::Payload.parse('github', 'JSON')    # => Magnum::Payload::Github
Magnum::Payload.parse('bitbucket', 'JSON') # => Magnum::Payload::Bitbucket
Magnum::Payload.parse('gitlab', 'JSON')    # => Magnum::Payload::Gitlab

# Or directly initialize a class
payload = Magnum::Payload::Github.new('JSON data')

# Detect skip
payload.skip?
payload.skip_message?
```

See `Payload Attributes` section for payload instance details.

Check `examples` directory for code samples.

## Payload Classes

All payload classes are inherited from `Magnum::Payload::Base`:

- Magnum::Payload::Github
- Magnum::Payload::Gitlab
- Magnum::Payload::Beanstalk
- Magnum::Payload::Bitbucket
- Magnum::Payload::Custom

## Payload Attributes

Attributes are depending on payload class.

- `raw_data`        - Original payload string or hash
- `data`            - Formatted hash instance
- `skip`            - Skip flag that indicated full payload skip (deleted head, etc)
- `commit`          - Code revision (SHA1, number)
- `branch`          - Code branch name (git, hg, svn)
- `author`          - Commit author name
- `committer`       - Commit committer name (git)
- `message`         - Commit message text
- `committer_email` - Committer email (git)
- `author_email`    - Author email (git)
- `commit_url`      - Direct URL to view commit diff
- `compare_url`     - Direct URL to view commits diff

## Test Suite

To execute test suite run:

```
rake test
```

## License

The MIT License (MIT)

Copyright (c) 2013-2014 Magnum CI