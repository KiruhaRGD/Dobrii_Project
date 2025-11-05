const filmModel = require('../models/filmModel');

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
        const { name, date_release } = req.body;
        
        if (!name || !date_release) {
            return res.status(400).json({ error: 'Name and date_release are required' });
        }
        
        const newFilm = await filmModel.addFilm({ name, date_release });
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
async function updateFilm(req, res) {
    try {
        const id = req.params.id;
        const { name, date_release } = req.body;
        
        if (!name || !date_release) {
            return res.status(400).json({ error: 'Name and date_release are required' });
        }
        
        const updatedFilm = await filmModel.updateFilm({ id, name, date_release });
        
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

module.exports = {
    getFilms,
    createFilm,
    getFilmById,
    updateFilm,
    deleteFilm
};