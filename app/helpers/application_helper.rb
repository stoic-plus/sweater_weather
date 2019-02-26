module ApplicationHelper
  class ApiMessage
    @@count = 0
    attr_reader :message, :id
    def initialize(attributes)
      @id = @@count
      @@count += 1
      @message = attributes[:message]
    end
  end
  class FavoritesMessage < ApiMessage
    attr_reader :favorite
    def initialize(attributes)
      super(
        id: attributes[:id],
        message: attributes[:message]
      )
      @favorite = attributes[:favorite]
    end
  end
  class ApiError < ApiMessage
    def initialize(attributes)
      super
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
