class Event < ActiveRecord::Base
  belongs_to :user
  before_save :update_tags

  def update_tags
    self.tags = TagsGenerator.new(description).tags.join(',')
  end

  def add_to_custom_tags(new_tag)
    self.custom_tags = (custom_tags.split(',') << new_tag).join(',')
    save
  end

  def delete_to_custom_tags(tag)
    self.custom_tags = (custom_tags.split(',').reject(new_tag)).join(',')
    save
  end

  def tags_list
    tags.split(',') 
  end

  def custom_tags_list
    custom_tags.split(',')
  end

  def all_tags
    tags_list + custom_tags_list
  end

  def self.search(tags, user)
    return [] if tags.blank?
    given_tags = tags.split(',') 
    Event.where(:user => user).select { |a| 
      given_tags.detect { |tag| a.all_tags.include?(tag) }
    }
  end
end
