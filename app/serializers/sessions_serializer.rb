class SessionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key
end
