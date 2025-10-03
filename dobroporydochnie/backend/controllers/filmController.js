const filmService = require('../services/filmService');

async function getFilms(req, res, next) {
  try {
    const films = await filmService.listFilms();
    res.json(films);
  } catch (err) {
    next(err);
  }
}

async function createFilm(req, res, next) {
  try {
    const newFilm = await filmService.createFilm(req.body);
    res.status(201).json(newFilm);
  } catch (err) {
    next(err);
  }
}

module.exports = { getFilms, createFilm };
