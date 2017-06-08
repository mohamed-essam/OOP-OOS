class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :user_name, length: {minimum: 6, maximum: 32}, uniqueness: true
  validates :first_name, length: {minimum: 2, maximum: 32}
  validates :last_name, length: {minimum: 2, maximum: 32}
  validates :phone, presence: true
  validates_email_format_of :email, :message => 'is invalid'
  has_secure_password
end
