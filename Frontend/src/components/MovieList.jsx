// import movies from "./movies.js";
// import MovieCard from "./MovieCard";
import "../App.css" 
import '../cssFiles/Movies.css'
import MovieCard from "./MovieCard";
import movies from "./movies";

function MovieList() {


  return (
        <>
            <div className='Container2'>
                <div className='Container3'>
                    <div className='Films'>
                      <div className='novinkiText'>Фильмы</div>
                      <div className="grid-films">
                        {movies.map(movie => (<MovieCard key={movie.id} movie={movie}/>))}
                      </div>
                    </div>
                </div>
            </div>
        </>

  );
}

export default MovieList;