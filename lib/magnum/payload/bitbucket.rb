module Magnum
  class Payload::Bitbucket < Payload::Base
    def parse!
      commit = Hashr.new(data.commits.last)

      branch = commit.branch || commit.branches.first || 'none'
      revision = commit.revision || commit.raw_node
      author = parse_author(commit.raw_author)

      @commit       = revision
      @author       = author.name
      @author_email = author.email
      @message      = commit.message.strip
      @branch       = branch
      @commit_url   = make_url("commits/#{revision}")

      if data.commits.size > 1
        first_commit = Hashr.new(data.commits.first)
        rev_start = first_commit.revision || first_commit.raw_node
        rev_end = revision

        @compare_url = make_url("compare/#{rev_start}..#{rev_end}")
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
  end
end