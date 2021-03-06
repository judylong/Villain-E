module Api
  class RewardingsController < ApiController
    def create
      @rewarding = current_user.rewardings.new(rewarding_params)
      if @rewarding.save
        render json: @rewarding
      else
        render json: @rewarding.errors.full_messages, status: 402
      end
    end

    private
    def rewarding_params
      params.require(:rewarding).permit(:reward_id)
    end
  end
end
