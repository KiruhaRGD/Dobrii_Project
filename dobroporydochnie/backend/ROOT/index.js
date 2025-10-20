require('dotenv').config();

const express = require('express');
const app = express();

const filmsRouter = require('../routes/films');
const userRouter = require('../routes/user');

app.use(express.json());
app.use('/films', filmsRouter);
app.use('/user', userRouter);
const errorHandler = require('../middlewares/errorHandler');
app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Добропорядочные');
});

app.listen(PORT, () => {
    console.log(`Server is running on port: ${PORT}`)
});