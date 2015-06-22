module SearchYJ
  #
  # Logging unique data
  #
  # @author [indeep-xyz]
  #
  class UniqueLogger
    # Initialize myself.
    # @param limit [Integer] The limit of the log
    def initialize(limit)
      @limit = limit
      reset
    end

    # Add to log.
    # If can not add the value, count up the adding failure.
    # @param value [type] [description]
    #
    # @return [Object]
    #   False if could not add the value.
    def add(value)
      if exist?(value)
        @failure_count += 1
        return false
      end

      @log << value
      @log.shift if @log.length > @limit
    end

    # Return the size of log.
    # @return [Integer] The size of @log
    def length
      @log.length
    end

    # Reset my own log data.
    def reset
      @log = []
      reset_failure_count
    end

    # Return the number of the failure count.
    # @param with_reset [Boolean] If true, reset failure count
    #
    # @return [Integer] The number of failure count
    def failure_count(with_reset = false)
      n = @failure_count
      reset_failure_count if with_reset

      n
    end

    # Reset the failure count.
    def reset_failure_count
      @failure_count = 0
    end

    # Check whether the value is in @log
    # @param value [Object]
    #
    # @return [Boolean]
    #   True if the argument found.
    #   False else.
    def exist?(value)
      @log.include?(value)
    end
  end
end
