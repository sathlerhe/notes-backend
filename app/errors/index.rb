# frozen_string_literal: true

module Error
  class BaseError
    attr_accessor :message, :status

    def initialize(message = 'Internal server error', status = 500)
      @message = message
      @status = status
    end

    def call
      {
        error: @message,
        status: @status
      }
    end
  end

  class NotFound < BaseError
    def initialize(message = 'Not Found')
      super(message, 404)
    end
  end

  class BadRequest < BaseError
    def initialize(message = 'One or more arguments are invalid')
      super(message, 400)
    end
  end
end
