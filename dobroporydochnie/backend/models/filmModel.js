const db = require('../config/database');

async function getAllFilms() {
  const result = await db.query('SELECT * FROM films');
  return result.rows;
}

async function addFilm(title, year, genre) {
  const result = await db.query(
    'INSERT INTO films (title, year, genre) VALUES ($1, $2, $3) RETURNING *',
    [title, year, genre]
  );
  return result.rows[0];
}

module.exports = { getAllFilms, addFilm };
