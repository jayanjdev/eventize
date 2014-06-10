class HomeController < ApplicationController

  def index
    if current_user
      @events = Event.where(:user_id => current_user.id)
    end
  end
end
