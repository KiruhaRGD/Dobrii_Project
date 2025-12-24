import kinologo from '../assets/kino.png';
import zakl from '../assets/zakl.png';
import p from '../assets/p.png';
import found from '../assets/found.png';
import Logo from '../assets/Logo.png';
import InYan from '../assets/inyan.png';
import stena from '../assets/stena.png';
import { Link } from 'react-router-dom';
import '../App.css';


const Header = ({ darkMode, setDarkMode }) => {
  return (
    <header>
      <div className='Container'>
         <Link to="/"> <button className='MainButton'> 
          <img src={Logo} alt='logo' className='Logo-img'/>ЧинаПоиск 
        </button></Link>
        <img src={stena} alt='divider' className='stena'/>
          
          <Link to="movieselection">
            <button className='MainButton'>  <img src={kinologo} alt='cinema' className='kino'/> Подбор фильма  </button> 
          </Link>
          
          <img src={stena} alt='divider' className='stena'/>
       <Link to="zakladki"> <button className='MainButton'> 
          <img src={zakl} alt='bookmarks' className='kino'/>Закладки
        </button> </Link>
        
        <div className='search-container'>
          <input type="text" placeholder="Поиск фильмов..." className='search-input' />
          <button className='search-button'>
            <img src={found} alt="Поиск" className='search-icon' />
          </button>
        </div>
         <Link to="/registration">
  <button className='MainButton'>
    <img src={p} alt='profile' className='kino'/>Вход
  </button>
</Link>
        <button className={`theme-toggle ${darkMode ? 'rotated' : ''}`} onClick={() => setDarkMode(!darkMode)}>
          <img src={InYan} alt="theme" className="InYan" />
        </button>       
      </div>
    </header>
  );
};

export default Header;