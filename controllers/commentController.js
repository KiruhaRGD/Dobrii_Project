const commentModel = require('../models/commentModel');

// Получить все комментарии для фильма
async function getFilmComments(req, res) {
    try {
        const filmId = req.params.filmId;
        const comments = await commentModel.getCommentsByFilmId(filmId);
        res.json(comments);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Создать новый комментарий
async function createComment(req, res) {
    try {
        const { film_id, comment } = req.body;
        const users_id = req.user.userId; // Из JWT токена

        if (!film_id || !comment) {
            return res.status(400).json({ error: 'film_id и comment обязательны' });
        }

        const newComment = await commentModel.createComment({
            users_id,
            film_id,
            comment
        });

        res.status(201).json(newComment);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Обновить комментарий
async function updateComment(req, res) {
    try {
        const commentId = req.params.id;
        const { comment } = req.body;
        const users_id = req.user.userId;

        if (!comment) {
            return res.status(400).json({ error: 'Текст комментария обязателен' });
        }

        const updatedComment = await commentModel.updateComment({
            id: commentId,
            comment,
            users_id
        });

        if (!updatedComment) {
            return res.status(404).json({ error: 'Комментарий не найден или у вас нет прав на его изменение' });
        }

        res.json(updatedComment);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Удалить комментарий
async function deleteComment(req, res) {
    try {
        const commentId = req.params.id;
        const users_id = req.user.userId;

        const deletedComment = await commentModel.deleteComment(commentId, users_id);

        if (!deletedComment) {
            return res.status(404).json({ error: 'Комментарий не найден' });
        }

        res.json({
            message: 'Комментарий успешно удалён',
            comment: deletedComment
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить комментарии текущего пользователя
async function getUserComments(req, res) {
    try {
        const users_id = req.user.userId;
        const comments = await commentModel.getCommentsByUserId(users_id);
        res.json(comments);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить один комментарий по ID
async function getComment(req, res) {
    try {
        const commentId = req.params.id;
        const comment = await commentModel.getCommentById(commentId);

        if (!comment) {
            return res.status(404).json({ error: 'Комментарий не найден' });
        }

        res.json(comment);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

module.exports = {
    getFilmComments,
    createComment,
    updateComment,
    deleteComment,
    getUserComments,
    getComment
};