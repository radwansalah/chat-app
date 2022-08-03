class Message < ApplicationRecord
  self.primary_keys = :id, :chat_id

  belongs_to :chat
end
