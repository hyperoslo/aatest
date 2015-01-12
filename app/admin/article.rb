require 'active_admin_polymorphic'

ActiveAdmin.register Article do
  index do
    actions
  end

  SECTIONABLES = [ 'Text', 'Image' ]
  form builder: ActiveAdminPolymorphic::FormBuilder do |f|
#    f.has_many :sections do |section|
#      section.semantic_fields_for :sectionable do |ff|
#        ff.input :title
#      end
#      section.input :sectionable_id, as: :text
#      section.input :sectionable_type, as: :text
#    end

    f.input :created_at
    f.polymorphic_has_many :sections, :sectionable, types: ['Text', 'Image'], allow_destroy: true
    f.actions
  end
end
