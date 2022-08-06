module Api
  module V1
    class ChatsController < ApiController
      before_action :set_chat, only: [:show, :update]

      # GET /applications
      def index
        @applications = Chat.where(application_id: params[:application_id])

        render json: @applications
      end

      # GET /chats/1
      def show
        render json: @chat
      end

      # POST /chats
      def create
        @chat = Chat.new(chat_params)

        last_chat = Chat.where(application_id: params[:application_id]).last
        sequence_id = last_chat ? last_chat.chat_num + 1 : 1
        @chat.write_attribute(:chat_num, sequence_id)

        if @chat.save
          IncreaseCountOfChatsJob.perform_async(@chat.application_id)
          render json: @chat, status: :created
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /chats/1
      def update
        @chat.lock!
        if @chat.update(chat_params)
          render json: @chat
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_chat
          @chat = Chat.find_by(chat_num: params[:id], application_id: params[:application_id])
        end

        # Only allow a trusted parameter "white list" through.
        def chat_params
          params.require(:chat).permit(:application_id)
        end
    end
  end
end

