class Api::V1::MoodsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user_ip = request.remote_ip
    user_ip = UserIp.find_or_create_by(ip_address: user_ip)
    mood = user_ip.moods.new(mood_params)

    if mood.save
      render json: MoodSerializer.new(mood).serializable_hash, status: :created
    else
      render json: { errors: mood.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def mood_params
    params.require(:mood).permit(:emotion, :comment, :rating)
  end
end
