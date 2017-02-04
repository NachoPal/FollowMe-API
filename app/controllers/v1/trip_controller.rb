module V1
  class TripController < ApplicationController
    before_action :authenticate_request!, only: [:update, :create, :destroy]

    def index
      user = User.find(params[:user_id])
      public_trips = user.trips.where(public: true)
      private_trips = user.trips.where(public: false)

      if public_trips.present? || private_trips.present?
        if is_a_owner_request?
          render json: {status: 'success',
                        payload: {public: public_trips + private_trips}}
        else
          render json: {status: 'success',
                        payload: {public: public_trips, private: private_trips}}
        end
      end
    end

    def show
      user = User.find(params[:user_id])
      trip = user.trips.where(id: params[:trip_id])

      trip = trip.where(public: true) unless is_a_owner_request?

      if trip.present?
        render json: {status: 'success', payload: trip}
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def create
      trip = Trip.new(trip_params)

      if trip.valid?
        trip.save!
        current_user.trips << trip

        render json: {status: 'success', payload: trip}, status: 201
      else
        render json: {status: 'error', reason: trip.errors}
      end
    end

    def update
      trip = current_user.trips.where(id: params[:id])

      if trip.present?
        trip.update_all(trip_params)
        render json: {status: 'success', payload: trip}
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def destroy
      trip = current_user.trips.where(id: params[:id])

      if trip.present?
        trip.destroy!
        render json: {status: 'success'}
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    private

    def trip_params
      params.permit(:name, :description, :id => [])
    end
  end
end