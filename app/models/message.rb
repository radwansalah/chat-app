require 'elasticsearch/model'

class Message < ApplicationRecord
  self.primary_keys = :id, :chat_id

  belongs_to :chat

  include MessagesSearchable
end


Message.__elasticsearch__.create_index!
Message.import


