class StudiosController < ApplicationController

  #lista todos os studios cadastrados na base
  def listar_studios
    render :json => Studio.all.to_json
  end

  #cadastra um novo studio
  def criar_studio
      studio = Studio.new
      studio.nome = "teste"
      studio.latitude = -3.084506666666667
      studio.longitude = "-60.000701666666664"
      studio.save!
      render :json => studio.to_json
  end
end
