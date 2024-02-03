# frozen_string_literal: true

module Users
  class ChallengesController < ApplicationController
    before_action :authorize_user_controllers

    def all_challenges
      challenges = Challenge.all.as_json(only: %i[name difficulty], methods: %i[id type])
      render json: challenges
    end

    def challenge
      challenge_oid = params[:id]

      # if challenge_name.nil? || !challenge_name.is_a?(String)
      #   return render_bad_request
      # end

      # challenge = Challenge.find_by(name: challenge_name)
      # return render_bad_request if challenge.nil?

      return render_bad_request if challenge_oid.nil? || !challenge_oid.is_a?(String)

      challenge = Challenge.find(challenge_oid)
      return render_bad_request if challenge.nil?

      case challenge.type
      when "ScqChallenge"
        render json: challenge.as_json(only: %i[name question_overview difficulty answers], methods: %i[id type])
      when "McqChallenge"
        render json: challenge.as_json(only: %i[name question_overview difficulty answers], methods: %i[id type])
      when "ConnectBlocksChallenge"
        render json: challenge.as_json(only:    %i[name question_overview difficulty first_group second_group],
                                       methods: %i[id type])
      when "CodeOutputChallenge"
        render json: challenge.as_json(only:    %i[name question_overview difficulty code question_array],
                                       methods: %i[id type])
      else
        render_internal_server_error
      end
    end

    def submit_challenge_solution
      challenge_oid = params[:id]

      return render_bad_request if challenge_oid.nil? || !challenge_oid.is_a?(String)

      challenge = Challenge.find(challenge_oid)
      return render_bad_request if challenge.nil?

      solution = params[:solution]
      return render_bad_request if solution.nil?

      result = challenge.verify_solution(solution)

      unless result
        return render json:   {result: "Incorrect", explanation: challenge.correct_answer_explanation},
                      status: :precondition_failed
      end

      render json: {result: "Correct", explanation: challenge.correct_answer_explanation}
    end
  end
end
