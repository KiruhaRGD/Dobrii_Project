const express = require('express');
const router = express.Router();
const filmController = require('../controllers/filmController');
const { authenticateToken } = require('../middlewares/auth');

router.get('/', filmController.getFilms);
router.post('/', filmController.createFilm);
router.get('/:id', filmController.getFilmById);
router.put('/:id', filmController.updateFilm);
router.delete('/:id', filmController.deleteFilm);

// 1. Получить все фильмы с информацией об избранном
router.get('/with-favorites', authenticateToken, filmController.getFilmsWithFavorites);

// 2. Получить фильм с информацией об избранном
router.get('/:id/with-favorite', authenticateToken, filmController.getFilmWithFavorite);

module.exports = router;