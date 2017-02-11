module V1
  class TripController < ApplicationController
    before_action :strict_authenticate_request!, only: [:update, :create, :destroy]
    before_action :soft_authenticate_request!, only: [:index, :show, :destroy]

    def index
      user = User.find(params[:user_id])

      if user.present?
        # public_trips = user.trips.where(public: true)
        # private_trips = user.trips.where(public: false)

        if is_a_owner_request?(self)
          trips = user.trips
          #binding.pry
          #render json: {status: 'success',
          #              payload: {public: public_trips + private_trips}}
          days = Day.joins(trip: [:users]).where(users: {id: current_user.id})
          accommodation = Accommodation.joins(:day).where(days: {id: days.group(:id).count.keys})
          entertainments = Entertainment.joins(:day).where(days: {id: days.group(:id).count.keys})

          #render json: [trips, days, [accommodation, entertainments]], options: 'hola'
          render json: trips, include: [:days, :accommodations]


          #render json: trips,
          #        include: ['days.accommodations', 'days.entertainments']
        else
          trips = user.trips.where(public: true)
          #render json: {status: 'success',
          #              payload: {public: public_trips, private: private_trips}}
          render json: public_trips, include: ['days']
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
            render json: {status: 'success', payload: trip.first}
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