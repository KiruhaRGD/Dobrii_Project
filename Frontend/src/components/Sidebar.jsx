
import podbor from '../assets/podbor.png';
import zakladki from '../assets/zakladki.png';
import Filmi from '../assets/Filmi.png';
import Seriali from '../assets/Seriali.png';
import { Link } from 'react-router-dom';
import '../App.css';
function SideBar(){
    return(
          <div className='Container4'>
          <Link to="movieselection">   <button className='LeftButton'> <img src={podbor} alt='image sdox' className='kino'/>Подбор фильма </button></Link>  
          <Link to="zakladki">   <button className='LeftButton'> <img src={zakladki} alt='image sdox' className='kino'/>Закладки </button></Link> 
          <Link to="movies">  <button className='LeftButton'> <img src={Filmi} alt='image sdox' className='kino'/>Фильмы </button></Link>
          <Link to="serials"> <button className='LeftButton'> <img src={Seriali} alt='image sdox' className='kino'/>Сериалы </button></Link>
          </div>
    );
};
export default SideBar;