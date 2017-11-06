class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render(
      json: movies.to_json(only: [:id, :title, :release_date]),
      status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render(
        json: movie.as_json(only: [:title, :overview, :release_date, :inventory]).merge("available_inventory" => movie.inventory),
        status: :ok
      )
    else
      render(
        json: {
          "ok" => false,
          "errors" => {
            "id": ["Could not find movie with id: #{params[:id]}"]
          }
        },
        status: :not_found
      )
    end
  end

end