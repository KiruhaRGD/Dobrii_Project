import SideBar from './SideBar';
import gosling from '../assets/gosling2.jpg';
import { Autoplay, Navigation, Pagination, Scrollbar } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import { useRef } from 'react';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';
import '../App.css';



function HomePage(){
  const prevRef = useRef(null);
  const nextRef = useRef(null);
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
                        <SwiperSlide className='swiper-slide-novinki'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
                        <SwiperSlide className='swiper-slide-novinki'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
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
                          <SwiperSlide><button type="submit" className="jenres-btn">Народное</button></SwiperSlide>
                          <SwiperSlide><button type="submit" className="jenres-btn">Комедия</button></SwiperSlide>
                        </Swiper>
                        
                      </div>



                    </div>
                  

                  </div>
                </div>
              </div>

                    
      </>
    );
};
export default HomePage;