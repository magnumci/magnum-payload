# Magnum Payload

Commit payload processor and formatter library for Magnum CI

## Usage

Example:

```ruby
require 'magnum/payload'

# Shorthand method to parse payload
Magnum::Payload.parse('github', 'JSON data') # => Magnum::Payload::Github

# Or directly initialize a class
Magnum::Payload::Github.new('JSON data')
```

Available payload classes:

- Magnum::Payload::Github
- Magnum::Payload::Gitslice
- Magnum::Payload::Gitlab
- Magnum::Payload::Beanstalk
- Magnum::Payload::Bitbucket
- Magnum::Payload::Custom