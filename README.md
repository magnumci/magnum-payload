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

Payload attributes:

- raw_data - Original payload string or hash
- data - Formatted Hashr instance
- skip - Skip flag that indicated full payload skip (deleted head, etc)
- commit - Code revision (SHA1, number)
- branch - Code branch name (git, hg, svn)
- author - Commit author name
- committer - Commit committer name (git)
- message - Commit message text
- committer_email - Committer email (git)
- author_email - Author email (git)
- commit_url - Direct URL to view commit diff
- compare_url - Direct ULR to view commits diff