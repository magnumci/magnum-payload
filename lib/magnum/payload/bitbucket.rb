module Magnum
  class Payload::Bitbucket < Payload::Base
    def parse!
      if data.push && data.push.changes
        return parse_new_payload
      end

      if data.commits.nil? || data.commits.empty?
        raise Magnum::Payload::PayloadError, "Payload has no commits"
      end

      commit = Hashr.new(data.commits.last)

      branch   = commit.branch || commit.branches.first || 'none'
      revision = commit.revision || commit.raw_node
      author   = parse_author(commit.raw_author)

      @commit       = revision
      @author       = author.name
      @author_email = author.email
      @message      = commit.message.strip
      @branch       = branch
      @commit_url   = make_url("commits/#{revision}")

      if data.commits.size > 1
        parse_compare_url(revision)
      end
    end

    def make_url(path=nil)
      [site_url, repo_url, path].compact.join
    end

    def site_url
      data.canon_url
    end

    def repo_url
      data.repository.absolute_url
    end

    def parse_author(str)
      case str
      when /<.+>/
        m, name, email = *str.match(/(.*) <(.+?)>/)
        Hashr.new(:name => name, :email => email)
      else
        Hashr.new(:name => str)
      end
    end

    private

    def parse_compare_url(revision)
      first_commit = Hashr.new(data.commits.first)
      rev_start    = first_commit.revision || first_commit.raw_node
      rev_end      = revision
      @compare_url = make_url("compare/#{rev_start}..#{rev_end}")
    end

    def parse_new_payload
      changes = Hashr.new(data.push.changes[0])
      commit  = changes[:new]
      author  = parse_author(commit.target.author.raw)

      @branch       = commit.name
      @commit       = commit.target[:hash]
      @message      = commit.target[:message].to_s.strip
      @author       = author.name
      @author_email = author.email
      @commit_url   = commit.target.links.html.href

      if changes.links.html
        @compare_url = changes.links.html.href
      end
    end
  end
end