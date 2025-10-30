import { useState } from 'react'
import './App.css'
import kinologo from './kino.png'
import zakl from './zakl.png'
import p from './p.png'
import found from './found.png'
function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      
        <header>
        <div className='Container'>
          <button className='MainButton'>电影 ЧинаПоиск |</button>
       
           <img src={kinologo} alt='image sdox' className='kino'/>
          <button className='MainButton'>Подбор фильма |</button>  
            <img src={zakl} alt='image sdox' className='kino'/>
             <button className='MainButton'>Закладки</button> 
            <input type="" id="" name="" className='input1'/>
             <img src={p} alt='image sdox' className='kino'/>
            <button className='MainButton'>Вход</button> 
             <img src={found} alt='image sdox' className='kino2'/>
          </div>
      </header>
      <body>
        <div className='Container2'>
             <div className='Container3'>
                <div className='Container4'></div>
             </div>
        </div>
      </body>
    </>
  )
}

export default App
