class MoviesController < ApplicationController

  @@SORT_BY = [:title, :release_date]

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    flash.delete :notice
    if params.include? :sort_by
      sort_by = params[:sort_by]

      if @@SORT_BY.include? sort_by.to_sym
        @movies = Movie.all.sort {|a,b| a.send(sort_by) <=> b.send(sort_by)}
        flash.delete :notice
        return
      else
        flash[:notice] = "Can't sort movies by parameter #{sort_by}." 
      end
    end
    @movies = Movie.all.sort
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
