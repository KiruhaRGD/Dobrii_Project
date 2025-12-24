const express = require('express');
const router = express.Router();
const favoriteController = require('../controllers/favoriteController');
const { authenticateToken } = require('../middlewares/auth');

// 1. POST /favorites/toggle
router.post('/toggle', authenticateToken, favoriteController.toggleFavorite);

// 2. GET /favorites/status/:filmId
router.get('/status/:filmId', authenticateToken, favoriteController.checkFavoriteStatus);

// 3. GET /favorites/my
router.get('/my', authenticateToken, favoriteController.getUserFavorites);

// 4. GET /favorites/count
router.get('/count', authenticateToken, favoriteController.getFavoritesCount);

module.exports = router;