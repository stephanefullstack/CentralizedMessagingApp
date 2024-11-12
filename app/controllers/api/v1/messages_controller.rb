module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_conversation

      # GET /api/v1/conversations/:conversation_id/messages
      def index
        @messages = @conversation.messages
        render json: @messages
      end

      # POST /api/v1/conversations/:conversation_id/messages
      def create
        @message = @conversation.messages.new(message_params)

        if @message.save
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      private

      def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
      end

      def message_params
        params.require(:message).permit(:content, :user_id) # Autoriser user_id
      end
    end
  end
end
