class IncreaseCountOfChatsJob
  include Sidekiq::Job

  def perform(application_id)
    @application = Application.find(application_id)
    @application.chats_count += 1
    if @application.save
    else
      raise Exception.new "Can not update the count of chats"
    end
  end
end
