const db = require('../config/database');


  async function getAllFilms() {
   const result = await db.query('SELECT * FROM film');
    return result.rows;
  }

  async function addFilm(title, year, genre) {
    const result = await db.query(
      'INSERT INTO film (title, year, genre) VALUES ($1, $2, $3) RETURNING *',
      [title, year, genre]
    );
    return result.rows[0];
  }

  async function deletefilms(id) {
    const result = await db.query('DELETE FROM film WHERE id = $1;', 
      [id]
    );
    return result.rows[0];
  }

  async function updatefilm(title, year, genre) {
    const result = await db.query('update film set (titlem, year, genre) = ($1, $2, $3);', 
      [title, year, genre]
    );
    return result.rows[0];
  }

  async function getFilm(id) {
    const result = await db.query('SELECT * FROM id = $1',
      [id]
    );
    return result.rows;
  }
module.exports = { getAllFilms, addFilm, deletefilms, updatefilm, getFilm };