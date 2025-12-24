import { Link } from "react-router-dom";

function MovieCard({ movie }) {
  if (!movie) return null;

  return (
    <div>
      <img src={movie.picture} alt={movie.name} />
      <h3>{movie.name}</h3>
      <p>{movie.synopsis}</p>

      <Link to={`/movie/${movie.id}`}>
        <button>Подробнее</button>
      </Link>
    </div>
  );
}

export default MovieCard;