class CreateEstablishments < ActiveRecord::Migration
  def self.up
    create_table :establishments do |t|
      t.string :name
      t.string :type
      t.string :address
      t.integer :min_inspections
      t.integer :location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :establishments
  end
end
