require 'nokogiri'
require 'open-uri'
require 'searchyj/uri_manager'
require 'searchyj/record_sorter'
require 'searchyj/page_size_adjuster'

module SearchYJ
  #
  # Search from the search engine,
  # parse HTML,
  # dig the atound page
  #
  # @author [indeep-xyz]
  #
  class Searcher
    attr_reader :results
    attr_accessor \
        :pager, :uri, \
        :limit_loop, :user_agent, :sleep_time

    ENCODING   = 'UTF-8'
    USER_AGENT = \
        'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0)' \
        'Gecko/20100101 Firefox/38.0'

    OpenUriError = Class.new(StandardError)

    # Initialize myself.
    # @param encoding [String]
    #   The character encoding that is used to parse HTML
    # @param from [Integer]
    #   Start to search from this number of the search ranking
    # @param sleep_time [Integer]
    #   The time of sleep after fetching from internet
    # @param limit_loop [Integer]
    #   The number of limit that is connectable in one process
    # @param user_agent [String]
    #   Specify the user agent when open uri
    def initialize(
        encoding:   ENCODING,
        from:       1,
        sleep_time: 1,
        limit_loop: 50,
        user_agent: USER_AGENT)
      @pager      = PageSizeAdjuster.new
      @uri        = UriManager.new
      @uri.index  = from
      @encoding   = encoding
      @limit_loop = limit_loop
      @sleep_time = sleep_time
      @user_agent = user_agent
    end

    def run(&block)
      loop_count = 0
      sorter = RecordSorter.new(@uri.index, @pager.size)

      while loop_count < @limit_loop
        fetch_html
        records = extract_records

        sorter.run(records, &block)

        if records.empty? || final_page?
          break
        end

        next_page(records.size + sorter.page_gap)
        sleep @sleep_time
        loop_count += 1
      end
    end

    private

    # Extract and optimize the records
    # from my own HTML instance.
    #
    # @return [Array]
    #   Include Hash, [:uri, title]
    def extract_records
      results = []
      nodes   = @html.css('#WS2m>.w h3 a')

      nodes.each do |node|
        results.push(
            uri:   node.attribute('href').text,
            title: node.text
        )
      end

      results
    end

    # Download raw HTML from YJ and return it.
    #
    # @return [String] raw HTML
    def download_raw_html
      uri    = @uri.to_s
      params = {
          'User-Agent' => @user_agent
      }

      params = @pager.attach_cookie(params)

      open(uri, params) do |f|
        fail OpenUriError unless f.status[0] == '200'
        f.read
      end
    end

    # Download HTML from YJ
    # and set the parsed HTML data to my own instance.
    def fetch_html
      raw_html = download_raw_html
      @html = Nokogiri::HTML.parse(raw_html, nil, @encoding)
    end

    # Check whether or not the next page is exist.
    #
    # @return [bool]
    #   It is true if the navigation element
    #   for the next page is exist.
    #   Else false.
    def final_page?
      a = @html.css('#Sp1 .m a').last

      !(a.is_a?(Nokogiri::XML::Element) &&
        a.text.include?('次へ'))
    end

    # Move to the next page.
    def next_page(page_size)
      @uri.move_index(page_size)
    end
  end
end
