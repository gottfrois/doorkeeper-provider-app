class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages, autosave: true

  accepts_nested_attributes_for :messages

  attr_accessible :messages_attributes
end
