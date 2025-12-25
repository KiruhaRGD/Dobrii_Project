const db = require('../config/database');

// Получить все комментарии для фильма
async function getCommentsByFilmId(filmId) {
    const query = `
        SELECT c.*, u.nickname 
        FROM comment c
        JOIN users u ON u.id = c.users_id
        WHERE c.film_id = $1
        ORDER BY c.id DESC
    `;

    const result = await db.query(query, [filmId]);
    return result.rows;
}

// Получить комментарий по ID
async function getCommentById(commentId) {
    const query = `
        SELECT c.*, u.nickname 
        FROM comment c
        JOIN users u ON u.id = c.users_id
        WHERE c.id = $1
    `;

    const result = await db.query(query, [commentId]);
    return result.rows[0];
}

// Создать новый комментарий
async function createComment(commentData) {
    const { users_id, film_id, comment } = commentData;

    if (!users_id || !film_id || !comment || comment.trim() === '') {
        throw new Error('Все поля обязательны для заполнения');
    }

    const query = `
        INSERT INTO comment (users_id, film_id, comment)
        VALUES ($1, $2, $3)
        RETURNING *
    `;

    const result = await db.query(query, [users_id, film_id, comment]);
    return result.rows[0];
}

// Обновить комментарий
async function updateComment(commentData) {
    const { id, comment, users_id } = commentData;

    if (!comment || comment.trim() === '') {
        throw new Error('Текст комментария не может быть пустым');
    }

    const query = `
        UPDATE comment 
        SET comment = $1
        WHERE id = $2 AND users_id = $3
        RETURNING *
    `;

    const result = await db.query(query, [comment, id, users_id]);
    return result.rows[0];
}

// Удалить комментарий
async function deleteComment(commentId, userId) {
    // Проверяем, существует ли комментарий и принадлежит ли пользователю
    const checkQuery = 'SELECT * FROM comment WHERE id = $1 AND users_id = $2';
    const checkResult = await db.query(checkQuery, [commentId, userId]);

    if (checkResult.rows.length === 0) {
        throw new Error('Комментарий не найден или у вас нет прав на его удаление');
    }

    const deleteQuery = 'DELETE FROM comment WHERE id = $1 RETURNING *';
    const result = await db.query(deleteQuery, [commentId]);
    return result.rows[0];
}

// Получить комментарии пользователя
async function getCommentsByUserId(userId) {
    const query = `
        SELECT c.*, f.name as film_name 
        FROM comment c
        JOIN film f ON f.id = c.film_id
        WHERE c.users_id = $1
        ORDER BY c.id DESC
    `;

    const result = await db.query(query, [userId]);
    return result.rows;
}

module.exports = {
    getCommentsByFilmId,
    getCommentById,
    createComment,
    updateComment,
    deleteComment,
    getCommentsByUserId
};