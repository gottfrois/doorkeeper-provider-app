class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  belongs_to :conversation

  attr_accessible :body
end
