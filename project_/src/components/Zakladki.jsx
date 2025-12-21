import '../App.css';

function Zakladki(){
    return(
        <>
          <div className='zakladki'>
            <div className='hi'>Фильтровать по жанру 
              <div class="dropdown-container">
            <select id="genre" name="genre">
            <option value="" disabled selected>Выберите жанр</option>
            <option value="all">Все жанры</option>
            <option value="action">Боевик</option>
            <option value="comedy">Комедия</option>
            <option value="drama">Драма</option>
            <option value="fantasy">Фэнтези</option>
            <option value="horror">Ужасы</option>
            <option value="romance">Мелодрама</option>
            <option value="scifi">Фантастика</option>
            <option value="thriller">Триллер</option>
            </select>
              </div>
            </div>
          </div>
        </>
    );
};
export default Zakladki;