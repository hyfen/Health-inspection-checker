class Indices < ActiveRecord::Migration
  def self.up
    add_index(:establishments, :address)
    add_index(:locations, :address)    
  end

  def self.down
    remove_index(:establishments, :adress)
    remove_index(:locations, :address)
  end
end
