# -*- encoding : utf-8 -*-
require 'digest/md5'
class Arquivo < ActiveRecord::Base
  has_attached_file :arquivo

  def salvar_arquivo(params, request)
    upload = params[:qqfile]
    ie = nil

    if upload.class.to_s.eql?("String")
      self.arquivo_file_name = upload
      self.nome_original = upload
    else
      self.arquivo_file_name = upload.original_filename
      ie = upload
    end

    self.save!

    init = self.arquivo_file_name.rindex(".")
    fim = self.arquivo_file_name.length

    begin
      tipo_arquivo = self.arquivo_file_name[init, fim]
      self.arquivo_file_name = "#{self.id}#{tipo_arquivo}"
    rescue Exception => e
      Log.escrever e
      nome_arquivo = self.id
      self.arquivo_file_name = nome_arquivo
    end

    self.save!

    url_pasta = "#{Rails.root}/public/system/arquivos/#{self.identificador_pasta}"

    unless File.directory?(url_pasta)
      Dir.mkdir(url_pasta)
    end


    newf = File.open("#{Rails.root}/public#{self.url_local}", "wb")
    if ie
      str = ie.tempfile.read
    else
      str = request.body.read
    end
    newf.write(str)
    newf.close

    return self.id

  end

  def salvar_arquivo_pdf(pdf, nome)


    self.arquivo_file_name = nome
    self.save!

    init = self.arquivo_file_name.rindex(".")
    fim = self.arquivo_file_name.length

    # se existir ponto separa para identificar o tipo de arquivo, senao guarda do jeito
    # que foi enviado
    begin
      tipo_arquivo = self.arquivo_file_name[init, fim]
      self.arquivo_file_name = "#{self.id}#{tipo_arquivo}"
    rescue Exception => e
      Log.escrever e
      nome_arquivo = self.id
      self.arquivo_file_name = nome_arquivo
    end

    self.save!

    url_pasta = "#{Rails.root}/public/system/arquivos/#{self.identificador_pasta}"

    unless File.directory?(url_pasta)
      Dir.mkdir(url_pasta)
    end

    pdf.render_file "#{Rails.root}/public#{self.url_local}"

    return self.id

  end

  def salvar_arquivo_fisico(nome, url)


    self.arquivo_file_name = nome
    self.save!

    init = self.arquivo_file_name.rindex(".")
    fim = self.arquivo_file_name.length

    # se existir ponto separa para identificar o tipo de arquivo, senao guarda do jeito
    # que foi enviado
    begin
      tipo_arquivo = self.arquivo_file_name[init, fim]
      self.arquivo_file_name = "#{self.id}#{tipo_arquivo}"
    rescue Exception => e
      Log.escrever e
      nome_arquivo = self.id
      self.arquivo_file_name = nome_arquivo
    end

    self.save!

    url_pasta = "#{Rails.root}/public/system/arquivos/#{self.identificador_pasta}"

    unless File.directory?(url_pasta)
      Dir.mkdir(url_pasta)
    end

    Util.mover_arquivo("#{url}/#{nome}", "#{url_pasta}/#{self.arquivo_file_name}")

    return self.id

  end

  def salvar_arquivo_excel(axlsx, nome)


    self.arquivo_file_name = nome
    self.save!

    init = self.arquivo_file_name.rindex(".")
    fim = self.arquivo_file_name.length

    # se existir ponto separa para identificar o tipo de arquivo, senao guarda do jeito
    # que foi enviado
    begin
      tipo_arquivo = self.arquivo_file_name[init, fim]
      self.arquivo_file_name = "#{self.id}#{tipo_arquivo}"
    rescue Exception => e
      Log.escrever e
      nome_arquivo = self.id
      self.arquivo_file_name = nome_arquivo
    end

    self.save!

    url_pasta = "#{Rails.root}/public/system/arquivos/#{self.identificador_pasta}"

    unless File.directory?(url_pasta)
      Dir.mkdir(url_pasta)
    end

    axlsx.serialize "#{Rails.root}/public#{self.url_local}"

    return self.id

  end

  #def salvar_arquivo


  def url_original

    gen_sec_link("/arquivos/#{self.identificador_pasta}/#{self.arquivo_file_name}")

  end

  def identificador_pasta
    self.id.to_s[0..1]
  end

  def gen_sec_link(rel_path)
    rel_path.sub!(/^([^\/])/, '/\1') # Make sure it had a leading slash
    s_secret = '5369778c4f8c6d45446a6ff92a1689fe' # Secret string

    uri_prefix = '/static/' # Arbitrary download prefix
    timestamp = "%08x" % Time.now.to_i # Timestamp, to hex
    token = Digest::MD5.hexdigest(s_secret + rel_path + timestamp).to_s # Token Creation
    '%s%s/%s%s' % [uri_prefix, token, timestamp, rel_path] # Return the properly formatted string
  end


  def url_local

    "/system/arquivos/#{self.identificador_pasta}/#{self.arquivo_file_name}"

  end

end
