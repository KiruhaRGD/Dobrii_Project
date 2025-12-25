import { Link } from "react-router-dom";
import "../App.css" 
import '../cssFiles/Movies.css'

function MovieCard({ movie }) {
  if (!movie) return null;

  return (
    <div>
      <Link to={`/movie/${movie.id}`} className="link-reset">
        <button className="filmCard">
          <div><img src={movie.picture} alt={movie.name} /></div>
          <div className="filmName">{movie.name}</div>
        </button>
      </Link>
    </div>
  );
}

export default MovieCard;