const express = require('express');
const router = express.Router();
const filmController = require('../controllers/filmController');
const { authenticateToken } = require('../middlewares/auth');

// Основные маршруты
router.get('/', filmController.getFilms); // Теперь возвращает фильмы с деталями
router.post('/', filmController.createFilm);
router.get('/:id', filmController.getFilmById); // Теперь возвращает фильм с деталями
router.put('/:id', filmController.updateFilm);
router.delete('/:id', filmController.deleteFilm);

// Альтернативные маршруты для деталей (если нужно сохранить старый функционал)
router.get('/with-details', filmController.getFilmsWithDetails);
router.get('/:id/details', filmController.getFilmWithDetails);

// Маршруты с избранным
router.get('/with-favorites', authenticateToken, filmController.getFilmsWithFavorites);
router.get('/:id/with-favorite', authenticateToken, filmController.getFilmWithFavorite);

module.exports = router;