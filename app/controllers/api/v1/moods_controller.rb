class Api::V1::MoodsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_ip_address, only: [ :create, :index ]

  def create
    user_ip = UserIp.find_or_create_by(ip_address: @ip_address)

    can_submit_today =  Mood.is_submitted_today?(user_ip)

    if can_submit_today
      mood = user_ip.moods.new(mood_params)

      if mood.save
        render json: MoodSerializer.new(mood).serializable_hash, status: :created
      else
        render json: { errors: mood.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You can only submit one mood per day." }, status: :unprocessable_entity
    end
  end

  def index
    period = params[:period] || "monthly"
    user_ip = UserIp.find_by(ip_address: @ip_address)
    if user_ip.nil?
      render json: { message: "No moods found for this IP address." }, status: :not_found
    else
      moods = user_ip.moods.where(created_at: time_range(period))

      if moods.empty?
        render json: { message: "No moods found for the specified period." }, status: :not_found
      else
        render json: MoodSerializer.new(moods).serializable_hash, status: :ok
      end
    end
  end

  private

  def mood_params
    params.require(:mood).permit(:emotion, :comment, :rating)
  end

  def time_range(period)
    case period
    when "daily"
      Time.current.beginning_of_day..Time.current.end_of_day
    when "weekly"
      Time.current.beginning_of_week..Time.current.end_of_week
    when "monthly"
      Time.current.beginning_of_month..Time.current.end_of_month
    else
      Time.current.beginning_of_year..Time.current.end_of_year
    end
  end

  def set_user_ip_address
    @ip_address = request.remote_ip
  end
end
