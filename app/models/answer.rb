class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :message, presence: true, length: {minimum: 50}
end
