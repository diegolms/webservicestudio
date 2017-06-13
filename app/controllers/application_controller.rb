class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def save_paperclip(params, zipar = true)

    arquivo = Arquivo.new
    arquivo.salvar_arquivo(params, request)

  end

end
