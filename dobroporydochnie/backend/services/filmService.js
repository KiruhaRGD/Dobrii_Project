const Film = require('../models/filmModel');

async function listFilms() {
  return await Film.getAllFilms();
}

async function createFilm(data) {
  const { title, year, genre } = data;
  return await Film.addFilm(title, year, genre);
}

module.exports = { listFilms, createFilm };
