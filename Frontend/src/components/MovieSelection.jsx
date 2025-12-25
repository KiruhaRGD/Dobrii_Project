import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import filterFilms from './filterFilms';
import '../App.css';
import '../cssFiles/Movies.css'

function MovieSelection() {
  const [films, setFilms] = useState([]);
  const [filters, setFilters] = useState({
    genre: "",
    regisseur: "",
    yearFrom: "",
    yearTo: "",
    durationFrom: "",
    durationTo: ""
  });

  const navigate = useNavigate();

  useEffect(() => {
    fetch("http://localhost:3000/films/")
      .then(res => res.json())
      .then(data => setFilms(data))
      .catch(err => console.error(err));
  }, []);

  const filteredFilms = filterFilms(films, filters);

  const getRandomFilm = () => {
    if (filteredFilms.length === 0) return null;
    const index = Math.floor(Math.random() * filteredFilms.length);
    return filteredFilms[index];
  };

  return (
    <div className='Container2'>
      <div className='Container3'>
        <div className='Films'>
          <div className='novinkiText'>Подбор фильма</div>
          <div className='BlockPodbor'>
            <div className='Parametrs-text'>Параметры подбора</div>
            <div className='Parametrs'>
                <div className="ParametrsBlok1">
                <div>
                    <select onChange={e => setFilters({...filters, genre: e.target.value})} className="selectionPodbor">
                        <option value="">Все жанры</option>
                        <option value="Драма">Драма</option>
                        <option value="Комедия">Комедия</option>
                        <option value="Боевик">Боевик</option>
                        <option value="Ужасы">Ужасы</option>
                        <option value="Триллер">Триллер</option>
                        <option value="Детектив">Детектив</option>
                        <option value="Фантастика">Фантастика</option>
                        <option value="Фэнтези">Фэнтези</option>
                        <option value="Мультфильм">Мультфильм</option>
                        <option value="Семейный">Семейный</option>
                        <option value="Приключения">Приключения</option>
                        <option value="Психологический">Психологический</option>
                        <option value="Исторический">Исторический</option>
                        <option value="Музыкальный">Музыкальный</option>
                        <option value="Вестерн">Вестерн</option>
                        <option value="Криминал">Криминал</option>
                        <option value="Военный">Военный</option>
                        <option value="Биографический">Биографический</option>
                        <option value="Мистический">Мистический</option>
                    </select>
                </div>
                <div>
                        <input
                        className="YearParametr"
                        type="number"
                        placeholder="Год от"
                        onChange={e => setFilters({...filters, yearFrom: e.target.value})}
                        />
                    </div>
                    <div>
                        <input
                        className="YearParametr"
                        type="number"
                        placeholder="Год до"
                        onChange={e => setFilters({...filters, yearTo: e.target.value})}
                        />
                    </div>
                </div>
                <div>
                    <input
                    className="DurationParametr"
                    type="number"
                    placeholder="Длительность от (мин)"
                    onChange={e => setFilters({...filters, durationFrom: e.target.value})}
                    />  

                    <input
                    className="DurationParametr"
                    type="number"
                    placeholder="Длительность до (мин)"
                    onChange={e => setFilters({...filters, durationTo: e.target.value})}
                    />
                </div>
                <div className="ParametrsBlok2">
                    <button className="ButtonParametr" onClick={() => {
                    const film = getRandomFilm();
                    if (film) navigate(`/movie/${film.id}`);
                    }}>
                    Подобрать фильм
                    </button>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default MovieSelection;