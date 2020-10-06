class PersonalsController < ApplicationController
  def add
    personal = Personal.find(params[:id])
    sub = PersonalSubsidiary.create(personal: personal, subsidiary_id: params[:subsidiary_id])
    personal.update(personal_subsidiary_id: sub.id)
    redirect_to subsidiary_path(params[:subsidiary_id]), notice: 'Filial adicionada com sucesso!'
  end
end
