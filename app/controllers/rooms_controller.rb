class RoomsController < ApplicationController
  def show
    talked_to_user = User.find_by(name: params[:name]) || User.find_by(id: cookies[:talked_to_user_id])
    cookies[:talked_to_user_id] = talked_to_user.id
    login_user_id = cookies[:login_user_id].to_i
    talked_to_user_id = talked_to_user.id.to_i
    if login_user_id > talked_to_user_id
      first_user_id = talked_to_user_id
      last_user_id = login_user_id
    else
      first_user_id = login_user_id
      last_user_id = talked_to_user_id
    end
    @login_user = User.find_by(id: cookies[:login_user_id])
    @talked_user = User.find_by(id: cookies[:talked_to_user_id])
    @messages = Message.where(first_user_id: first_user_id, last_user_id: last_user_id)
  end
end
