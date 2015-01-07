ActiveAdmin.register Article do
  index do
    actions
  end

  SECTIONABLES = [ 'Text', 'Image' ]
  form do |f|
    f.has_many :sections do |section|
      section.input :sectionable_type, input_html: { parent: true },
        collection: SECTIONABLES.map { |sectionable|
        [sectionable.constantize.model_name.human, sectionable]
      }

      SECTIONABLES.each do |sectionable_class|
        section.input :sectionable, wrapper_html: { class: 'hide', child: true,
                                                    model: sectionable_class },
          collection: sectionable_class.constantize.all.map { |sectionable|
            [sectionable.to_s, sectionable.id]
          }
#        div class: "hide", child: true, model: sectionable_class do
#          render(partial: sectionable_class.underscore).html_safe
#        end
        inputs "test" do
          h3 "Ohai"
        end
      end

      section.input :_destroy, as: :boolean, label: I18n.t('texts.destroy')
    end

    f.actions
  end
end
