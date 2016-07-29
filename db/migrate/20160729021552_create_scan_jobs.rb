class CreateScanJobs < ActiveRecord::Migration
  def change
    create_table :scan_jobs do |t|
      t.string :job_id

      t.timestamps null: false
    end
  end
end
