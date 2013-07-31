class FilepickerInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge 'type' => 'filepicker-dragdrop', 'data-fp-key' => ::Rails.application.config.filepicker_rails.api_key
  end
end
