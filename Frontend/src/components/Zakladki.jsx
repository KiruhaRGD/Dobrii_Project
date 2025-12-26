import remont from '../assets/remont.jpg';
import '../App.css';

function Zakladki(){
    return(
        <>
           <div className='Container22'>
                <div className='Container33'>
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
                    <img src={remont} className="remont" />
                    <div className="movieName">Тут идёт ремонт...</div>
                </div>
            </div>
        </>
    );
};
export default Zakladki;