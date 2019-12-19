# frozen_string_literal: true

module Api
  class UserImportJobsController < ActionController::API
    #include Secured

    def create
      UserImportJob.new(user_import_job_params).save

      render json: 'User import job posted.'
    end

    private

    def user_import_job_params
      params.fetch(:user_import_job).permit(:form)
    end

  end
end
