class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
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

  def top_events
    @events = Event.where(user: current_user).select(:description).uniq.limit(10)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
   new_params = {:date => (params[:date] && Date.parse(params[:date])) || Date.today}
   new_params.merge!(:description => params[:description]) if params[:description].present?
   @event = Event.new(new_params)
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params.merge(:user_id => current_user.id))

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search  
    events = Event.search(params[:tags], current_user)
    respond_to do |format|
      format.json { render :json => events }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :description, :date, :time)
    end
end
