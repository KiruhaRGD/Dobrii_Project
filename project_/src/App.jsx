import { useState, useEffect } from 'react'
import './App.css'
import Header from './components/Header.jsx'
import Home from './components/Home.jsx'
import Sidebar from './components/Sidebar.jsx'
import AboutUs from './components/AboutUs.jsx'
import { BrowserRouter as Router, Routes, Route, Link, BrowserRouter } from 'react-router-dom';

function App() {
  const [darkMode, setDarkMode] = useState(false)

  useEffect(() => {
    document.body.className = darkMode ? "dark-theme" : "light-theme";
  },[darkMode]);

    
  return (
    <>
    <Header/>
      <BrowserRouter>
        <Routes>
          <Route path='/home' element={<Home/>}/>
          <Route path='/aboutUs' element={<AboutUs/>}/>
        </Routes>
      </BrowserRouter>
    </>
  )
}

export default App
