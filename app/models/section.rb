class Section < ActiveRecord::Base
  belongs_to :sectionable, polymorphic: true
  belongs_to :article
end
