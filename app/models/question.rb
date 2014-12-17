class Question < ActiveRecord::Base
  has_many :answers
  has_many :users
  validates :name, length: {minimum: 40}
  validates :description, length: {minimum: 150}
end
