
module SearchYJ
  #
  # Manage cookie for page
  #
  # @author [indeep-xyz]
  #
  class PageSizeAdjuster
    attr_reader :size

    SIZE_PATTERN = [10, 15, 20, 30, 40, 100]
    SIZE_DEFAULT = SIZE_PATTERN[0]
    COOKIE_BASE  = \
        'sB="n=<<n>>&nw=-1&fp_ipod=0&fp_pl=0"; ' \
        'path=/; ' \
        'expire=<<expire>>'
    EXPIRE_DELAY = 60 * 60 * 24

    # Initialize myself.
    def initialize
      @size   = SIZE_DEFAULT
      @expire = Time.now.to_i + EXPIRE_DELAY
    end

    def size=(size)
      @size = optimize_page_size(size)
    end

    # Optimize the number of the page size for searching.
    # @param size [Number] The number of the page size
    #
    # @return [Number] The optimized number
    def optimize_page_size(size)
      SIZE_PATTERN.reverse_each do |n|
        return n if size >= n
      end

      SIZE_DEFAULT
    end

    # Attach the cookie string to the argument
    # if @size has differed from the default value.
    # @param hash [Hash]
    #
    # @return [Hash]
    def attach_cookie(hash)
      if @size > SIZE_DEFAULT
        hash['Cookie'] = create_cookie
      end

      hash
    end

    private

    # Create the cookie string to adjust the page size.
    #
    # @return [String] The cookie string
    def create_cookie
      COOKIE_BASE.gsub(
          /<<[^>]+>>/,
          '<<n>>' => @size.to_s,
          '<<expire>>' => @expire.to_s
      )
    end
  end
end
