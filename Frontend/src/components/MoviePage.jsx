import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import remont from '../assets/remont.jpg';
import '../App.css';
import '../cssFiles/Movies.css';

function MoviePage() {
  const { id } = useParams();
  const [films, setFilms] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("http://localhost:3000/films/")
      .then(res => res.json())
      .then(data => {
        setFilms(data);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <h2>Загрузка...</h2>;

  const movie = films.find(m => String(m.id) === id);

  if (!movie) return <h2>Фильм не найден</h2>;

  return (
    <div className='Container2'>
      <div className='Container3'>
        <div className="MoviePage">
          <div className="movieName">{movie.name}</div>

          <div className="blok1">
            <div>
              <img src={movie.picture} alt={movie.name} />
            </div>

            <div className="blok2">
              <div>
                <div className="text">Описание:</div>
                {movie.detailed_description}
              </div>

              {movie.genres?.length > 0 && (
                <div>
                  <div className="text">Жанры:</div>
                  {movie.genres.map(g => g.name ?? g).join(", ")}
                </div>
              )}

              <div>
                <div className="text">Длительность:</div>
                {movie.duration} минут
              </div>

              {movie.date_release && (
                <div>
                  <div className="text">Дата выпуска:</div>
                  {new Date(movie.date_release).toLocaleDateString("ru-RU")}
                </div>
              )}

              {movie.regisseurs?.length > 0 && (
              <div>
                <div className="text">Режисёр:</div>
                {movie.regisseurs.map(r => r.name ?? r).join(", ")}
              </div>
              )}

              {movie.actors?.length > 0 && (
                <div>
                  <div className="text">В главных ролях:</div>
                  {movie.actors.join(", ")}
                </div>
              )}
            </div>
          </div>
          <div className="blok3">
              <div className="movieName">Комментарии</div>
              <img src={remont} className="remont" />
              <div className="movieName">Тут идёт ремонт...</div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default MoviePage;