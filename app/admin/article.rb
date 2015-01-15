require 'active_admin_polymorphic'

ActiveAdmin.register Article do
  index do
    id_column

    column :title
    column :created_at
    column :updated_at

    actions
  end

  SECTIONABLES = [ Text, Image ]
  form builder: ActiveAdminPolymorphic::FormBuilder do |f|
    f.inputs :title

    h2 "Sections"

    f.polymorphic_has_many :sections, :sectionable, types: SECTIONABLES, allow_destroy: true
    f.actions
  end
end
