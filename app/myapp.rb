require 'sinatra'

  get '/get' do
    studio = Studio.new
    studio.nome = "Diego"
    studio.latitude = 10
    studio.longitude = 20
    studio.save!
    'Hello world!'
  end

  get '/post' do
    studio = Studio.new
    studio.nome = "Diego"
    studio.latitude = 10
    studio.longitude = 20
    studio.save!
    'Hello world!'
  end
