class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  validates :name, length: {minimum: 40}
  validates :description, length: {minimum: 150}
end
