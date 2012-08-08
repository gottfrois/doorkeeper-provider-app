class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages
end
