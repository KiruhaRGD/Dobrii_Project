import { useState, useEffect } from 'react'
import './App.css'
import Header from './components/Header';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './components/HomePage';
import Registration from './components/Registration';
import Zakladki from './components/Zakladki';
import MuvieSelection from './components/MovieSelection';
import Movies from './components/Movies';
import Serials from './components/Serials';
import Profile from './components/Profile';





function App() {
  const [darkMode, setDarkMode] = useState(false)

  useEffect(() => {
    document.body.className = darkMode ? "dark-theme" : "light-theme";
  },[darkMode]);

    
  return (
    <>
     <Router>
        <Header darkMode={darkMode} setDarkMode={setDarkMode} />
        <Routes>
          <Route path='serials' element={<Serials/>}/>
          <Route path='movies' element={<Movies/>}/>
          <Route path='movieselection' element={<MuvieSelection/>}/>
          <Route path="/zakladki" element={<Zakladki/>}/>
          <Route path="/registration" element={<Registration/>}/>
          <Route path="/" element={<HomePage/>} />
          <Route path='/profile' element={<Profile/>} />
        </Routes>
    </Router>
    </>
  )
}

export default App
