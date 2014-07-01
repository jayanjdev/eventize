class TagsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @event.tags << params[:tag]
    @event.save
  end

  def destroy
  end
end
