// Обработчик всех ошибок
function errorHandler(err, req, res, next) {
    console.error('Ошибка сервера:', err);

    res.status(500).json({
        error: process.env.NODE_ENV === 'development' ?
            err.message : 'Internal server error'
    });
}

module.exports = errorHandler;