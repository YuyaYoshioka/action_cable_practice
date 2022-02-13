class HomesController < ApplicationController
  def show
    @users = User.all
  end
end
