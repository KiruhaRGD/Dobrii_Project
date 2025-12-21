import SideBar from './SideBar';
import gosling from '../assets/gosling2.jpg';
import { Autoplay, Navigation, Pagination, Scrollbar } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';
import '../App.css';

function HomePage(){
    return(
      <>
              <div className='Container2'>
                <div className='Container3'>
                  <div className='Container4'>
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
                        <SwiperSlide className='swiper-slide'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
                        <SwiperSlide className='swiper-slide'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
                        <SwiperSlide className='swiper-slide'><img src={gosling} alt='image sdox' className='gosling'/></SwiperSlide>
                      </Swiper>
                      <div className='jenresText'>Популярные жанры</div>
                      <Swiper
                        className='swiper-jenre' 
                        loop={true} 
                        modules={[Autoplay, Scrollbar]} 
                        autoplay={{
                          delay: 12000, 
                          disableOnInteraction: false}} 
                        slidesPerView={4}
                        spaceBetween={20}
                        >
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">Ужасы</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">Драма</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">Боевик</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">Детектив</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">Мультфильм</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">2</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">3</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">4</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">5</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">6</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">7</button></SwiperSlide>
                        <SwiperSlide className='swiper-slide-jenre'><button type="submit" className="jenres-btn">8</button></SwiperSlide>
                      </Swiper>
                    </div>
                  

                  </div>
                </div>
              </div>

                    
      </>
    );
};
export default HomePage;