class CreateUserImportJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_import_jobs do |t|

      t.timestamps
    end
  end
end
