class RefileInput < Formtastic::Inputs::FileInput
  def file_input_html_options
    options.delete :hint
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

    options.merge(input_html_options)
  end

  def hidden_input_html_options
    attacher = object.send(:"#{method}_attacher")
    { value: attacher.data.to_json, object: object, id: nil }
  end

  def to_html
    input_wrapping do
      label_html << builder.hidden_field(method, hidden_input_html_options) << builder.file_field(method, file_input_html_options)
    end
  end
end
