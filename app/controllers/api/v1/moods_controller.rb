class Api::V1::MoodsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    ip_address = request.remote_ip
    user_ip = UserIp.find_or_create_by(ip_address: ip_address)

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

  private

  def mood_params
    params.require(:mood).permit(:emotion, :comment, :rating)
  end
end
