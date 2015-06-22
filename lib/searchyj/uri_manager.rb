require 'cgi'

module SearchYJ
  #
  # Manage the URI instance
  #
  # @author [indeep-xyz]
  #
  class UriManager
    URI_BASE = 'http://search.yahoo.co.jp/search'
    QUERY_DEFAULT = {
        # Search term
        p: nil,
        # Character encoding
        ei: 'UTF-8',
        # Suppress that advise to rewrite the search-term
        qrw: 0,
        # Flag for offset (?)
        pstart: 1,
        # Offset
        # - if less than or equal to 1,
        # - the search result is from first
        b: 1
        }

    IndexError      = Class.new(StandardError)
    PageSizeError   = Class.new(StandardError)
    SearchTermError = Class.new(StandardError)

    def initialize(query = {})
      @query = QUERY_DEFAULT.merge(query)
    end

    def search_term
      @query[:p]
    end

    def index
      (@query[:b] < 1) ? 1 : @query[:b]
    end

    def base
      URI_BASE
    end

    def search_term=(search_term)
      fail SearchTermError unless search_term.is_a?(String)

      @query[:p] = search_term
    end

    def index=(index)
      fail IndexError unless index.is_a?(Integer)
      fail IndexError if index < 1

      @query[:b] = index
    end

    def to_s
      uri = URI(URI_BASE)
      uri.query = create_query_string
      uri.to_s
    end

    def move_index(distance)
      @query[:b] += distance
      @query[:b]  = 1 if @query[:b] < 1
    end

    private

    def optimize_query
      query = @query.dup

      query[:b] = query[:b].to_i

      if query[:b].nil? || query[:b] < 2
        query.delete(:b)
        query.delete(:pstart)
      end

      query
    end

    def create_query_string
      query = optimize_query
      stock = []

      query.each do |k, v|
        next if available_value?(v)

        k = k.to_s unless k.is_a?(String)
        v = v.to_s unless v.is_a?(String)
        stock << "#{CGI.escape(k)}=#{CGI.escape(v)}"
      end

      stock.compact * '&'
    end

    def available_value?(v)
      (v.is_a?(Hash) || v.is_a?(Array)) && v.empty?
    end
  end
end
