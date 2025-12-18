import '../App.css';
function Registration(){
    return(
        <>  
            <div className='RegistrationZone'>
                <div className="registration-form">
                    <h2>Регистрация</h2>
                    <form>
                        <div className="form-group">
                            <input 
                                type="email" 
                                placeholder="Введите email"
                            />
                        </div>
                        <div className="form-group">
                            <input 
                                type="password" 
                                placeholder="Введите пароль"
                            />
                        </div>
                        <button type="submit" className="register-btn">
                            Зарегистрироваться
                        </button>
                    </form>
                    <div className="login-link">
                        Уже есть аккаунт? <a href="/">Войти</a>
                    </div>
                </div>
            </div>
        </>
    );
};
export default Registration;