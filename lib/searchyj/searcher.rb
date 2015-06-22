require 'nokogiri'
require 'open-uri'
require 'searchyj/uri_manager'
require 'searchyj/record_sorter'

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
    attr_accessor :limit_loop, :user_agent, :sleep_time, :page_size, :uri
    USER_AGENT = \
        'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0)' \
        'Gecko/20100101 Firefox/38.0'

    OpenUriError = Class.new(StandardError)

    # Initialize myself.
    def initialize
      @uri        = UriManager.new
      @limit_loop = 10
      @user_agent = USER_AGENT
      @sleep_time = 1
      @page_size  = 10
    end

    def run(&block)
      loop_count = 0
      sorter = RecordSorter.new(@uri.index, @page_size)

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

      open(uri, params) do |f|
        fail OpenUriError unless f.status[0] == '200'
        f.read
      end
    end

    # Download HTML from YJ
    # and set the parsed HTML data to my own instance.
    def fetch_html
      raw_html = download_raw_html
      @html = Nokogiri::HTML.parse(raw_html, nil, 'UTF-8')
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
