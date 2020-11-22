class FiguresController < ApplicationController
  
  #Index
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  #New
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  #Create
  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])

    landmark_ids = params[:figure][:landmark_ids]
    title_ids = params[:figure][:title_ids]
   
    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    if landmark_ids
      landmark_ids.each do |l|
        figure.landmarks << Landmark.find(l)
      end
    end

    if !params[:title][:name].empty?
      figure.titles << Title.create(name: params[:title][:name])
    end

    if title_ids
      title_ids.each do |t|
        figure.titles << Title.find(t)
      end
      end

    figure.save
    redirect to "/figures/#{figure.id}"
  end

  #Show
  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  #Update/Edit
  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
  figure = Figure.find_by_id(params[:id])
  figure.update(params[:figure])
  landmark_ids = params[:figure][:landmark_ids]
  title_ids = params[:figure][:title_ids]

  if !params[:landmark][:name].empty?
    figure.landmarks << Landmark.create(name: params[:landmark][:name])
  end

  if landmark_ids
    landmark_ids.each do |l|
      figure.landmarks << Landmark.find(l)
    end
  end

  if !params[:title][:name].empty?
    figure.titles << Title.create(name: params[:title][:name])
  end

  if title_ids
    title_ids.each do |t|
      figure.titles << Title.find(t)
    end
    end
  figure.save
  redirect to "/figures/#{figure.id}"
end

end