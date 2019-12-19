class CreateUserImportJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_import_jobs do |t|
      t.string :auth0_job_id, null: true

      t.timestamps
    end
    add_foreign_key :user_import_jobs, :auth0_jobs, type: :string, foreign_key: true, null: true
  end
end
