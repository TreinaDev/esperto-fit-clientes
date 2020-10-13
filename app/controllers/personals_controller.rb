class PersonalsController < ApplicationController
  def add
    personal = Personal.find(params[:id])
    sub = personal.personal_subsidiaries.create(subsidiary_id: params[:id])
    personal.update(personal_subsidiary_id: sub.id)
    redirect_to subsidiary_path(params[:subsidiary_id]), notice: 'Filial adicionada com sucesso!'
  end
end
