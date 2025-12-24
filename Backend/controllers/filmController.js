const filmModel = require('../models/filmModel');
const favoriteModel = require('../models/favoriteModel');

// Получить все фильмы
async function getFilms(req, res) {
    try {
        const films = await filmModel.getAllFilms();
        res.json(films);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Создать фильм
async function createFilm(req, res) {
    try {
        const {
            name,
            review_critique,
            duration,
            synopsis,
            date_release,
            picture
        } = req.body;

        if (!name || !date_release) {
            return res.status(400).json({ error: 'Name and date_release are required' });
        }

        const newFilm = await filmModel.addFilm({
            name,
            review_critique,
            duration,
            synopsis,
            date_release,
            picture
        });

        res.status(201).json(newFilm);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить фильм по ID
async function getFilmById(req, res) {
    try {
        const id = req.params.id;
        const film = await filmModel.getFilm({ id });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json(film);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Обновить фильм
// Обновить фильм
async function updateFilm(req, res) {
    try {
        const id = req.params.id;
        const {
            name,
            review_critique,
            duration,
            synopsis,
            date_release,
            picture
        } = req.body;

        if (!name || !date_release) {
            return res.status(400).json({ error: 'Name and date_release are required' });
        }

        const updatedFilm = await filmModel.updateFilm({
            id,
            name,
            review_critique,
            duration,
            synopsis,
            date_release,
            picture
        });

        if (!updatedFilm) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json(updatedFilm);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Удалить фильм
async function deleteFilm(req, res) {
    try {
        const id = req.params.id;
        const deletedFilm = await filmModel.deleteFilm({ id });

        if (!deletedFilm) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json({ message: 'Film deleted successfully', film: deletedFilm });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить фильм с информацией об избранном для текущего пользователя
async function getFilmWithFavorite(req, res) {
    try {
        const filmId = req.params.id;
        const userId = req.user ? req.user.userId : null; // Если есть JWT

        const film = await filmModel.getFilm({ id: filmId });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        let isFavorite = false;
        if (userId) {
            isFavorite = await favoriteModel.getFavoriteStatus(userId, filmId);
        }

        const filmWithFavorite = {
            ...film,
            isFavorite: isFavorite,
            canFavorite: !!userId // Может ли пользователь добавить в избранное
        };

        res.json(filmWithFavorite);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить все фильмы с информацией об избранном
async function getFilmsWithFavorites(req, res) {
    try {
        const userId = req.user ? req.user.userId : null;

        const films = await filmModel.getAllFilms();

        // Для каждого фильма проверяем, в избранном ли он
        const filmsWithFavorites = await Promise.all(
            films.map(async(film) => {
                let isFavorite = false;
                if (userId) {
                    isFavorite = await favoriteModel.getFavoriteStatus(userId, film.id);
                }

                return {
                    ...film,
                    isFavorite: isFavorite,
                    canFavorite: !!userId
                };
            })
        );

        res.json(filmsWithFavorites);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

module.exports = {
    getFilms,
    createFilm,
    getFilmById,
    updateFilm,
    deleteFilm,
    getFilmWithFavorite,
    getFilmsWithFavorites
};