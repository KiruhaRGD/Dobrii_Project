const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Основные CRUD операции
router.get('/', userController.getUsers);                      // GET /users
router.post('/', userController.createUser);                   // POST /users
router.get('/:id', userController.getUserById);                // GET /users/:id
router.put('/', userController.updateUser);                    // PUT /users (обновление по паролю)
router.delete('/', userController.deleteUser);                 // DELETE /users (удаление по учетным данным)

module.exports = router;