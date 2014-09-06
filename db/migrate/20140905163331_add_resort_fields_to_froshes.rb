# Migration to add the necessary fields to a resorted model
class AddResortFieldsToFroshes < ActiveRecord::Migration
  # Adds Resort fields, next_id and first, and indexes to a given model
  def self.up
    add_column :froshes, :next_id, :integer
    add_column :froshes, :first,   :boolean
    add_index :froshes, :next_id
    add_index :froshes, :first
  end

  # Removes Resort fields
  def self.down
    remove_column :froshes, :next_id
    remove_column :froshes, :first
  end
end

