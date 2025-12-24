import { useState, useEffect } from "react";

export function useFilms() {
  const [films, setFilms] = useState([]);

  useEffect(() => {
    fetch("http://localhost:3000/films/")
      .then((res) => res.json())
      .then((data) => setFilms(data))
  }, []);

  return films;
}
