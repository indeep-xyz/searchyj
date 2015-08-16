require 'searchyj'
require 'thor'
require 'json'

module SearchYJ
  class CLI < Thor
    class_option \
        :from,
        type:    :numeric,
        default: 1,
        aliases: '-f',
        desc: \
            'The searching process starts ' \
            'from this number of the search ranking.'

    desc 'detect',
         "Get the record matched first with the option value."
    option :regexp,
           type:     :string,
           required: true,
           aliases:  '-r',
           desc:     'Regexp to extract from the search result.'
    option :key,
           type:    :string,
           default: 'title',
           aliases: '-k',
           desc: \
               "The key name of the matching target\n" \
               "This option receives any of 'title' or 'uri'."
    def detect(term)
      opt    = symbolized_options
      key    = opt.delete(:key)
      regexp = Regexp.new(opt.delete(:regexp))

      puts JSON.dump(
          SearchYJ.detect(term, regexp, key, opt)
      )
    end

    desc 'list',
         'Print the search result.'
    option :size,
           type:    :numeric,
           default: 10,
           aliases: '-s',
           desc:    'The size of the returner'
    def list(term)
      opt  = symbolized_options
      size = opt.delete(:size)

      puts JSON.dump(
          SearchYJ.list(term, size, opt)
      )
    end

    desc 'rank',
         "Print a particular record extracted " \
         "from the search result by the number of rank order."
    option :rank,
           type:     :numeric,
           default:  1,
           aliases:  '-r',
           desc:     'The rank order in the search ranking'
    def rank(term)
      opt  = symbolized_options
      rank = opt.delete(:rank)

      puts JSON.dump(
          SearchYJ.rank(term, rank, opt)
      )
    end

    private

    def symbolized_options
      options.map do |key, value|
        [key.to_sym, value]
      end.to_h
    end
  end
end
