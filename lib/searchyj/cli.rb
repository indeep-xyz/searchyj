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
            'Start to search from this number of the search ranking'

    desc 'detect',
         "Detect a first record that\n" \
         'meet the conditions of a regexp and a key.'
    option :regexp,
           type:     :string,
           required: true,
           aliases:  '-r',
           desc:     'Regexp that want to match with value of a record'
    option :key,
           type:    :string,
           default: 'title',
           aliases: '-k',
           desc: \
               'The key name for comparing values. ' \
               'You can pass any of \'title\' or \'uri\'. '
    def detect(term)
      opt    = symbolized_options
      key    = opt.delete(:key)
      regexp = Regexp.new(opt.delete(:regexp))

      puts JSON.dump(
          SearchYJ.detect(term, regexp, key, opt)
      )
    end

    desc 'list',
         'Get records of the search result.'
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
         "Get a record in the search result\n" \
         'at a particular rank order in the search ranking.'
    option :rank,
           type:     :numeric,
           required: true,
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
