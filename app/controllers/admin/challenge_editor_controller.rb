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

    def edit
      id = params[:id]
      date_when_available = params[:date_when_available]
      type = params[:type]
      rest = params.except(:id, :date_when_available, :type, :controller, :action, :premitted,
                           :challenge_editor).permit!

      old_challenge = Challenge.find(id)
      old_challenge = PlacementChallenge.find(id) if old_challenge.nil?
      if old_challenge.nil?
        return render json: {message: 'Challenge with provided ID does not exist'}, status: :bad_request
      end

      old_attributes = old_challenge.attributes
      old_challenge.destroy

      class_name = "Challenge::#{type.split('Challenge').first}"
      if !date_when_available
        class_name = "Placement" + class_name
      end

      rest["_id"] = id
      if Object.const_defined?(class_name)
        if date_when_available
          challenge = class_name.constantize.new(rest.merge(date_when_available: Date.parse(date_when_available)))
        else
          challenge = class_name.constantize.new(rest)
        end
      else
        return render json: {message: 'Challenge class with provided type does not exist'}, status: 500
      end

      unless challenge.save
        old_class_name = "Challenge::#{type.split('Challenge').first}"
        if old_attributes["date_when_available"].nil?
          old_class_name = "Placement" + old_class_name
        end
        if Object.const_defined?(old_class_name)
          old_challenge = old_class_name.constantize.new(old_attributes)
        else
          return render json: {message: 'Challenge class with provided type does not exist'}, status: 500
        end
        if old_challenge.save
          return render json: {message: 'Challenge update failed'}, status: :bad_request
        else
          return render_internal_server_error
        end
      end

      render json: {message: 'Challenge updated successfully'}
    end

    def new
      date_when_available = params[:date_when_available]
      type = params[:type]
      rest = params.except(:id, :date_when_available, :type, :controller, :action, :premitted,
                           :challenge_editor).permit!

      class_name = "Challenge::#{type.split('Challenge').first}"
      if !date_when_available
        class_name = "Placement" + class_name
      end

      if Object.const_defined?(class_name)
        if date_when_available
          challenge = class_name.constantize.new(rest.merge(date_when_available: Date.parse(date_when_available)))
        else
          challenge = class_name.constantize.new(rest)
        end
      else
        return render json: {message: 'Challenge class with provided type does not exist'}, status: 500
      end

      unless challenge.save
        return render_internal_server_error
      end

      render json: {message: 'Challenge created successfully'}
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
        render json: {message: 'Challenge with provided ID does not exist'}, status: :bad_request
      end
    end
  end
end
