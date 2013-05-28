# Magnum Payload

Commit payload parser and processor library for Magnum CI.

## Overview

This library handles parsing and processing for JSON-formatted payloads from 
multiple code hosting providers. It is designed to parse an incoming data into
a single structure that is identical for all providers.

## Supported platforms

Following code hosting platforms are supported:

- Github (git)
- Gitslice (git)
- Gitlab (git)
- Bitbucket (git, mercurial)
- Beanstalkapp (git, mercurial, subversion)
- Third-party (git)

## Installation

Add dependency to Gemfile:

```
gem 'magnum-payload', 
  github: 'magnumci/magnum-payload', 
  require: 'magnum/payload'
```

Or install with rubygems:

```
gem install magnum-payload
```

## Usage

Example:

```ruby
require 'magnum/payload'

# Shorthand method to parse payload
payload = Magnum::Payload.parse('github', 'JSON data') # => Magnum::Payload::Github

# Or directly initialize a class
payload = Magnum::Payload::Github.new('JSON data')

# Detect skip
payload.skip?
payload.skip_message?
```

## Payload Classes

All payload classes are inherited from `Magnum::Payload::Base`:

- Magnum::Payload::Github
- Magnum::Payload::Gitslice
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