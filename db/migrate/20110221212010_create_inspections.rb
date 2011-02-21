class CreateInspections < ActiveRecord::Migration
  def self.up
    create_table :inspections do |t|
      t.integer :establishment_id
      t.datetime :date
      t.string :status
      t.string :infraction_details
      t.string :severity
      t.string :action
      t.string :court_outcome
      t.string :amount_fined
      t.timestamps
    end
  end

  def self.down
    drop_table :inspections
  end
end
