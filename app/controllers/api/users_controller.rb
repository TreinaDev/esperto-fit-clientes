class Api::UsersController < ActionController::API
  def ban
    client = Client.find_by(cpf: CPF.new(params[:cpf]).formatted)
    personal = Personal.find_by(cpf: CPF.new(params[:cpf]).formatted)

    return render status: :not_found, json: 'O usuário não possui cadastro ativo' if  client==nil && personal==nil

    messages = []

    if client
      if client.active?
        client.banned!
        messages.add('Cliente banido com sucesso')
      elsif client.banned?
        messages.add('Cliente já banido anteriormente')
      end
    end

    if personal
      if personal.active?
        personal.banned!
        messages.add('Personal banido com sucesso')
      elsif personal.banned?
        messages.add('Personal já banido anteriormente')
      end
    end

    render status: :ok, json: messages
  end
end
