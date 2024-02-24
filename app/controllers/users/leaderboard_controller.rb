# frozen_string_literal: true

module Users
  class LeaderboardController < ApplicationController
    before_action :authorize_user_controllers

    def elo
      user = current_user
      render json: {elo: user.elo}
    end
  end
end
