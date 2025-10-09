// const db = require('../config/database');
  

//   async function getAllFilms() {
//    const result = await db.query('SELECT * FROM film');
//     return result.rows;
//   }

//   async function addFilm(title, year, genre) {
//     const result = await db.query(
//       'INSERT INTO film (title, year, genre) VALUES ($1, $2, $3) RETURNING *',
//       [title, year, genre]
//     );
//     return result.rows[0];
//   }

//   async function deletefilms(id) {
//     const result = await db.query('DELETE FROM film WHERE id = $1;', 
//       [id]
//     );
//     return result.rows[0];
//   }

//   async function updatefilm(title, year, genre) {
//     const result = await db.query('update film set (titlem, year, genre) = ($1, $2, $3);', 
//       [title, year, genre]
//     );
//     return result.rows[0];
//   }

//   async function getFilm(id) {
//     const result = await db.query('SELECT * FROM id = $1',
//       [id]
//     );
//     return result.rows;
//   }
// module.exports = { getAllFilms, addFilm, deletefilms, updatefilm, getFilm };




// Временное хранилище в памяти
let films = [
  {
    id: "1",
    title: "The Matrix",
    year: 1999,
    genre: "Sci-Fi",
  },
  {
    id: "2", 
    title: "Interstellar",
    year: 2014,
    genre: "Sci-Fi",
  }
];

async function getAllFilms() {
  return films;
}

async function addFilm(filmData) {
  const newFilm = {
    id: (films.length + 1).toString(),
    title: filmData.title,
    year: parseInt(filmData.year),
    genre: filmData.genre,
  };
  
  films.push(newFilm);
  return newFilm;
}

async function deleteFilm(id) {
  const index = films.findIndex(film => film.id === id);
  if (index === -1) return null;
  
  return films.splice(index, 1)[0];
}

async function updateFilm(id, filmData) {
  const index = films.findIndex(film => film.id === id);
  if (index === -1) return null;
  
  films[index] = {
    ...films[index],
    ...filmData,
    updatedAt: new Date()
  };
  
  return films[index];
}

async function getFilmById(id) {
  return films.find(film => film.id === id) || null;
}

module.exports = { 
  getAllFilms, 
  addFilm, 
  deleteFilm, 
  updateFilm, 
  getFilmById 
};

