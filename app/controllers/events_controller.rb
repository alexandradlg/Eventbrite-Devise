class EventsController < ApplicationController
    def new
        @event = Event.new
    end
    
    def create
      @event = Event.new(event_params)
      @event.creator_id = current_user.id
      if @event.save
        redirect_to event_path(@event)
        flash[:success] = "Your event is created"
      else flash[:danger] = "Your event is not create, please try again"
        render 'new'
      end

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
      if @event.update(event_params)
        redirect_to event_path(@event)
      else redirect_to event_path(@event)
        flash[:error] = "YOUR EVENT IS NOT UPDATED. Please try again and make sure to update all the field."
      end
    end
  
    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to user_path(current_user)
    end
  
    def subscribe
      @event = Event.find(params[:event_id])

      @amount = @event.price_cents
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'eur'
      )

      @event.attendees << current_user
      redirect_to @event
      flash[:success] = "You are now attending this event"
    
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to @event
    end
  
    def unsubscribe
      @event = Event.find(params[:event_id])
      @event.attendees.delete(current_user)
      redirect_to user_path(current_user)
      flash[:danger] = "You are no longer attending this event"

    end
  
      private
    def event_params
      params.require(:event).permit(:description, :date, :place, :price)
    end

end
