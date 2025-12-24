const db = require('../config/database');

// TOGGLE - добавить или удалить из избранного
async function toggleFavorite(userId, filmId) {
    try {
        // Сначала проверяем, есть ли уже в избранном
        const existing = await db.query(
            'SELECT * FROM favourites WHERE users_id = $1 AND film_id = $2', [userId, filmId]
        );

        if (existing.rows.length > 0) {
            // УДАЛЯЕМ (уже в избранном)
            const result = await db.query(
                'DELETE FROM favourites WHERE users_id = $1 AND film_id = $2 RETURNING *', [userId, filmId]
            );
            return {
                action: 'removed',
                favorite: result.rows[0]
            };
        } else {
            // ДОБАВЛЯЕМ (ещё нет в избранном)
            const result = await db.query(
                'INSERT INTO favourites (users_id, film_id) VALUES ($1, $2) RETURNING *', [userId, filmId]
            );
            return {
                action: 'added',
                favorite: result.rows[0]
            };
        }
    } catch (err) {
        throw err;
    }
}

// Проверить статус
async function getFavoriteStatus(userId, filmId) {
    const result = await db.query(
        'SELECT * FROM favourites WHERE users_id = $1 AND film_id = $2', [userId, filmId]
    );
    return result.rows.length > 0;
}

// Получить все избранные фильмы пользователя
async function getUserFavorites(userId) {
    const result = await db.query(
        `SELECT f.*, film.name, film.date_release, film.picture 
         FROM favourites f
         JOIN film ON f.film_id = film.id
         WHERE f.users_id = $1
         ORDER BY f.id DESC`, [userId]
    );
    return result.rows;
}

// Получить количество
async function getFavoritesCount(userId) {
    const result = await db.query(
        'SELECT COUNT(*) as count FROM favourites WHERE users_id = $1', [userId]
    );
    return parseInt(result.rows[0].count);
}

module.exports = {
    toggleFavorite,
    getFavoriteStatus,
    getUserFavorites,
    getFavoritesCount
};