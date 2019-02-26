class ApiMessageSerializer
  include FastJsonapi::ObjectSerializer
  attribute :message
  attribute :favorite, if: Proc.new { |record|
    record.respond_to?(:favorite)
  }
end
