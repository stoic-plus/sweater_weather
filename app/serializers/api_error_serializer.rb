class ApiErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message
end
