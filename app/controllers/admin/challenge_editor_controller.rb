module Admin
  class ChallengeEditorController < ApplicationController
    before_action :authorize_admin_controllers

    def all_challenges
      render json: Challenge.all
    end
  end
end