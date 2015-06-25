require "searchyj/version"
require "searchyj/main"
require "searchyj/cli"

module SearchYJ
  module_function

  def list(term, size = 10, **args)
    mgr = SearchYJ::Main.new
    mgr.list(term, size, args)
  end

  def rank(term, rank, **args)
    mgr = SearchYJ::Main.new
    mgr.rank(term, rank, args)
  end

  def detect(term, regexp, key = :title, **args)
    mgr = SearchYJ::Main.new
    mgr.detect(term, regexp, key, args)
  end
end
