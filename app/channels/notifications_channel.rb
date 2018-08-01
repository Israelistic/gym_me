class NotificationsChannel < ApplicationCable::Channel
# subscribed and unsubscribed are hooks that run when
# someone starts or stops listening to a socket.
  def subscribed
    stream_from("notifications_#{current_user.id}_channel")
  end

  def unsubscribed
  end
# send_message is the method we are calling from the client side.
# That method checks whether a conversation exists
# and a user has rights to access it.
  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])
    if conversation && conversation.participates?(current_user)
      personal_message = current_user.personal_messages.build({body: data['message']})
      personal_message.conversation = conversation
      personal_message.save!
    end
  end
end
