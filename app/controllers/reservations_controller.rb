class ReservationsController < ApplicationController
    before_action :authenticate_user!

    def new
        @reservation = Reservation.new
    end

    def create
        @room = Room.find(params[:room_id])

        @reservation = current_user.reservations.new(reservation_params)
        @reservation.room = @room
        @reservation.price = @room.price

        if @reservation.save
            redirect_to confirm_reservation_path(@reservation.id)
        else
            render "rooms/show", status: :unprocessable_entity
        end
    end

    def your_trips
        @trips = current_user.reservations.order(start_date: :asc)
    end

    def your_reservations
        @rooms = current_user.rooms
        @trips = current_user.reservations.order(start_date: :asc)
    end

    def confirm
        @reservation = Reservation.find(params[:id])
        @reservation.total_price
        @reservation.save
        end

    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.save
            if @reservation.update(reservation_params)
            end
            flash[:notice]= "保存しました。"
            redirect_to root_path
        else
            render :confirm
        end
    end

    private

    def reservation_params
        params.require(:reservation).permit(:start_date, :end_date, :number_of_guests)
    end

end