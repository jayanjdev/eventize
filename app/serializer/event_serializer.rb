class EventSerializer < ActiveModel::Serializer
  attributes :id, :date, :time, :tags, :custom_tags
end

