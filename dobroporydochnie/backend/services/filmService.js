// // services/filmService.js - примерная структура
// let films = []; // Временное хранилище, замените на базу данных

// const filmService = {
//   async listFilms() {
//     return films;
//   },

//   async getFilmById(id) {
//     return films.find(film => film.id === id);
//   },

//   async createFilm(filmData) {
//     const newFilm = {
//       id: Date.now().toString(),
//       ...filmData,
//       createdAt: new Date(),
//       rating: 0,
//       reviews: []
//     };
//     films.push(newFilm);
//     return newFilm;
//   },

//   async updateFilm(id, filmData) {
//     const index = films.findIndex(film => film.id === id);
//     if (index === -1) return null;
    
//     films[index] = { ...films[index], ...filmData, updatedAt: new Date() };
//     return films[index];
//   },

//   async deleteFilm(id) {
//     const index = films.findIndex(film => film.id === id);
//     if (index === -1) return null;
    
//     return films.splice(index, 1)[0];
//   },

// }
// module.exports = filmService;

const filmModel = require('../models/filmModel');

async function listFilms() {
  return await filmModel.getAllFilms();
}

async function createFilm(filmData) {
  return await filmModel.addFilm(filmData);
}

async function getFilmById(id) {
  return await filmModel.getFilmById(id);
}

async function updateFilm(id, filmData) {
  return await filmModel.updateFilm(id, filmData);
}

async function deleteFilm(id) {
  return await filmModel.deleteFilm(id);
}

// Дополнительные функции
async function searchFilms(query) {
  const films = await filmModel.getAllFilms();
  return films.filter(film => 
    film.title.toLowerCase().includes(query.toLowerCase()) ||
    film.description.toLowerCase().includes(query.toLowerCase())
  );
}

async function getFilmsByGenre(genre) {
  const films = await filmModel.getAllFilms();
  return films.filter(film => 
    film.genre.toLowerCase() === genre.toLowerCase()
  );
}

module.exports = {
  listFilms,
  createFilm,
  getFilmById,
  updateFilm,
  deleteFilm,
  searchFilms,
  getFilmsByGenre
};