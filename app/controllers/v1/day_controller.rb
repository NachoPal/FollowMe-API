module V1
  class DayController < ApplicationController
    before_action :strict_authenticate_request!, only: [:update, :create, :destroy]
    before_action :soft_authenticate_request!, only: [:index, :show, :destroy]

    def index
      trip = Trip.find(params[:trip_id])

      if trip.present?
        if is_a_owner_request?(self) || trip.public
          days = trip.days
          render json: days, include: DAYS_ASSOCIATIONS
        else
          render json: {status: 'error', reason: {trip: 'is not public'}}
        end
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def show
      trip = Trip.find(params[:trip_id])

      if trip.present?
        if is_a_owner_request?(self) || trip.public
          day = trip.days.where(id: params[:day_id])

          if day.present?
            render json: {status: 'success', payload: day}
          else
            render json: {status: 'error', reason: {day: 'does not exist'}}
          end
        else
          render json: {status: 'error', reason: {trip: 'is not public'}}
        end
      end
    end

    def create
      trip = current_user.trips.where(id: params[:trip_id])

      if trip.present?
        day = Day.new(day_params)

        if day.valid?
          trip.first.days << day
          render json: {status: 'success', payload: day}, status: 201
        else
          render json: {status: 'error', reason: day.errors}
        end
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def update
      trip = current_user.trips.where(id: params[:trip_id])

      if trip.present?
        days = trip.first.where(id: params[:ids].map{ |id| id.to_i})

        if days.present?
          day = Day.new(days_params)

          if day.valid?
            days.update_all(day_params.to_h)

            if days.count == 1
              redirect_to v1_trip_day_show_url(trip_id: trip.first.id, day_id: days.first.id)
            else
              redirect_to v1_trip_day_index_url(trip_id: trip.first.id)
            end
          else
            render json: {status: 'error', reason: day.errors}
          end
        else
          render json: {status: 'error', reason: {days: 'do not exist'}}
        end
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    def destroy
      trip = current_user.trips.where(id: params[:trip_id])

      if trip.present?
        days = trip.first.where(id: params[:ids].map{ |id| id.to_i})

        if days.present?
          days.destroy_all
          redirect_to v1_trip_day_index_url(trip_id: trip.first.id)
        else
          render json: {status: 'error', reason: {days: 'do not exist'}}
        end
      else
        render json: {status: 'error', reason: {trip: 'does not exist'}}
      end
    end

    private

    def days_params
      params.permit(:index)
    end
  end
end