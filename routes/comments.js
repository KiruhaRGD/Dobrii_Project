const express = require('express');
const router = express.Router();
const commentController = require('../controllers/commentController');
const { authenticateToken } = require('../middlewares/auth');

// Комментарии для фильма (публичные)
router.get('/film/:filmId', commentController.getFilmComments);

// Комментарии текущего пользователя (требуется авторизация)
router.get('/my-comments', authenticateToken, commentController.getUserComments);

// Получить конкретный комментарий
router.get('/:id', commentController.getComment);

// CRUD операции (требуется авторизация)
router.post('/', authenticateToken, commentController.createComment);
router.put('/:id', authenticateToken, commentController.updateComment);
router.delete('/:id', authenticateToken, commentController.deleteComment);

module.exports = router;