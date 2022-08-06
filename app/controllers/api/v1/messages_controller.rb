module Api
  module V1
    class MessagesController < ApiController
      before_action :set_message, only: [:show, :update, :destroy]

      # GET /applications
      def index
        query = params["query"] || ""
        @messages = Message.search(query, params[:chat_id])

        render json: @messages
      end

      # POST /messages
      def create
        @message = Message.new(message_params)

        last_message = Message.where(chat_id: params[:chat_id]).last
        sequence_id = last_message ? last_message.message_num + 1 : 1
        @message.write_attribute(:message_num, sequence_id)

        if @message.save
          IncreaseCountOfMessagesJob.perform_async(@message.chat_id)
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /messages/1
      def update
        @message.lock!
        if @message.update(message_params)
          render json: @message
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_message
          @message = Message.find_by(message_num: params[:id], chat_id: params[:chat_id])
        end

        # Only allow a trusted parameter "white list" through.
        def message_params
          params.require(:message).permit(:chat_id, :body)
        end
    end
  end
end


