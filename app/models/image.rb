class Image < ActiveRecord::Base
  has_many :sections, as: :sectionable
  attachment :image
end
