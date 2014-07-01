class AddEventDateAndTimeToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :date, :date
    add_column :events, :time, :time
  end

  def self.down
    remove_column :events, :date
    remove_column :events, :time
  end
end
