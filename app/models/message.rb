class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_to_conversation

  private

  def broadcast_to_conversation
    Rails.logger.info("Broadcasting message to conversation: #{conversation_id}")
    ActionCable.server.broadcast("conversation_#{conversation_id}", {
      message: { content: content, user_id: user.id }
    })
    puts "Message diffusé à conversation_#{conversation_id}"
  end

end
