const db = require('../config/database');

// Получить всех пользователей
async function getAllUsers() {
    const result = await db.query('SELECT * FROM users');
    return result.rows;
}

// Добавить пользователя (используем функцию из БД)
async function addUserDB(nickname, password) {
    try {
        // Вызываем PostgreSQL функцию add_user
        const result = await db.query(
            'SELECT add_user($1, $2) as success', [nickname, password]
        );

        // Функция возвращает boolean
        return result.rows[0].success;
    } catch (err) {
        console.error('Ошибка при вызове add_user:', err);
        return false;
    }
}

// Получить пользователя по ID
async function getUserById(id) {
    const result = await db.query('SELECT * FROM users WHERE id = $1', [id]);
    return result.rows[0];
}

// Получить пользователя по nickname
async function getUserByNickname(nickname) {
    const result = await db.query('SELECT * FROM users WHERE nickname = $1', [nickname]);
    return result.rows[0];
}

// Обновить пользователя
async function updateUser(userData) {
    const { id, nickname, password, access_rights } = userData;

    // Если передан новый пароль - хешируем его
    let passwordUpdate = '';
    let params = [];

    if (password) {
        passwordUpdate = ', password = crypt($2, gen_salt(\'md5\'))';
        params = [nickname, password, access_rights, id];
    } else {
        params = [nickname, access_rights, id];
    }

    const query = `
        UPDATE users 
        SET nickname = $1, 
            access_rights = $2${passwordUpdate ? passwordUpdate : ''}
        WHERE id = $${params.length}
        RETURNING *
    `;

    const result = await db.query(query, params);
    return result.rows[0];
}

// Удалить пользователя
async function deleteUser(id) {
    const result = await db.query('DELETE FROM users WHERE id = $1 RETURNING *', [id]);
    return result.rows[0];
}

// Проверить пароль (функция тоже есть в БД)
async function verifyPassword(nickname, password) {
    const result = await db.query(
        'SELECT verify_password($1, $2) as is_valid', [nickname, password]
    );
    return result.rows[0].is_valid;
}

//проверка пароля
async function verifyPasswordDB(nickname, password) {
    try {
        const result = await db.query(
            'SELECT verify_password($1, $2) as is_valid', [nickname, password]
        );
        return result.rows[0].is_valid;
    } catch (err) {
        console.error('Ошибка при проверке пароля:', err);
        return false;
    }
}

module.exports = {
    getAllUsers,
    addUserDB,
    getUserById,
    getUserByNickname,
    updateUser,
    deleteUser,
    verifyPassword,
    verifyPasswordDB
};