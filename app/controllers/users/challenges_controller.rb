# frozen_string_literal: true

module Users
  class ChallengesController < ApplicationController
    before_action :authorize_user_controllers

    def placement_challenges_status
      user = current_user

      render json: {placement_challenges_finished: placement_challenges_finished(user)}
    end

    def all_challenges
      user = current_user

      respond_normal_challenges = placement_challenges_finished(user)

      challenges = if respond_normal_challenges
                     Challenge.available_today.map do |challenge|
                       challenge_started = user.solutions.exists?(challenge_oid: challenge.id)
                       solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
                       extra_fields = {
                         start_time: solution&.start_time,
                         end_time:   solution&.end_time,
                         started:    challenge_started,
                         finished:   !solution&.end_time.nil?
                       }
                       challenge.as_json(only: %i[name difficulty], methods: %i[id type]).merge(extra_fields)
                     end
                   else
                     PlacementChallenge.all.map do |challenge|
                       challenge_started = user.solutions.exists?(challenge_oid: challenge.id)
                       solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
                       extra_fields = {
                         start_time: solution&.start_time,
                         end_time:   solution&.end_time,
                         started:    challenge_started,
                         finished:   !solution&.end_time.nil?
                       }
                       challenge.as_json(only: %i[name difficulty], methods: %i[id type]).merge(extra_fields)
                     end
                   end

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

      user = current_user
      challenge = if placement_challenges_finished(user)
                    Challenge.find(challenge_oid)
                  else
                    PlacementChallenge.find(challenge_oid)
                  end

      return render_bad_request if challenge.nil?

      return render_bad_request if challenge.is_a?(Challenge) && !challenge.available_today?

      challenge_started = user.solutions.exists?(challenge_oid: challenge.id)

      case challenge.type
      when "ScqChallenge"
        create_challenge_start(user, challenge, challenge_started)
        solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
        extra_fields = {start_time: solution&.start_time, end_time: solution&.end_time, started: challenge_started,
finished: !solution&.end_time.nil?, answer: solution&.answer}
        render json: challenge.as_json(only:    %i[name question_overview difficulty answers],
                                       methods: %i[id type]).merge(extra_fields)
      when "McqChallenge"
        create_challenge_start(user, challenge, challenge_started)
        solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
        extra_fields = {start_time: solution&.start_time, end_time: solution&.end_time, started: challenge_started,
finished: !solution&.end_time.nil?, answer: solution&.answer}
        render json: challenge.as_json(only:    %i[name question_overview difficulty answers],
                                       methods: %i[id type]).merge(extra_fields)
      when "ConnectBlocksChallenge"
        create_challenge_start(user, challenge, challenge_started)
        solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
        extra_fields = {start_time: solution&.start_time, end_time: solution&.end_time, started: challenge_started,
finished: !solution&.end_time.nil?, answer: solution&.answer}
        render json: challenge.as_json(only:    %i[name question_overview difficulty first_group second_group],
                                       methods: %i[id type]).merge(extra_fields)
      when "CodeOutputChallenge"
        create_challenge_start(user, challenge, challenge_started)
        solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
        extra_fields = {start_time: solution&.start_time, end_time: solution&.end_time, started: challenge_started,
finished: !solution&.end_time.nil?, answer: solution&.answer}
        render json: challenge.as_json(only:    %i[name question_overview difficulty code question_array],
                                       methods: %i[id type]).merge(extra_fields)
      else
        render_internal_server_error
      end
    end

    def submit_challenge_solution
      challenge_oid = params[:id]

      return render_bad_request if challenge_oid.nil? || !challenge_oid.is_a?(String)

      user = current_user
      challenge = if placement_challenges_finished(user)
                    Challenge.find(challenge_oid)
                  else
                    PlacementChallenge.find(challenge_oid)
                  end

      return render_bad_request if challenge.nil?

      return render_bad_request if challenge.is_a?(Challenge) && !challenge.available_today?

      solution = params[:solution]
      return render_bad_request if solution.nil?

      result = challenge.verify_solution(solution)

      existing_solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)

      return render_bad_request unless existing_solution&.answer_correct.nil?

      new_elo = calculate_new_elo(user, challenge, result)
      elo_change = new_elo - user.elo
      existing_solution.update(answer: solution.to_json, answer_correct: result, end_time: Time.zone.now,
                               new_elo:, elo_change:)

      user.update(elo: [new_elo, 0].max)

      # Update Leaderboard

      if user.league?
        update_league_leaderboard
      elsif user.global?
        update_global_leaderboard
      end

      unless result == 1
        return render json:   {result: "Incorrect", explanation: challenge.correct_answer_explanation},
                      status: :precondition_failed
      end

      render json: {result: "Correct", explanation: challenge.correct_answer_explanation}
    end

    private

    def create_challenge_start(user, challenge, challenge_started)
      return if challenge_started

      Solution.create!(
        user_email:    user.email,
        challenge_oid: challenge.id
      )
    end
  end
end
