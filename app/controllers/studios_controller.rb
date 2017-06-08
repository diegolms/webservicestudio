class StudiosController < ApplicationController

  #lista todos os studios cadastrados na base
  def listar_studios
    render :json => Studio.all.to_json
  end

  #cadastra um novo studio
  def criar_studio
      studio = Studio.new
      studio.nome = params[:nome]
      studio.latitude = params[:latitude]
      studio.longitude = params[:longitude]
      studio.save!
      render :json => studio.to_json
  end
end
