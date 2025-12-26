import remont from '../assets/remont.jpg';
import '../App.css';
import gosling from '../assets/gosling.jpg';
function Profile(){
    
    return(
        <>
            <div className='Container2'>
                <div className='Container3'>
                        <div className='profileCon'>
                             <img src={gosling} alt='image sdox' className='gosling52'/>
                            <div> Добропорядочный генадий</div>
                         <div> Фильмов посмотрено:67</div>  
                          <div>на сайте с 11.11.2011</div>  
                    </div>
                    <div className='profileCon2'>
                        <div>Любимые фильмы</div>  
                        <img src={remont} className="remont" />
                        <div className="movieName">Тут идёт ремонт...</div>
                    </div>
                     <div className='profileCon3'>Любимые жанры 
                        
                        <div> 1. Комедия</div>
                       
                        <div> 2. Драма</div>
                        
                        <div> 3. Хоррор</div>
                       
                        <div> 4. Боевики</div>
                        
                        <div> 5. Триллер</div></div> 
                </div>
            </div>
        </>
    );
};
export default Profile;