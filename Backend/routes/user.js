const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Основные CRUD операции
router.get('/', userController.getUsers);
router.post('/', userController.createUser);
router.get('/:id', userController.getUserById);
router.put('/:id', userController.updateUser);
router.delete('/:id', userController.deleteUser);

// Маршрут для входа
router.post('/login', userController.loginUser);

module.exports = router;