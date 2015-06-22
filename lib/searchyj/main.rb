require 'searchyj/searcher'

module SearchYJ
  class Main
    # Get a record in the search result
    # at a particular rank order in the search ranking.
    # @param term [String]  Search term
    # @param rank [Integer] The rank order in the search ranking
    #
    # @return [Hash]
    #   A result record if matched the arguments
    #   Else nil
    def at_rank(term, rank)
      result = list(term, 1, rank)
      (result.size > 0) ? result[0] : nil
    end

    # Detect a first record that
    # meet the conditions of a regexp and a key.
    # @param term   [String] Search term
    # @param regexp [Regexp] Want to match with value of a record[key]
    # @param key    [Symbol] The key name for comparing values
    #
    # @return [Hash]
    #   A result record if matched the arguments
    #   Else nil
    def detect(term, regexp, key = :title)
      key = key.to_sym unless key.is_a?(Symbol)

      searcher = Searcher.new
      searcher.uri.search_term = term

      searcher.run do |record|
        if regexp.match(record[key])
          return record
        end
      end

      nil
    end

    # Get records of the search result.
    # @param term [String]  Search term
    # @param size [Integer] The size of the returner
    # @param from [Integer]
    #   Start to search from this number of the search ranking
    #
    # @return [Array]
    #   Includes the result records
    def list(term, size = 10, start_index = 1)
      searcher = Searcher.new
      searcher.uri.search_term = term
      searcher.uri.index       = start_index
      searcher.page_size       = 10
      list = []

      searcher.run do |record|
        list << record
        break if list.size >= size
      end

      list
    end
  end
end
