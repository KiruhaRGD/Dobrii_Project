const express = require('express');
const router = express.Router();
const filmController = require('../controllers/filmController');

// Основные CRUD операции
router.get('/', filmController.getFilms);
router.post('/', filmController.createFilm);
router.get('/:id', filmController.getFilmById);
router.put('/:id', filmController.updateFilm);
router.delete('/:id', filmController.deleteFilm);

module.exports = router;

