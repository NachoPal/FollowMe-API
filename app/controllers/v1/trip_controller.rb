module V1
  class TripController < ApplicationController
    before_action :strict_authenticate_request!, only: [:update, :create, :destroy]
    before_action :soft_authenticate_request!, only: [:index, :show, :destroy]

    def index
      user = User.find(params[:user_id])

      if user.present?
        if is_a_owner_request?(self)
          trips = user.trips

          render json: trips, include: TRIP_ASSOCIATIONS
        else
          trips = user.trips.where(public: true)

          render json: trips, include: TRIP_ASSOCIATIONS
        end
      else
        render json: {status: 'error', reason: {user: 'does not exist'}}
      end
    end

    def show
      user = User.find(params[:user_id])

      if user.present?
        trip = user.trips.where(id: params[:trip_id])

        if trip.present?
          if is_a_owner_request?(self) || trip.first.public
            render json: trip, include: TRIP_ASSOCIATIONS
          else
            render json: {status: 'error', reason: {trip: 'is not public'}}
          end
        else
          render json: {status: 'error', reason: {trip: 'does not exist'}}
        end
      else
        render json: {status: 'error', reason: {user: 'does not exist'}}
      end
    end

    def create
      trip = Trip.new(trip_params)

      if trip.save!
        current_user.trips << trip
        trip = Trip.where(id: trip.id)
        render json: trip, status: 201
      else
        render json: {status: 'error', reason: trip.errors}
      end
    end

    def update
      trips = current_user.trips.where(id: params[:ids].map{ |id| id.to_i})

      if trips.present?
        trip = Trip.new(trip_params)

        if trip.valid?
          trips.update_all(trip_params.to_h)
        else
          render json: {status: 'error', reason: trip.errors}
        end

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