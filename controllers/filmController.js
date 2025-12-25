const filmModel = require('../models/filmModel');
const favoriteModel = require('../models/favoriteModel');

// Получить все фильмы
async function getFilms(req, res) {
    try {
        const films = await filmModel.getAllFilmsWithDetails();
        res.json(films);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить все фильмы с деталями
async function getFilmsWithDetails(req, res) {
    try {
        const films = await filmModel.getAllFilmsWithDetails();
        res.json(films);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить фильм по ID
async function getFilmById(req, res) {
    try {
        const id = req.params.id;
        const film = await filmModel.getFilmWithDetails({ id });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json(film);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить фильм с деталями
async function getFilmWithDetails(req, res) {
    try {
        const id = req.params.id;
        const film = await filmModel.getFilmWithDetails({ id });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json(film);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Получить фильм с комментариями
async function getFilmWithComments(req, res) {
    try {
        const id = req.params.id;
        const film = await filmModel.getFilmWithComments({ id });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        res.json(film);
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
        const userId = req.user ? req.user.userId : null;

        const film = await filmModel.getFilmWithDetails({ id: filmId });

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
            canFavorite: !!userId
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

        const films = await filmModel.getAllFilmsWithDetails();

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

// Получить фильм с избранным и комментариями
async function getFilmWithFavoriteAndComments(req, res) {
    try {
        const filmId = req.params.id;
        const userId = req.user ? req.user.userId : null;

        const film = await filmModel.getFilmWithComments({ id: filmId });

        if (!film) {
            return res.status(404).json({ error: 'Film not found' });
        }

        let isFavorite = false;
        if (userId) {
            isFavorite = await favoriteModel.getFavoriteStatus(userId, filmId);
        }

        const filmWithFavoriteAndComments = {
            ...film,
            isFavorite: isFavorite,
            canFavorite: !!userId,
            canComment: !!userId
        };

        res.json(filmWithFavoriteAndComments);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

module.exports = {
    getFilms,
    getFilmsWithDetails,
    getFilmById,
    getFilmWithDetails,
    getFilmWithComments,
    getFilmWithFavoriteAndComments,
    createFilm,
    updateFilm,
    deleteFilm,
    getFilmWithFavorite,
    getFilmsWithFavorites
};