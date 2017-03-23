class MoviesController < ApplicationController

  def movie_params #Basically a gate on which URI's/Objects to include
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @movies = Movie.where(session[:ratings].order(params[:sort_by])
    #show only wanted ratings

    
    
    #pull all types of ratings from DB
    @all_ratings = Movie.all_ratings

    if params[:ratings]#if there are params in the URI route.
      #@ratings_hash = params[:ratings] #Recieve hash from URI
      #@ratings_array = params[:ratings].keys #Extract Data from Hash?
      #session[:ratings] = @ratings_hash #sets Session data(live view)
      session[:ratings] = params[:ratings]

    else #clear hash and ratings array.
      @ratings_hash = {}
      @ratings_array = @all_ratings #Updates ratings_array to all ratings for display. 
    end
    
    
    #sort
    if params[:sort_by]
      session[:sort_by] = params[:sort_by]
      if (params[:sort_by] == "title")
        @title_header = "hilite"
      elsif (params[:sort_by] == "release_date")
        @release_date_header = "hilite"
      end
    end
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
