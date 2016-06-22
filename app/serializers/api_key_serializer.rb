class ApiKeySerializer < ActiveModel::Serializer
  attributes :id, :access_token, :expires_at, :user_id, :active, :application
end
