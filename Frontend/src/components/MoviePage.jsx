import { useParams } from "react-router-dom";
import movies from "./movies.js";
import '../App.css';
import '../cssFiles/Movies.css'

function MoviePage() {
  const { id } = useParams();
  const movie = movies.find(m => m.id === Number(id));
  if (!movie) return <h2>Фильм не найден</h2>;

  return (
    <div className='Container2'>
        <div className='Container3'>
            <div className="MoviePage">
                <div className="movieName">{movie.name}</div>
                <div><img src={movie.picture} alt={movie.name} /></div>
                <div>{movie.detailed_description}</div>
                <div>{movie.review_critique}</div>
                <div>{movie.duration} минут</div>
                <div>{movie.synopsis}</div>
                <div>{movie.date_release}</div>
                <div>{movie.actor} </div>
            </div>
        </div>
    </div>








    // <div>
    //   <h1>{movie.name}</h1>
    //   <img src={movie.picture} alt={movie.name} />
    //   <p>{movie.detailed_description}</p>
    // </div>
  );
}

export default MoviePage;