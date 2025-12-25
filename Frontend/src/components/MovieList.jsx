// import movies from "./movies.js";
// import MovieCard from "./MovieCard";
import "../App.css" 
import '../cssFiles/Movies.css'
import MovieCard from "./MovieCard";
import React, { useState, useEffect } from "react";

function MovieList() {
  
  const [films, setFilms] = useState([])
  React.useEffect(() => {
    fetch("http://localhost:3000/films/")
    .then((res) => res.json())
    .then((data) => setFilms(data));
  }, []);


  return (
        <>
            <div className='Container2'>
                <div className='Container3'>
                    <div className='Films'>
                      <div className='novinkiText'>Фильмы</div>
                      <div className="grid-films">
                        {films.map(movie => (
                          <MovieCard key={movie.id} movie={movie}/>
                        ))}
                      </div>
                    </div>
                </div>
            </div>
        </>
  );
}

export default MovieList;