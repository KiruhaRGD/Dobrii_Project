import { useState, useEffect } from 'react'
import './App.css'
import kinologo from './kino.png'
import zakl from './zakl.png'
import p from './p.png'
import found from './found.png'
import Logo from './Logo.png'
import InYan from './inyan.png'
import stena from './stena.png'
import glavnaya from './glavnaya.png'
import podbor from './podbor.png'
import zakladki from './zakladki.png'
import Filmi from './Filmi.png'
import Seriali from './Seriali.png'

function App() {
  const [darkMode, setDarkMode] = useState(false)

  useEffect(() => {
    document.body.className = darkMode ? "dark-theme" : "light-theme";
  },[darkMode]);

    
  return (
    <>
      
        <header>
        <div className='Container'>

          <button className='Logo'> <img src={Logo} alt='image sdox' className='Logo-img'/>ЧинаПоиск </button>
          <img src={stena} alt='image sdox' className='stena'/>
          <button className='MainButton'> <img src={kinologo} alt='image sdox' className='kino'/>Подбор фильма </button>  
          <img src={stena} alt='image sdox' className='stena'/>
          <button className='MainButton'> <img src={zakl} alt='image sdox' className='kino'/>Закладки</button> 
          <div className='search-container'>
          <input type="text" placeholder="Поиск фильмов..." className='search-input' />
            <button className='search-button'>
              <img src={found} alt="Поиск" className='search-icon' />
            </button>
          </div>
          <button className='MainButton'><img src={p} alt='image sdox' className='kino'/>Вход</button> 
          <button className={`theme-toggle ${darkMode ? 'rotated' : ''}`}onClick={() => setDarkMode(!darkMode)}>
          <img src={InYan} alt="image sdox" className="InYan" />
          </button>       
        </div>
        </header>

      <body>
        <div className='Container2'>
             <div className='Container3'>
                <div className='Container4'>
                  <button className='LeftButton'> <img src={glavnaya} alt='image sdox' className='kino'/>Главная </button>
                  <button className='LeftButton'> <img src={podbor} alt='image sdox' className='kino'/>Подбор фильма </button>
                  <button className='LeftButton'> <img src={zakladki} alt='image sdox' className='kino'/>Закладки </button>
                  <button className='LeftButton'> <img src={Filmi} alt='image sdox' className='kino'/>Фильмы </button>
                  <button className='LeftButton'> <img src={Seriali} alt='image sdox' className='kino'/>Сериалы </button>
                </div>
                <div className='Container5'>
                  <div className='novinkiText'>Новинки кино!</div>
                  <div className='sliderNovinki'></div>
        

                </div>
             </div>
        </div>
      </body>
    </>
  )
}

export default App
