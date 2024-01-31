# frozen_string_literal: true

module Users
  class ChallengesController < ApplicationController
    before_action :authorize_user_controllers

    def all_challenges
      challenges = Challenge.all.as_json(only: [:name, :difficulty], methods: [:id, :type])
      render json: challenges
    end

    def challenge
      challenge_oid = params[:id]

      # if challenge_name.nil? || !challenge_name.is_a?(String)
      #   return render_bad_request
      # end

      # challenge = Challenge.find_by(name: challenge_name)
      # return render_bad_request if challenge.nil?

      if challenge_oid.nil? || !challenge_oid.is_a?(String)
        return render_bad_request
      end

      challenge = Challenge.find(challenge_oid)
      return render_bad_request if challenge.nil?

      case challenge.type
      when "FillBlankChallenge"
        render json: challenge.as_json(only: [:name, :difficulty, :question_array])
      when "McqChallenge"
        render json: challenge.as_json(only: [:name, :difficulty, :question, :answers])
      when "DragDropChallenge"
        render json: challenge.as_json(only: [:name, :difficulty, :items])
      else
        render_internal_server_error
      end
    end

    def submit_challenge_solution
      render json: {}
    end
  end
end
