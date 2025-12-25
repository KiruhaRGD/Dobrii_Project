const express = require('express');
const router = express.Router();
const filmController = require('../controllers/filmController');
const { authenticateToken } = require('../middlewares/auth');

// Основные маршруты
router.get('/', filmController.getFilms);
router.post('/', filmController.createFilm);
router.get('/:id', filmController.getFilmById);
router.put('/:id', filmController.updateFilm);
router.delete('/:id', filmController.deleteFilm);

// Альтернативные маршруты
router.get('/with-details', filmController.getFilmsWithDetails);
router.get('/:id/details', filmController.getFilmWithDetails);
router.get('/:id/with-comments', filmController.getFilmWithComments);

// Маршруты с авторизацией
router.get('/with-favorites', authenticateToken, filmController.getFilmsWithFavorites);
router.get('/:id/with-favorite', authenticateToken, filmController.getFilmWithFavorite);
router.get('/:id/full', authenticateToken, filmController.getFilmWithFavoriteAndComments);

module.exports = router;