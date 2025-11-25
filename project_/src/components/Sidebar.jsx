    import podbor from '../assets/podbor.png'
    import zakladki from '../assets/zakladki.png'
    import Filmi from '../assets/Filmi.png'
    import Seriali from '../assets/Seriali.png'
    import glavnaya from '../assets/glavnaya.png'
    import './App.css'

function Sidebar(){
    return(
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
    )
}
export default Sidebar;