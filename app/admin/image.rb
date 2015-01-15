ActiveAdmin.register Image do

  form do |f|
    f.inputs do
      f.input :title

      f.input :image, as: :refile, direct: true, host: request.base_url,
        image_preview: [ :fill, 175, 300 ], hint: 'Please upload awesome images'
    end

    f.actions
  end

  show do |image|
    image_tag attachment_url(image, :image, :fill, 100, 100)
  end
end
