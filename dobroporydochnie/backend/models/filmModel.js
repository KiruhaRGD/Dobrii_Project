const db = require('../config/database');

async function getAllFilms() {
    const result = await db.query('SELECT * FROM film');
    return result.rows;
}

async function addFilm(filmData) {
    const { name, date_release } = filmData;
    const result = await db.query(
        'INSERT INTO film (name, date_release) VALUES ($1, $2) RETURNING *',
        [name, date_release]
    );
    return result.rows[0];
}

async function deleteFilm(filmData) {
    const { id } = filmData;
    const result = await db.query('DELETE FROM film WHERE id = $1 RETURNING *', 
        [id]
    );
    return result.rows[0];
}

async function updateFilm(filmData) {
    const { id, name, date_release } = filmData;
    const result = await db.query('UPDATE film SET name = $1, date_release = $2 WHERE id = $3 RETURNING *', 
        [name, date_release, id]
    );
    return result.rows[0];
}

async function getFilm(filmData) {
    const { id } = filmData;
    const result = await db.query('SELECT * FROM film WHERE id = $1',
        [id]
    );
    return result.rows[0];
}

module.exports = { 
    getAllFilms, 
    addFilm, 
    deleteFilm, 
    updateFilm, 
    getFilm,
};