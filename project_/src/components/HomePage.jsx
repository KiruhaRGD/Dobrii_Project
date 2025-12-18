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
                      
                    </div>
                  

                  </div>
                </div>
              </div>

                    
      </>
    );
};
export default HomePage;