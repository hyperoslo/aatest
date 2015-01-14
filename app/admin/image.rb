ActiveAdmin.register Image do

  form do |f|
    f.inputs do
      f.input :image, as: :refile,
        direct: true, host: request.base_url
      end
    f.actions
  end

end
