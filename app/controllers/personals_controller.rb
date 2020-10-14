class PersonalsController < ApplicationController
  def add
    personal = Personal.find(params[:id])
    personal.personal_subsidiaries.create(subsidiary_id: params[:subsidiary_id])
    redirect_to subsidiary_path(params[:subsidiary_id]), notice: 'Filial adicionada com sucesso!'
  end
end
