class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # On abonne l'utilisateur à une conversation spécifique
    stream_from "conversation_#{params['conversation_id']}"
  end

  def unsubscribed
    # Action lorsque l'utilisateur quitte
  end
end
