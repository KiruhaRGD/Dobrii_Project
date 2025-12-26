import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

function GenrePage() {
  const { genre } = useParams();
  const [films, setFilms] = useState([]);

  useEffect(() => {
    fetch("http://localhost:3000/films/")
      .then(res => res.json())
      .then(data => {
        // фильтруем фильмы по жанру
        const filtered = data.filter(film => film.genres.includes(genre));
        setFilms(filtered);
      });
  }, [genre]);

  return (
    <div className="Films">
      <h1>Жанр: {genre}</h1>
      <div className="image-grid">
        {films.length === 0 && <p>Фильмы не найдены</p>}
        {films.map(film => (
          <div key={film.id} className="image-item">
            <img src={film.picture} alt={film.name} />
            <div>{film.name}</div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default GenrePage;