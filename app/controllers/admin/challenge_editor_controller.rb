# frozen_string_literal: true

module Admin
  class ChallengeEditorController < ApplicationController
    before_action :authorize_admin_controllers
    before_action :set_challenge, only: %i[show update destroy]

    def all_challenges
      challenges = Challenge.all.map do |challenge|
        challenge.as_json(methods: %i[id type])
      end
      render json: challenges
    end

    # GET /challenges
    def index
      @challenges = Challenge.all
      render json: @challenges
    end

    # GET /challenges/:id
    def show
      render json: @challenge
    end

    # POST /challenges
    def create_scq
      Rails.logger.debug "---------------------------------------------------------------------------"
      Rails.logger.debug "Starting"
      Rails.logger.debug scq_challenge_params
      @challenge = Challenge.new(scq_challenge_params)
      Rails.logger.debug @challenge
      if @challenge.save
        render json: @challenge, status: :created, location: @challenge
      else
        render json: @challenge.errors, status: :unprocessable_entity
      end
    end

    def create_mcq
      Rails.logger.debug "---------------------------------------------------------------------------"
      Rails.logger.debug "Starting"
      Rails.logger.debug mcq_challenge_params
      @challenge = Challenge.new(mcq_challenge_params)
      Rails.logger.debug @challenge
      if @challenge.save
        render json: @challenge, status: :created, location: @challenge
      else
        render json: @challenge.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /challenges/:id
    def update
      if @challenge.update(challenge_params)
        render json: @challenge
      else
        render json: @challenge.errors, status: :unprocessable_entity
      end
    end

    # DELETE /challenges/:id
    def destroy
      @challenge.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def scq_challenge_params
      params.require(:challenge).permit(
        :name,
        :difficulty,
        :question_overview,
        {answers: []}, # Ensure this is an array
        :correct_answer,
        :correct_answer_explanation,
        :_type
      )
    end

    def mcq_challenge_params
      params.require(:challenge).permit(
        :name,
        :difficulty,
        :question_overview,
        {answers: []}, # Ensure this is an array
        {correct_answers: []},
        :correct_answer_explanation,
        :_type
      )
    end
  end
end
