class FileuploaderInput < Formtastic::Inputs::FileInput
  def input_html_options
    s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{sanitized_object_name}/#{sanitized_method_name}/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    super.merge class: 'directUpload', data: {url: s3_direct_post.url.to_s, host: s3_direct_post.url.host.to_s, fields: s3_direct_post.fields.to_json}
  end
end
