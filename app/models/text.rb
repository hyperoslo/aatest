class Text < ActiveRecord::Base
  has_many :sections, as: :sectionable
end
