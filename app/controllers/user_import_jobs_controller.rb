# frozen_string_literal: true

class UserImportJobsController < ActionController::API
  #include Secured

  private

  def user_import_job_params
    params.fetch(:user_import_job).permit(:form)
  end

end
