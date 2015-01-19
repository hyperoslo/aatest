class Section < ActiveRecord::Base
  belongs_to :sectionable, polymorphic: true
  belongs_to :article
  default_scope -> { order("position ASC") }
  accepts_nested_attributes_for :sectionable
end
