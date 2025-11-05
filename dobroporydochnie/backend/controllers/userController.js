const userModel = require('../models/userModel');

// Получить всех пользователей
async function getUsers(req, res) {
    try {
        const users = await userModel.getAllUsers();
        res.json(users);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Создать пользователя
async function createUser(req, res) {
    try {
        const { username, password } = req.body;
      
        
        const newUser = await userModel.addUser({ username, password });
        
        // Не возвращаем пароль в ответе
        const { password: _, ...userWithoutPassword } = newUser;
        
        res.status(201).json(userWithoutPassword);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить пользователя по ID
async function getUserById(req, res) {
    try {
        const id = req.params.id;
        const user = await userModel.getUser({ id });
        
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }
        
        // Не возвращаем пароль в ответе
        const { password, ...userWithoutPassword } = user;
        
        res.json(userWithoutPassword);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Обновить пользователя по паролю (ВАША ВЕРСИЯ)
async function updateUser(req, res) {
    try {
        const { username, password } = req.body;
        
        const updatedUser = await userModel.updateUser({ username, password });
        
        if (!updatedUser) {
            return res.status(404).json({ error: 'User not found' });
        }
        
        // Не возвращаем пароль в ответе
        const { password: _, ...userWithoutPassword } = updatedUser;
        
        res.json(userWithoutPassword);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Удалить пользователя по учетным данным
async function deleteUser(req, res) {
    try {
        const { username, email, password } = req.body;
        
        const deletedUser = await userModel.deleteUser({ username, email, password });
        
        if (!deletedUser) {
            return res.status(404).json({ error: 'User not found with provided credentials' });
        }
        
        // Не возвращаем пароль в ответе
        const { password: _, ...userWithoutPassword } = deletedUser;
        
        res.json({ 
            message: 'User deleted successfully', 
            user: userWithoutPassword 
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}



module.exports = {
    getUsers,
    createUser,
    getUserById,
    updateUser,
    deleteUser
};