class TagsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])

    if params[:tag].present?
      if @event.add_to_custom_tags(params[:tag])
        flash[:notice] = "Tag saved successfully"
      else
        flash[:errors] = "#{@event.errors.full_messages.join(' ')}" 
      end
    end
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:event_id])
    if params[:tag].present?
      if @event.delete_to_custom_tags(params[:tag])
        flash[:notice] = "Tag deleted successfully"
      else
        flash[:errors] = "#{@event.errors.full_messages.join(' ')}" 
      end
    end
  end
end
