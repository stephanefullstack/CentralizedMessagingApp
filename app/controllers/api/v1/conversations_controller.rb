module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_conversation, only: [:show, :update, :destroy]

      # GET /api/v1/conversations
      def index
        @conversations = Conversation.includes(:messages).all
        render json: @conversations.to_json(include: :messages)
      end

      # GET /api/v1/conversations/:id
      def show
        render json: @conversation
      end

      # POST /api/v1/conversations
      def create
        @conversation = Conversation.new(conversation_params)
        @conversation.user = current_user # Assurez-vous que current_user est configuré

        if @conversation.save
          ActionCable.server.broadcast('conversation_channel', @conversation)
          render json: @conversation, status: :created
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/conversations/:id
      def update
        if @conversation.update(conversation_params)
          render json: @conversation
        else
          render json: { errors: @conversation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/conversations/:id
      def destroy
        @conversation.destroy
        head :no_content
      end

      private

      def set_conversation
        @conversation = Conversation.find(params[:id])
      end

      def conversation_params
        params.require(:conversation).permit(:title)
      end

      def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        @current_user = User.find(decoded_token['user_id'])
      rescue
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
