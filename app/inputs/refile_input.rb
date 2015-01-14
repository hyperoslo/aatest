class RefileInput < Formtastic::Inputs::FileInput
  def input_html_options
    options[:data] ||= {}

    attacher = object.send(:"#{method}_attacher")
    options[:accept] = attacher.accept

    if options[:direct]
      host = Refile.host || options[:host]
      backend_name = Refile.backends.key(attacher.cache)

      url = ::File.join(host, Rails.application.routes.url_helpers.refile_app_path, backend_name)
      options[:data].merge!(direct: true, as: "file", url: url)
    end

    if options[:presigned] and attacher.cache.respond_to?(:presign)
      options[:data].merge!(direct: true).merge!(attacher.cache.presign.as_json)
    end

    options.merge(super)
  end

  def to_html
    input_wrapping do
      label_html <<
      builder.file_field(method, input_html_options)
    end
  end
end
