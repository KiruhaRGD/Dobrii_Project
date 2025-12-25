import '../App.css';
import '../cssFiles/Movies.css'
import React, { useState, useEffect } from "react";


function RandomFilm(){

      const [films, setFilms] = useState([])
      React.useEffect(() => {
        fetch("http://localhost:3000/films/")
        .then((res) => res.json())
        .then((data) => setFilms(data));
      }, []);





    return(
        <>
            <div className='Container2'>
                <div className='Container3'>
                    <div className='Films'>
                      <div className='novinkiText'>Случайный фильм</div>
                      <button className='random-film'>
                        <div className='filmName'>Тык</div>
                      </button>
                    </div>
                </div>
            </div>
        </>
    );
};
export default RandomFilm;