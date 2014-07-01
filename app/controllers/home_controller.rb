class HomeController < ApplicationController

  def index
    if current_user
      @day = (params[:date] && Date.parse(params[:date])) || Date.today
      @events_by_date = Event.where(:user_id => current_user.id).where( "date >= ?", @day.beginning_of_month).where( "date <= ?", @day.end_of_month).inject({}) { |h, e|
        if h[e.date.day] 
          h[e.date.day] << e
        else
          h[e.date.day] = [e]
        end
        h
      }
    end
  end
end
