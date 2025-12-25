const filterFilms = (films, filters) => {
  return films.filter(film => {
    const releaseYear = new Date(film.date_release).getFullYear();

    // Год
    if (filters.yearFrom && releaseYear < filters.yearFrom) return false;
    if (filters.yearTo && releaseYear > filters.yearTo) return false;

    // Жанр
    if (
      filters.genre &&
      !film.genres.includes(filters.genre)
    ) return false;

    // Режиссёр
    if (
      filters.regisseur &&
      !film.regisseurs.includes(filters.regisseur)
    ) return false;

    // Длительность
    if (
      filters.durationFrom &&
      film.duration < filters.durationFrom
    ) return false;

    if (
      filters.durationTo &&
      film.duration > filters.durationTo
    ) return false;

    return true;
  });
};

export default filterFilms;