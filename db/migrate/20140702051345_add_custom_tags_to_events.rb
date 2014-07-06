class AddCustomTagsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :custom_tags, :string, :default => ''
  end

  def self.down
    remove_column :events, :custom_tags
  end
end
