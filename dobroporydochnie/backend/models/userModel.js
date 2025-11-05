const db = require('../config/database');

// Получить всех пользователей
async function getAllUsers() {
    const result = await db.query('SELECT * FROM users');
    return result.rows;
}

// Создать пользователя
async function addUser(userData) {
    const { nickname, password} = userData;
    const result = await db.query(
        'INSERT INTO users (nickname, password) VALUES ($1, $2) RETURNING *',
        [nickname, password]
    );
    return result.rows[0];
}

// Удалить пользователя
async function deleteUser(userData) {
    const { id } = userData;
    const result = await db.query('DELETE FROM users WHERE id = $1 RETURNING *', 
        [id]
    );
    return result.rows[0];
}

async function updateUser(userData) {
    const { nickname, password } = userData;
    const result = await db.query('UPDATE users SET nickname = $1, WHERE password = $2 RETURNING *', 
        [nickname, password]
    );
    return result.rows[0];
}

// Получить пользователя по ID
async function getUser(userData) {
    const { id } = userData;
    const result = await db.query('SELECT * FROM users WHERE id = $1',
        [id]
    );
    return result.rows[0];
}

module.exports = { 
    getAllUsers, 
    addUser, 
    deleteUser, 
    updateUser, 
    getUser
};