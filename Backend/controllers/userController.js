const jwt = require('jsonwebtoken');
const userModel = require('../models/userModel');

// Получить всех пользователей
async function getUsers(req, res) {
    try {
        const users = await userModel.getAllUsers();

        const clean = users.map(u => {
            const { password, ...rest } = u;
            return rest;
        });

        res.json(clean);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Создать пользователя
async function createUser(req, res) {
    try {
        const { nickname, password } = req.body;

        if (!nickname || !password) {
            return res.status(400).json({ error: "nickname and password are required" });
        }

        const success = await userModel.addUserDB(nickname, password);

        if (!success) {
            return res.status(400).json({ error: "User already exists" });
        }

        const createdUser = await userModel.getUserByNickname(nickname);

        const { password: _, ...clean } = createdUser;

        res.status(201).json(clean);

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить пользователя по ID
async function getUserById(req, res) {
    try {
        const { id } = req.params;

        const user = await userModel.getUserById(id);
        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        const { password, ...clean } = user;
        res.json(clean);

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Обновить пользователя
async function updateUser(req, res) {
    try {
        const { id } = req.params;
        const { nickname, password, access_rights } = req.body;

        const updated = await userModel.updateUser({
            id,
            nickname,
            password,
            access_rights
        });

        if (!updated) {
            return res.status(404).json({ error: "User not found" });
        }

        const { password: _, ...clean } = updated;
        res.json(clean);

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Удалить пользователя по ID
async function deleteUser(req, res) {
    try {
        const { id } = req.params;

        const deleted = await userModel.deleteUser(id);
        if (!deleted) {
            return res.status(404).json({ error: "User not found" });
        }

        const { password: _, ...clean } = deleted;

        res.json({
            message: "User deleted",
            user: clean
        });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

async function loginUser(req, res) {
    try {
        const { nickname, password } = req.body;

        if (!nickname || !password) {
            return res.status(400).json({
                error: "nickname and password are required"
            });
        }

        const isValid = await userModel.verifyPasswordDB(nickname, password);

        if (!isValid) {
            return res.status(401).json({
                error: "Invalid nickname or password"
            });
        }

        const user = await userModel.getUserByNickname(nickname);
        const { password: _, ...userWithoutPassword } = user;

        // 🔥 СОЗДАЕМ JWT ТОКЕН
        const token = jwt.sign({
                userId: user.id,
                nickname: user.nickname,
                access_rights: user.access_rights
            },
            process.env.JWT_SECRET, { expiresIn: '24h' } // Токен на 24 часа
        );

        res.json({
            success: true,
            message: "Login successful",
            token: token, // ← ОТПРАВЛЯЕМ ТОКЕН
            user: userWithoutPassword
        });

    } catch (err) {
        res.status(500).json({
            error: "Server error during login"
        });
    }
}

module.exports = {
    getUsers,
    createUser,
    getUserById,
    updateUser,
    deleteUser,
    loginUser
};