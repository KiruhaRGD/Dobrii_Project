    import kinologo from '../assets/kino.png'
    import zakl from '../assets/zakl.png'
    import p from '../assets/p.png'
    import found from '../assets/found.png'
    import Logo from '../assets/Logo.png'
    import InYan from '../assets/inyan.png'
    import stena from '../assets/stena.png'

    
    function Header(){
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
    }
    export default Header   