const express = require('express');
const router = express.Router();
const filmController = require('../controllers/filmController');

router.get('/', filmController.getFilms);
router.post('/', filmController.createFilm);

module.exports = router;
