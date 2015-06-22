require 'searchyj'
require 'thor'

module SearchYJ
  class CLI < Thor
    desc 'at_rank',
         "Get a record in the search result\n" \
         'at a particular rank order in the search ranking.'
    option :rank,
           type:     :numeric,
           required: true,
           aliases:  '-r',
           desc:     'The rank order in the search ranking'
    def at_rank(term)
      rank = options[:rank]

      p SearchYJ.at_rank(term, rank)
    end

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
      key    = options[:key]
      regexp = Regexp.new(options[:regexp])

      puts SearchYJ.detect(term, regexp, key)
    end

    desc 'list',
         'Get records of the search result.'
    option :size,
           type:    :numeric,
           default: 10,
           aliases: '-s',
           desc:    'The size of the returner'
    option :from,
           type:    :numeric,
           default: 1,
           aliases: '-f',
           desc: \
               'Start to search from this number of the search ranking'
    def list(term)
      size = options[:size]
      from = options[:from]

      puts SearchYJ.list(term, size, from)
    end
  end
end
