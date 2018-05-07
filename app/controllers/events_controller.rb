class EventsController < ApplicationController
    def new
        @event = Event.new
      end
    
      def create
        @event = Event.new(event_params)
        @event.creator_id = current_user.id
        @event.save
        redirect_to events_path
      end
    
      def show
        @event = Event.find(params[:id])
      end
      
      def index
        @events = Event.all
      end
    
      def edit
        @event = Event.find(params[:id])
      end    
      
      def update
        @event = Event.find(params[:id])
        @event.update(event_params)
        redirect_to event_path(@event)
      end
    
      def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to user_path(current_user)
      end
    
      def subscribe
        @event = Event.find(params[:event_id])
        @event.attendees << current_user
        redirect_to user_path(current_user)
      end
    
      def unsubscribe
        @event = Event.find(params[:event_id])
        @event.attendees.delete(current_user)
        redirect_to user_path(current_user)
      end
    
      # def invite
      #   @users = User.all
      #   @event = Event.find(params[:event_id])
      # end
    
      # def subscribe_friends
      #   @event = Event.find(params[:event_id])
      #   @event.attendees << User.find(params[:id])
      #   redirect_to events_path
      # end
    
        private
      def event_params
        params.require(:event).permit(:description, :date, :place, :price)
      end
end
