const filmService = require('../services/filmService');

async function getFilms(req, res, next) {
  try {
    const films = await filmService.listFilms();
    res.json(films);
  } catch (err) {
    next(err);
  }
}

async function getFilmById(req, res, next) {
  try {
    const film = await filmService.getFilmById(req.params.id);
    if (!film) {
      return res.status(404).json({ error: 'Film not found' });
    }
    res.json(film);
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

async function updateFilm(req, res, next) {
  try {
    const updatedFilm = await filmService.updateFilm(req.params.id, req.body);
    if (!updatedFilm) {
      return res.status(404).json({ error: 'Film not found' });
    }
    res.json(updatedFilm);
  } catch (err) {
    next(err);
  }
}


async function deleteFilm(req, res, next) {
  try {
    const deletedFilm = await filmService.deleteFilm(req.params.id);
    if (!deletedFilm) {
      return res.status(404).json({ error: 'Film not found' });
    }
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}



module.exports = {
  getFilms,
  getFilmById,
  createFilm,
  updateFilm,
  deleteFilm,
};