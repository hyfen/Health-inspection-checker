class CreateInfractions < ActiveRecord::Migration
  def self.up
    create_table :infractions do |t|
      t.integer :inspection_id
      t.string :infraction_details
      t.string :severity
      t.string :action
      t.string :court_outcome
      t.string :amount_fined
      t.timestamps
    end
    
    remove_column :inspections, :infraction_details
    remove_column :inspections, :severity
    remove_column :inspections, :action
    remove_column :inspections, :court_outcome
    remove_column :inspections, :amount_fined
    
    
  end

  def self.down
    drop_table :infractions
    
    add_column :inspections, :infraction_details, :string
    add_column :inspections, :severity, :string
    add_column :inspections, :action, :string
    add_column :inspections, :court_outcome, :string
    add_column :inspections, :amount_fined, :string
    add_column :inspections, :inspection_id, :integer
    
  end
end
