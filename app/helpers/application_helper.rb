module ApplicationHelper
  class ApiError
    @@count = 0
    attr_reader :message, :id
    def initialize(attributes)
      @id = @@count
      @@count += 1
      @message = attributes[:message]
    end
  end
  class ApiKey
    @@count = 0
    attr_reader :api_key, :id
    def initialize(api_key)
      @id = @@count
      @@count += 1
      @api_key = api_key
    end
  end
end
