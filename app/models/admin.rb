class Admin < ActiveRecord::Base
  validates :user_name, length: {minimum: 6, maximum: 32}, uniqueness: true
  validates :auth_key, length: {minimum: 6}
end
