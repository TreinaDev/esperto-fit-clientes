class Api::UsersController < ActionController::API
  def ban
    unless CPF.valid?(cpf_param)
      return render status: :precondition_failed, json: { messages: [I18n.t('users.invalid_cpf')], status: 412 }
    end

    client = Client.find_by(cpf: cpf_param)
    per = Personal.find_by(cpf: cpf_param)

    return render status: :not_found, json: { messages: [I18n.t('users.no_account')], status: 404 } unless client || per

    messages = []
    user_ban(client, messages)
    user_ban(per, messages)
    render status: :ok, json: { messages: messages, status: 200 }
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
