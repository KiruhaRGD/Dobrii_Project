const db = require('../config/database');

async function getAllFilms() {
    const result = await db.query('SELECT * FROM film');
    return result.rows;
}

async function addFilm(filmData) {
    const {
        name,
        review_critique,
        duration,
        synopsis,
        date_release,
        picture
    } = filmData;

    // Выводим параметры в консоль
    console.log('Параметры для добавления фильма:', { name, review_critique, duration, synopsis, date_release, picture });

    const result = await db.query(
        `INSERT INTO film 
        (name, review_critique, duration, synopsis, date_release, picture)
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING *`, [name, review_critique, duration, synopsis, date_release, picture]
    );

    return result.rows[0];
}


async function deleteFilm(filmData) {
    const { id } = filmData;
    const result = await db.query('DELETE FROM film WHERE id = $1 RETURNING *', [id]);
    return result.rows[0];
}

async function updateFilm(filmData) {
    const { id, name, review_critique, duration, synopsis, date_release, picture } = filmData;

    const result = await db.query(
        `UPDATE film 
        SET name = $1,
            review_critique = $2,
            duration = $3,
            synopsis = $4,
            date_release = $5,
            picture = $6
        WHERE id = $7
        RETURNING *`, [name, review_critique, duration, synopsis, date_release, picture, id]
    );

    return result.rows[0];
}

async function getFilm(filmData) {
    const { id } = filmData;
    const result = await db.query('SELECT * FROM film WHERE id = $1', [id]);
    return result.rows[0];
}

module.exports = {
    getAllFilms,
    addFilm,
    deleteFilm,
    updateFilm,
    getFilm,
};