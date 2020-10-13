class Api::UsersController < ActionController::API
  def ban
    return render status: :precondition_failed, json: 'CPF inválido' unless CPF.valid?(params[:cpf])

    cpf_formatted = CPF.new(params[:cpf]).formatted
    client = Client.find_by(cpf: cpf_formatted)
    personal = Personal.find_by(cpf: cpf_formatted)
    return render status: :not_found, json: 'O usuário não possui cadastro ativo' if client.nil? && personal.nil?

    messages = [user_ban(client), user_ban(personal)]

    render status: :ok, json: messages
  end

  private

  def user_ban(user)
    return unless user

    if user.active?
      user.banned!
      "#{user.model_name.human} banido com sucesso"
    elsif user.banned?
      "#{user.model_name.human} já banido anteriormente"
    end
  end
end
