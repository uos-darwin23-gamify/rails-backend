module Admin
  class ChallengeEditorController < ApplicationController
    before_action :authorize_admin_controllers
    before_action :set_challenge, only: [:show, :update, :destroy]

    def all_challenges
      render json: Challenge.all
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
    def create
      puts "---------------------------------------------------------------------------"
      puts "Starting"
      puts challenge_params
      @challenge = Challenge.new(challenge_params)
      puts @challenge
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
      def challenge_params
        
        params.require(:challenge).permit(
          :name, 
          :difficulty, 
          :question_overview, 
          { answers: [] }, # Ensure this is an array
          :correct_answer,
          :correct_answer_explanation,
          :_type
        )
      end
      
      
    end
end