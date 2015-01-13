class Text < ActiveRecord::Base
  has_many :sections, as: :sectionable
  validates_presence_of :title
end
