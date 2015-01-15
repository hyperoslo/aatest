ActiveAdmin.register Image do

  form do |f|
    f.inputs do
      f.input :title
      f.input :image, as: :refile, direct: true, host: request.base_url,
        hint:(f.object.new_record? ? nil : f.template.image_tag(attachment_url(f.object, :image, :fill, 100, 100)))
      end
    f.actions
  end

  show do |image|
    image_tag attachment_url(image, :image, :fill, 100, 100)
  end
end
