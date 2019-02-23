module ApplicationHelper
  class ApiError
    @@count = 0
    attr_reader :message, :id
    def initialize(message)
      @id = @@count
      @@count += 1
      @message = message
    end
  end
end
