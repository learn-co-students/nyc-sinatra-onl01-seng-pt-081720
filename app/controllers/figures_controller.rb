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

    if !params[:title][:name].empty? #use .empty? not .blank?
      figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(params[:landmark])
    end
    
    figure.save
    redirect to "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all 
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])

    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.update(name: params[:figure][:name])
    #binding.pry
    figure.landmarks.update(name: params[:landmark][:name], year_completed: params[:landmark][:year])
    figure.save
    redirect to "/figures/#{figure.id}"
  end

end
