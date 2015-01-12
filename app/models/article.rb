class Article < ActiveRecord::Base
  has_many :sections
  accepts_nested_attributes_for :sections, allow_destroy: true
end
