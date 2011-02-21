class CreateEstablishments < ActiveRecord::Migration
  def self.up
    create_table :establishments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :establishments
  end
end
