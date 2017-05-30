class User < ActiveRecord::Base
  has_many :orders
  has_many :reviews
  validates :first_name, length: {minimum: 2, maximum: 32}
  validates :last_name, length: {minimum: 2, maximum: 32}
  validates :email, format: {with: /(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})/i}, uniqueness: true
  validates :phone, presence: true
  validates :user_name, length: {minimum: 6, maximum: 32}, uniqueness: true
  has_secure_password
end
