require 'searchyj/unique_logger'

module SearchYJ
  #
  # Sort the process for each records
  #
  # @author [indeep-xyz]
  #
  class RecordSorter
    attr_accessor :rank

    # Initialize myself
    # @param rank [Integer]
    #   The starting number of the rank of the records
    # @param logger_size [Integer]
    #   The logging size of UniqueLogger
    #
    # @return [type] [description]
    def initialize(rank, logger_size)
      @rank = rank
      initialize_logger(logger_size)
    end

    # Initialize the instance of UniqueLogger
    # @param size [Integer] The logging size of UniqueLogger
    #
    # @return [type] [description]
    def initialize_logger(size)
      @logger = UniqueLogger.new(size)
    end

    # Return the number of page gap in the searching.
    # And reset logger's count.
    #
    # @return [Integer]
    def page_gap
      @logger.failure_count(true)
    end

    def run(records, &block)
      records.each do |record|
        next if @logger.add(record[:uri]) == false

        record[:rank] = @rank
        block.call(record)
        @rank += 1
      end
    end
  end
end
