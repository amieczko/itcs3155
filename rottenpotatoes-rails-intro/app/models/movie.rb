class Movie < ActiveRecord::Base
  #allow ratings data to be sent to model. Allows for pulling of requested ratings. 
  
  def Movie.all_ratings
    Movie.all.map{|movie| movie.rating}.uniq #automatically maps unique entries in rating column to hash. .uniq makes sure only 1 of each type of rating is sent. 
  end
  
  def Movie.selected_ratings
    Movie.all.each do |movie|
      if
    end
  end
  
end
