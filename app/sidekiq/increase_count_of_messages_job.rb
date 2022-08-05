class IncreaseCountOfMessagesJob
  include Sidekiq::Job

  def perform(chat_id)
    @chat = Chat.find(chat_id)
    @chat.messages_count += 1
    if @chat.save
    else
      raise Exception.new "Can not update the count of messages"
    end
  end
end
