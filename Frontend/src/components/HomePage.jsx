import SideBar from './SideBar';
import gosling from '../assets/gosling2.jpg';
import cel_pauk from '../assets/2.jpg';
import doc_strange from '../assets/3.jpg';
import chudo from '../assets/4.jpg';
import zel_slon from '../assets/5.jpg';
import MovieCard from "../components/MovieCard";
import React, { useState, useEffect } from "react";
import { Autoplay, Navigation, Pagination, Scrollbar } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import { useRef } from 'react';
import { Link } from "react-router-dom";
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';
import '../App.css';



function HomePage(){
  const prevRef = useRef(null);
  const nextRef = useRef(null);

    const [films, setFilms] = useState([])
    React.useEffect(() => {
      fetch("http://localhost:3000/films/")
      .then((res) => res.json())
      .then((data) => setFilms(data));
    }, []);

    return(
      <>
              <div className='Container2'>
                <div className='Container3'>
                  <div className='Container4-Home'>
                   <SideBar/>
                  </div>
                  <div className='Container5'>
                    <div className='Container6'>
                      <div className='novinkiText'>Новинки кино!</div>
                      <Swiper 
                        className='swiper-novinki'
                        loop={true} 
                        modules={[Autoplay, Scrollbar]} 
                        autoplay={{
                          delay: 5000, 
                          disableOnInteraction: false}} 
                        scrollbar={{
                          draggable: true}} 
                        slidesPerView={1}
                        spaceBetween={20}
                        >
                        <SwiperSlide className='swiper-slide-novinki'>
                          <Link to={`/movie/52`} className="link-reset">
                            <button className="novinki-card">
                              <div className="novinki-image">
                                <img src={gosling} className="gosling" />
                              </div>
                              <div className="jenres-btn">Драйв</div>
                            </button>
                          </Link>
                        </SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'>                          
                          <Link to={`/movie/31`} className="link-reset">
                            <button className="novinki-card">
                              <div className="novinki-image">
                                <img src={cel_pauk} className="gosling" />
                              </div>
                              <div className="jenres-btn">Человек-паук: Нет пути домой</div>
                            </button>
                          </Link>
                        </SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'>                          
                          <Link to={`/movie/36`} className="link-reset">
                            <button className="novinki-card">
                              <div className="novinki-image">
                                <img src={doc_strange} className="gosling" />
                              </div>
                              <div className="jenres-btn">Доктор Стрэндж: В мультивселенной безумия</div>
                            </button>
                          </Link>
                        </SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'>                          
                          <Link to={`/movie/38`} className="link-reset">
                            <button className="novinki-card">
                              <div className="novinki-image">
                                <img src={chudo} className="gosling" />
                              </div>
                              <div className="jenres-btn">Чудо-женщина 1984</div>
                            </button>
                          </Link>
                        </SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'>
                          <Link to={`/movie/51`} className="link-reset">
                            <button className="novinki-card">
                              <div className="novinki-image">
                                <img src={zel_slon} className="gosling" />
                              </div>
                              <div className="jenres-btn">Зелёный слоник</div>
                            </button>
                          </Link>
                        </SwiperSlide>
                      </Swiper>
                      <div className='jenresText'>Популярные жанры</div>
                      <div className='jenre'>
                        <div ref={prevRef} className="swiper-button-prev"></div>
                        <div ref={nextRef} className="swiper-button-next"></div>
                        <Swiper
                          className='swiper-jenre'
                          loop={true}
                          modules={[Navigation]}
                          onBeforeInit={(swiper) => {
                            swiper.params.navigation.prevEl = prevRef.current;
                            swiper.params.navigation.nextEl = nextRef.current;
                          }}
                          
                          slidesPerView={4}
                          spaceBetween={20}
                        >
                          <SwiperSlide><button type="submit" className="jenres-btn">Ужасы</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Драма</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Боевик</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Детектив</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Мультфильм</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Фантастика</button></SwiperSlide>
                        </Swiper>
                      </div>
                      <div className='jenresText'>Популярное</div>
                        <Swiper
                        className='Populashion'
                        loop={true}
                        modules={[Autoplay]} 
                        autoplay={{
                          delay: 5000, 
                          disableOnInteraction: false}}
                        slidesPerView={3}
                        spaceBetween={40} 
                        >
                        {films.map(movie => (
                          <SwiperSlide><MovieCard key={movie.id} movie={movie}/></SwiperSlide>
                        ))}
                        </Swiper>



                    </div>
                  

                  </div>
                </div>
              </div>

                    
      </>
    );
};
export default HomePage;