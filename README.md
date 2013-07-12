# magnum-payload

Ruby library to parse and process JSON-formatted payloads from code hosting providers. 
It accepts any commits payloads and transforms them into identical data structures. 

If you need to integrate web-hooks from Github, Bitbucket or Gitlab this is definitely
worth checking out. Check examples for details.

## Supported platforms

You can integrate with the following providers:

- [Github](https://github.com) (*git*)
- [Bitbucket](https://bitbucket.org) (*git, mercurial*)
- [Gitlab](http://gitlab.org/) (*git*)
- [Beanstalkapp](http://beanstalkapp.com/) (*git, mercurial, subversion*)
- Your own server (*git*)

## Installation

Add dependency to Gemfile:

```
gem 'magnum-payload', 
  github: 'magnumci/magnum-payload', 
  require: 'magnum/payload'
```

NOTE: Library is not distributed via Rubygems.

## Usage

Example:

```ruby
require 'magnum/payload'

# Shorthand method to parse payload
Magnum::Payload.parse('github', 'JSON data')    # => Magnum::Payload::Github
Magnum::Payload.parse('bitbucket', 'JSON data') # => Magnum::Payload::Bitbucket
Magnum::Payload.parse('gitlab', 'JSON data')    # => Magnum::Payload::Bitbucket

# Or directly initialize a class
payload = Magnum::Payload::Github.new('JSON data')

# Detect skip
payload.skip?
payload.skip_message?
```

See `Payload Attributes` section for payload instance details.

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

Copyright (c) 2013 Magnum CI, Dan Sosedoff <dan.sosedoff@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE