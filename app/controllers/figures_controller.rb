class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])

    if !params[:title][:name].blank?
      figure.titles << Title.create(params[:title])
    end
    
    figure.save
    redirect to "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:name])
    
    erb :'figures/edit'
  end

end
