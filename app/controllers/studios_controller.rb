class StudiosController < ApplicationController

  skip_before_action :verify_authenticity_token

  #lista todos os studios cadastrados na base
  def listar_studios
    render :json => Studio.all.to_json
  end

  #cadastra um novo studio
  def criar_studio
    begin
      result = Hash.new
      studio = Studio.new

      arquivo = Arquivo.new
      arquivo.salvar_arquivo(params, request)

      studio.arquivo_id = arquivo.id

       studio.nome = "teste"
      # studio.latitude = "-3.084506666666667"
      # studio.longitude = "-60.000701666666664"
      if studio.save
        result[:status] = 200
        result[:message] = "Studio criado com sucesso"
        result[:studio] = studio
        result[:image] = studio.arquivo.url_original
      else
        result[:status] = 500
        result[:message] = studio.errors
      end
    rescue Exception => ex

    end


    render :json => result.to_json

      # p "params #{params}"
  end

  def teste_arquivo
    session[:id_arquivo_ordem_servico] = save_paperclip(params)
    render :text => '{success:true}'
  end


end
