# frozen_string_literal: true

module Admin
  class PreAuthorizedEmailsController < ApplicationController
    before_action :authorize_admin_controllers

    def all_pre_authorized_emails
      render json: {emails: PreAuthorizedEmail.select(:id, :email)}
    end

    def create_pre_authorized_email
      return render_bad_request unless new_email_ok?

      if PreAuthorizedEmail.exists?(email: params[:email].downcase)
        return render json:   {message: "Email already exists"},
                      status: :unprocessable_entity
      end

      @pre_authorized_email = PreAuthorizedEmail.new(email: params[:email].downcase)

      @pre_authorized_email.save
      render json: {message: "Creation successful"}
    end

    def update_pre_authorized_email
      return render_bad_request if params[:id].nil?

      @pre_authorized_email = PreAuthorizedEmail.find(params[:id])
      return render_bad_request if @pre_authorized_email.nil?

      return render_bad_request unless new_email_ok?

      if @pre_authorized_email.email.downcase == params[:email].downcase
        return render json:   {message: "Same as before, supply a different email"},
                      status: :bad_request
      end

      if PreAuthorizedEmail.exists?(email: params[:email].downcase)
        return render json:   {message: "Email already exists"},
                      status: :unprocessable_entity
      end

      @pre_authorized_email.email = params[:email].downcase

      @pre_authorized_email.save
      render json: {message: "Update successful"}
    end

    def delete_pre_authorized_email
      return render_bad_request if params[:id].nil? || !PreAuthorizedEmail.exists?(id: params[:id])

      @pre_authorized_email = PreAuthorizedEmail.find(params[:id])
      return render_bad_request if @pre_authorized_email.nil?

      @pre_authorized_email.destroy
      render json: {message: "Delete successful"}
    end

    EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/

    private

    def valid_email?(email_)
      EMAIL_REGEX.match?(email_)
    end

    def new_email_ok?
      !params[:email].nil? && valid_email?(params[:email].downcase)
    end
  end
end
