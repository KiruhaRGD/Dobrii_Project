require('dotenv').config();

const express = require('express');
const cors = require('cors');
const app = express();

const filmsRouter = require('../routes/films');
const userRouter = require('../routes/user');
const favoritesRouter = require('../routes/favorites');
const commentsRouter = require('../routes/comments');

app.use(express.json());
app.use(cors());
app.use('/films', filmsRouter);
app.use('/user', userRouter);
app.use('/favorites', favoritesRouter);
app.use('/comments', commentsRouter);

const errorHandler = require('../middlewares/errorHandler');
app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Добропорядочные');
});

app.get('/films', (req, res) => {
    res.json([{ id: 1, name: 'Titanic' }]);
});

app.listen(PORT, () => {
    console.log(`Server is running on port: ${PORT}`);
});