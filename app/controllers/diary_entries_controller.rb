class DiaryEntriesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher?

    @diary_entries = recipient_ids.map do |recipient_id|
      entry = Command.create entry_params.merge "#{recipient_type}_id" => recipient_id
      subcommands  = subcommands_params.map do |subcommand_params|
        Command.create subcommand_params.merge "#{recipient_type}_id" => recipient_id
      end

      [entry, subcommands]
    end
  end

private
  def entry_params
    @entry_params ||= begin
      c = params.require(:diary_entry).permit!

      @recipient_ids ||= c.delete :recipient_ids
      @recipient_type ||= c.delete :recipient_type
      @subcommands_params ||= c.delete(:commands).map(&method(:sanitize_command_params))

      sanitize_command_params c
    end
  end

  def recipient_ids
    @recipient_ids || entry_params && @recipient_ids
  end

  def recipient_type
    @recipient_type || entry_params &&  @recipient_type
  end

  def subcommands_params
    @subcommands_params || entry_params && @subcommands_params
  end

  def sanitize_command_params(p)
    p[:setid] = set_id
    p[:ends_at] = Time.from_millistr p[:ends_at]
    p[:applied_at] = Time.from_millistr p[:applied_at]
    p[:teacher_id] = current_user.id
    p #.permit!
  end

  def set_id
    @set_id ||= loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Command.where(setid: random_token).exists?
    end
  end
end
