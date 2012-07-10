class Message
  include Mongoid::Document

  belongs_to :user

  field :body, type: String
end
