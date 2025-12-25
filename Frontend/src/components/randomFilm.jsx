import '../App.css';
import '../cssFiles/Movies.css'
import { useNavigate } from "react-router-dom";
import React, { useState, useEffect} from "react";


function RandomFilm(){

    const [films, setFilms] = useState([])
    React.useEffect(() => {
    fetch("http://localhost:3000/films/")
        .then((res) => res.json())
        .then((data) => setFilms(data));
    }, []);

    const getRandomFilm = () =>{
        if (films.length === 0) return;
        const randomIndex = Math.floor(Math.random() * films.length); 
        return(films[randomIndex]); 
    }
    const navigate = useNavigate();

    const handleRandomFilm = () => {
        const film = getRandomFilm();
        if (!film) return;
        navigate(`/movie/${film.id}`);
    };

    return (
        <div className="Container2">
            <div className="Container3">
                <div className="Films">
                    <div className="novinkiText">Случайный фильм</div>
                    <div className='random-blok'>
                        <button className="random-film" onClick={handleRandomFilm}>
                            <div className='text-button'>Тык=)</div>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};
export default RandomFilm;