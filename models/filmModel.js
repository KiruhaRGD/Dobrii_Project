const db = require('../config/database');

async function getAllFilms() {
    const result = await db.query('SELECT * FROM film');
    return result.rows;
}

// НОВАЯ ФУНКЦИЯ: Получить все фильмы с жанрами, актёрами и режиссёрами
async function getAllFilmsWithDetails() {
    const query = `
        SELECT 
            f.*,
            ARRAY_AGG(DISTINCT g.genre) as genres,
            ARRAY_AGG(DISTINCT a.name || ' ' || a.surname) as actors,
            ARRAY_AGG(DISTINCT r.name || ' ' || r.surname) as regisseurs
        FROM film f
        LEFT JOIN genres gf ON gf.id_film = f.id
        LEFT JOIN genre g ON g.id = gf.id_genre
        LEFT JOIN actors af ON af.id_film = f.id
        LEFT JOIN actor a ON a.id = af.id_actor
        LEFT JOIN regisseurs rf ON rf.id_film = f.id
        LEFT JOIN regisseur r ON r.id = rf.id_regisseur
        GROUP BY f.id
        ORDER BY f.id
    `;

    const result = await db.query(query);

    // Обрабатываем массивы - удаляем null значения
    return result.rows.map(film => ({
        ...film,
        genres: film.genres ? film.genres.filter(g => g !== null) : [],
        actors: film.actors ? film.actors.filter(a => a !== null) : [],
        regisseurs: film.regisseurs ? film.regisseurs.filter(r => r !== null) : []
    }));
}

// НОВАЯ ФУНКЦИЯ: Получить один фильм с жанрами, актёрами и режиссёрами
async function getFilmWithDetails(filmData) {
    const { id } = filmData;

    const query = `
        SELECT 
            f.*,
            ARRAY_AGG(DISTINCT g.genre) as genres,
            ARRAY_AGG(DISTINCT a.name || ' ' || a.surname) as actors,
            ARRAY_AGG(DISTINCT r.name || ' ' || r.surname) as regisseurs
        FROM film f
        LEFT JOIN genres gf ON gf.id_film = f.id
        LEFT JOIN genre g ON g.id = gf.id_genre
        LEFT JOIN actors af ON af.id_film = f.id
        LEFT JOIN actor a ON a.id = af.id_actor
        LEFT JOIN regisseurs rf ON rf.id_film = f.id
        LEFT JOIN regisseur r ON r.id = rf.id_regisseur
        WHERE f.id = $1
        GROUP BY f.id
    `;

    const result = await db.query(query, [id]);

    if (result.rows.length === 0) {
        return null;
    }

    const film = result.rows[0];

    // Обрабатываем массивы - удаляем null значения
    return {
        ...film,
        genres: film.genres ? film.genres.filter(g => g !== null) : [],
        actors: film.actors ? film.actors.filter(a => a !== null) : [],
        regisseurs: film.regisseurs ? film.regisseurs.filter(r => r !== null) : []
    };
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
    getAllFilmsWithDetails, // НОВЫЙ ЭКСПОРТ
    getFilmWithDetails, // НОВЫЙ ЭКСПОРТ
    addFilm,
    deleteFilm,
    updateFilm,
    getFilm,
};