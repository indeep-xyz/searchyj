require "searchyj/version"
require "searchyj/main"
require "searchyj/cli"

module SearchYJ
  module_function

  def list(term, size = 10, start_index = 1)
    mgr = SearchYJ::Main.new
    mgr.list(term, size, start_index)
  end

  def at_rank(term, rank)
    mgr = SearchYJ::Main.new
    mgr.at_rank(term, rank)
  end

  def detect(term, regexp, key = :title)
    mgr = SearchYJ::Main.new
    mgr.detect(term, regexp, key)
  end
end
