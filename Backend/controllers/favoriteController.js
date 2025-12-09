const favoriteModel = require('../models/favoriteModel');

// TOGGLE - переключить избранное
async function toggleFavorite(req, res) {
    try {
        // Получаем userId из JWT токена
        const userId = req.user.userId; // Из middleware authenticateToken

        const { filmId } = req.body;

        if (!filmId) {
            return res.status(400).json({
                error: "filmId is required"
            });
        }

        // Выполняем toggle операцию
        const result = await favoriteModel.toggleFavorite(userId, filmId);

        res.json({
            success: true,
            message: `Film ${result.action} from favorites`,
            action: result.action,
            favorite: result.favorite,
            userId: userId
        });

    } catch (err) {
        console.error('Toggle favorite error:', err);
        res.status(500).json({
            error: "Server error while toggling favorite"
        });
    }
}

// Проверить статус избранного
async function checkFavoriteStatus(req, res) {
    try {
        const userId = req.user.userId; // Из JWT
        const { filmId } = req.params;

        if (!filmId) {
            return res.status(400).json({
                error: "filmId is required"
            });
        }

        const isFavorite = await favoriteModel.getFavoriteStatus(userId, filmId);

        res.json({
            success: true,
            isFavorite,
            userId,
            filmId
        });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить все избранные пользователя
async function getUserFavorites(req, res) {
    try {
        const userId = req.user.userId; // Из JWT

        const favorites = await favoriteModel.getUserFavorites(userId);

        res.json({
            success: true,
            count: favorites.length,
            favorites
        });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить количество
async function getFavoritesCount(req, res) {
    try {
        const userId = req.user.userId; // Из JWT

        const count = await favoriteModel.getFavoritesCount(userId);

        res.json({
            success: true,
            userId,
            favoritesCount: count
        });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

module.exports = {
    toggleFavorite,
    checkFavoriteStatus,
    getUserFavorites,
    getFavoritesCount
};