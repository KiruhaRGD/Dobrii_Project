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
                <div className="blok1">
                  <div><img src={movie.picture} alt={movie.name} /></div>
                  <div className="blok2">
                    <div><div className="text">Описание:</div> {movie.detailed_description}</div>
                    <div><div className="text">Мнение критиков:</div>{movie.review_critique}</div>
                    <div><div className="text">Длительность:</div>{movie.duration} минут</div>
                    <div><div className="text">Дата выпуска:</div>{movie.date_release}</div>
                    <div><div className="text">В главных ролях:</div> {movie.duration}<div></div>{movie.duration}</div> 
                  </div>
              </div>
              <div className="blok3"></div>
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