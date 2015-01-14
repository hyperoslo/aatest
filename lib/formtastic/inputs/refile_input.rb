module Formtastic
  module Inputs
    class RefileInput
      include Base
      include Base::Refileish

      def to_html
        input_wrapping do
          label_html <<
          builder.file_field(method, input_html_options)
        end
      end
    end
  end
end
