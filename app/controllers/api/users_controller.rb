class Api::UsersController < ActionController::API
  def ban
    return render status: :precondition_failed, json: I18n.t('users.invalid_cpf') unless CPF.valid?(cpf_param)

    client = Client.find_by(cpf: cpf_param)
    personal = Personal.find_by(cpf: cpf_param)
    return render status: :not_found, json: I18n.t('users.no_account') if client.nil? && personal.nil?

    messages = []
    user_ban(client, messages)
    user_ban(personal, messages)
    render status: :ok, json: messages
  end

  private

  def user_ban(user, messages)
    return unless user

    if user.active?
      user.banned!
      messages << user.model_name.human + I18n.t('users.successfully_banned')
    elsif user.banned?
      messages << user.model_name.human + I18n.t('users.already_banned')
    end
  end

  def cpf_param
    params[:cpf]
  end
end
