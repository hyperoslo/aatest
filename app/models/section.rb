class Section < ActiveRecord::Base
  belongs_to :sectionable, polymorphic: true
  belongs_to :article
  accepts_nested_attributes_for :sectionable
end
