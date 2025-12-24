import movies from "./movies.js";
import MovieCard from "./MovieCard";

function MovieList() {
  return (
    <div className="movie-list">
      {movies.map(movie => (
        <MovieCard key={movie.id} movie={movie} />
      ))}
    </div>
  );
}

export default MovieList;