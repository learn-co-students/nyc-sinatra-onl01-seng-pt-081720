class FiguresController < ApplicationController
  # add controller methods
  get "/figures" do
    @figures = Figure.all
    erb :"figures/index"
  end

  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  get "/figures/:id" do
    @figure = Figure.find_by(id: params[:id])
    erb :"figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  post "/figures" do
    
    @figure = Figure.create(name: params[:figure][:name])
    
    if !params[:title][:name].empty?
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |t|
        title = Title.find_by(id: t)
        @figure.titles << title
      end
    end

    if !params[:landmark][:name].empty?
      landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << landmark
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |l|
        landmark = Landmark.find_by(id: l)
        @figure.landmarks << landmark
      end
    end
    erb :"figures/show"
  end

  patch "/figures/:id" do
    
    @figure = Figure.find_by(id: params[:id])
    @figure.name = params[:figure][:name]

    if !params[:title][:name].empty?
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
    end

    if params[:figure][:title_ids]
      @figure.titles = []
      params[:figure][:title_ids].each do |t|
        title = Title.find_by(id: t)
        @figure.titles << title
      end
    end

    if !params[:landmark][:name].empty?
      landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << landmark
    end

    if params[:figure][:landmark_ids]
      #@figure.landmark_ids = []
      params[:figure][:landmark_ids].each do |l|
        landmark = Landmark.find_by(id: l)
        @figure.landmarks << landmark
      end
    end
    @figure.save
    erb :"figures/show"
  end




end
