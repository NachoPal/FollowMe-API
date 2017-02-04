module V1
  class TripController < ApplicationController
    before_action :strict_authenticate_request!, only: [:update, :create, :destroy]
    before_action :soft_authenticate_request!, only: [:index, :show, :destroy]

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
        render json: {status: 'success', payload: trip.first}
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
      trips = current_user.trips.where(id: params[:ids].map{ |id| id.to_i})

      if trips.present?
        trips.update_all(trip_params.to_h)

        if trips.count == 1
          redirect_to v1_user_trip_show_url(user_id: current_user.id, trip_id: trips.first.id)
        else
          redirect_to v1_user_trip_index_url(user_id: current_user.id)
        end
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def destroy
      trips = current_user.trips.where(id: params[:ids].map{ |id| id.to_i})

      if trips.present?
        trips.destroy_all
        redirect_to v1_user_trip_index_url(user_id: current_user.id)
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    private

    def trip_params
      params.permit(:name, :description, :public)
    end
  end
end