require 'active_admin_polymorphic'

ActiveAdmin.register Article do
  index do
    column :title
    actions
  end

  SECTIONABLES = [ Text, Image ]
  form builder: ActiveAdminPolymorphic::FormBuilder do |f|
#    f.has_many :sections do |section|
#      section.semantic_fields_for :sectionable do |ff|
#        ff.input :title
#      end
#      section.input :sectionable_id, as: :text
#      section.input :sectionable_type, as: :text
#    end

    f.inputs :title, :created_at # short syntax rules

    h2 "Sections"

    f.polymorphic_has_many :sections, :sectionable, types: SECTIONABLES, allow_destroy: true
    f.actions
  end
end
