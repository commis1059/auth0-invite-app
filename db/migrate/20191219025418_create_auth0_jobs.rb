class CreateAuth0Jobs < ActiveRecord::Migration[6.0]
  def change
    create_table :auth0_jobs, id: :string do |t|
      t.string :status, null: false

      t.timestamps
    end
  end
end
