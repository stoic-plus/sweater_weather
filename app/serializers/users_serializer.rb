class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key
end
