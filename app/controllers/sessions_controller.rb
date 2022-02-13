class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user
      cookies[:login_user_id] = user.id
      redirect_to homes_show_url
    end
  end
end
