class Event < ActiveRecord::Base
  belongs_to :user
  before_save :update_tags

  def update_tags
    self.tags = TagsGenerator.new(description).tags.join(',')
  end

  def tag_list
    tags.split(',')
  end
end
