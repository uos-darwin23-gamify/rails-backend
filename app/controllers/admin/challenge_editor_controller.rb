# frozen_string_literal: true

module Admin
  class ChallengeEditorController < ApplicationController
    before_action :authorize_admin_controllers
    before_action :set_challenge, only: %i[single destroy]

    def all
      challenges = Challenge.all.map do |challenge|
        challenge.as_json(methods: %i[id type])
      end
      placement_challenges = PlacementChallenge.all.map do |challenge|
        challenge.as_json(methods: %i[id type])
      end
      render json: {challenges: challenges, placement_challenges: placement_challenges}
    end

    def single
      render json: @challenge.as_json(methods: %i[id type])
    end

    def destroy
      @challenge.destroy
      render json: {message: "Challenge deleted successfully"}
    end

    def offset
      begin
        offset_days_param = Integer(params[:offset])
        Challenge.offset_date_when_available_by(offset_days_param)
        render json: {message: "Challenge available dates offset successfully"}
      rescue ArgumentError
        render json: {message: "Invalid offset parameter. Please provide an integer."}, status: :bad_request
      end
    end

    # # GET /challenges
    # def index
    #   @challenges = Challenge.all
    #   render json: @challenges
    # end

    # # GET /challenges/:id
    # def show
    #   render json: @challenge
    # end

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

    def create_blocks
      Rails.logger.debug "---------------------------------------------------------------------------"
      Rails.logger.debug "Starting"
      Rails.logger.debug blocks_challenge_params
      @challenge = Challenge.new(blocks_challenge_params)
      Rails.logger.debug @challenge
      puts "--------------------------"
      puts @challenge.correct_answers
      puts "-------------------------"
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

    private

    def set_challenge
      if params[:id].to_s == params[:id]
        @challenge = Challenge.find(params[:id])
        if !@challenge
          @challenge = PlacementChallenge.find(params[:id])
        end
        render json: {message: 'Challenge not found'}, status: :not_found unless @challenge
      else
        render json: {message: 'Invalid challenge ID parameter'}, status: :bad_request
      end
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

    def blocks_challenge_params
      params.require(:challenge).permit(
        :name,
        :difficulty,
        :question_overview,
        {first_group: []},
        {second_group: []}, # Ensure this is an array
        {correct_answers: []},
        :correct_answer_explanation,
        :_type
      )
    end
  end
end
