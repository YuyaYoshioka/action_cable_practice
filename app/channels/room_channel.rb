class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:userIds]}"
  end

  def unsubscribed
  end

  def speak(data)
    user_ids = params[:userIds].split("_")
    message = Message.create!(content: data["message"], first_user_id: user_ids[0], last_user_id: user_ids[1])
    ActionCable.server.broadcast("room_channel_#{params[:userIds]}", { message: render_message(message) })
  end

  private

  def render_message(message)
    ApplicationController.render(
      partial: "messages/message",
      locals: { message: message }
    )
  end
end
