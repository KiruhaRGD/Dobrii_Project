--
-- PostgreSQL database dump
--

\restrict Gex8euJZA7WOpssCX1nIIenyYJHpgOefM2ZScnWvv5vwL1BTGghyVgv12zRn11R

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: film; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE film WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE film OWNER TO postgres;

\unrestrict Gex8euJZA7WOpssCX1nIIenyYJHpgOefM2ZScnWvv5vwL1BTGghyVgv12zRn11R
\connect film
\restrict Gex8euJZA7WOpssCX1nIIenyYJHpgOefM2ZScnWvv5vwL1BTGghyVgv12zRn11R

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: add_user(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_user(p_nickname text, p_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN 
    INSERT INTO users(nickname, password) 
    VALUES (p_nickname, crypt(p_password, gen_salt('md5')));
    RETURN true;
EXCEPTION
    WHEN unique_violation THEN 
        RETURN false;
    WHEN OTHERS THEN
        RETURN false;
END;
$$;


ALTER FUNCTION public.add_user(p_nickname text, p_password text) OWNER TO postgres;

--
-- Name: verify_password(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verify_password(p_nickname text, p_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_exists BOOLEAN;
BEGIN 
    SELECT EXISTS(
        SELECT 1 
        FROM users 
        WHERE nickname = p_nickname 
        AND password = crypt(p_password, password)
    ) INTO user_exists;
    
    RETURN user_exists;
END;
$$;


ALTER FUNCTION public.verify_password(p_nickname text, p_password text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    id bigint NOT NULL,
    name text,
    surname text,
    date_of_birth date
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actor_id_seq OWNER TO postgres;

--
-- Name: actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actor_id_seq OWNED BY public.actor.id;


--
-- Name: actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actors (
    id bigint NOT NULL,
    id_actor bigint NOT NULL,
    id_film bigint NOT NULL
);


ALTER TABLE public.actors OWNER TO postgres;

--
-- Name: actors_id_actor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actors_id_actor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actors_id_actor_seq OWNER TO postgres;

--
-- Name: actors_id_actor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actors_id_actor_seq OWNED BY public.actors.id_actor;


--
-- Name: actors_id_film_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actors_id_film_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actors_id_film_seq OWNER TO postgres;

--
-- Name: actors_id_film_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actors_id_film_seq OWNED BY public.actors.id_film;


--
-- Name: actors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actors_id_seq OWNER TO postgres;

--
-- Name: actors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actors_id_seq OWNED BY public.actors.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    users_id bigint NOT NULL,
    film_id bigint NOT NULL,
    comment text NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_film_id_seq OWNER TO postgres;

--
-- Name: comment_film_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_film_id_seq OWNED BY public.comment.film_id;


--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: comment_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_users_id_seq OWNER TO postgres;

--
-- Name: comment_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_users_id_seq OWNED BY public.comment.users_id;


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id bigint NOT NULL,
    users_id bigint NOT NULL,
    film_id bigint NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- Name: favourites_film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favourites_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favourites_film_id_seq OWNER TO postgres;

--
-- Name: favourites_film_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favourites_film_id_seq OWNED BY public.favourites.film_id;


--
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favourites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favourites_id_seq OWNER TO postgres;

--
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favourites_id_seq OWNED BY public.favourites.id;


--
-- Name: favourites_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favourites_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favourites_users_id_seq OWNER TO postgres;

--
-- Name: favourites_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favourites_users_id_seq OWNED BY public.favourites.users_id;


--
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    id bigint NOT NULL,
    name text,
    review_critique text,
    synopsis text,
    date_release date,
    picture text,
    detailed_description text,
    duration integer
);


ALTER TABLE public.film OWNER TO postgres;

--
-- Name: film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.film_id_seq OWNER TO postgres;

--
-- Name: film_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.film_id_seq OWNED BY public.film.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id bigint NOT NULL,
    genre character varying(50)
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id bigint NOT NULL,
    id_genre bigint NOT NULL,
    id_film bigint NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_film_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_film_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_film_seq OWNER TO postgres;

--
-- Name: genres_id_film_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_film_seq OWNED BY public.genres.id_film;


--
-- Name: genres_id_genre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_genre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_genre_seq OWNER TO postgres;

--
-- Name: genres_id_genre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_genre_seq OWNED BY public.genres.id_genre;


--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_seq OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grade (
    id bigint NOT NULL,
    id_user bigint NOT NULL,
    id_film bigint NOT NULL,
    grade text,
    review text
);


ALTER TABLE public.grade OWNER TO postgres;

--
-- Name: grade_id_film_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grade_id_film_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grade_id_film_seq OWNER TO postgres;

--
-- Name: grade_id_film_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grade_id_film_seq OWNED BY public.grade.id_film;


--
-- Name: grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grade_id_seq OWNER TO postgres;

--
-- Name: grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grade_id_seq OWNED BY public.grade.id;


--
-- Name: grade_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grade_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grade_id_user_seq OWNER TO postgres;

--
-- Name: grade_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grade_id_user_seq OWNED BY public.grade.id_user;


--
-- Name: regisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regisseur (
    id bigint NOT NULL,
    name text,
    surname text,
    date_of_birth date
);


ALTER TABLE public.regisseur OWNER TO postgres;

--
-- Name: regisseur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regisseur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regisseur_id_seq OWNER TO postgres;

--
-- Name: regisseur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regisseur_id_seq OWNED BY public.regisseur.id;


--
-- Name: regisseurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regisseurs (
    id bigint NOT NULL,
    id_regisseur bigint NOT NULL,
    id_film bigint NOT NULL
);


ALTER TABLE public.regisseurs OWNER TO postgres;

--
-- Name: regisseurs_id_film_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regisseurs_id_film_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regisseurs_id_film_seq OWNER TO postgres;

--
-- Name: regisseurs_id_film_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regisseurs_id_film_seq OWNED BY public.regisseurs.id_film;


--
-- Name: regisseurs_id_regisseur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regisseurs_id_regisseur_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regisseurs_id_regisseur_seq OWNER TO postgres;

--
-- Name: regisseurs_id_regisseur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regisseurs_id_regisseur_seq OWNED BY public.regisseurs.id_regisseur;


--
-- Name: regisseurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regisseurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regisseurs_id_seq OWNER TO postgres;

--
-- Name: regisseurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regisseurs_id_seq OWNED BY public.regisseurs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    nickname text NOT NULL,
    password text,
    date_of_registrstion date,
    access_rights text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public.users.id;


--
-- Name: actor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor ALTER COLUMN id SET DEFAULT nextval('public.actor_id_seq'::regclass);


--
-- Name: actors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors ALTER COLUMN id SET DEFAULT nextval('public.actors_id_seq'::regclass);


--
-- Name: actors id_actor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors ALTER COLUMN id_actor SET DEFAULT nextval('public.actors_id_actor_seq'::regclass);


--
-- Name: actors id_film; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors ALTER COLUMN id_film SET DEFAULT nextval('public.actors_id_film_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: comment users_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN users_id SET DEFAULT nextval('public.comment_users_id_seq'::regclass);


--
-- Name: comment film_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN film_id SET DEFAULT nextval('public.comment_film_id_seq'::regclass);


--
-- Name: favourites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites ALTER COLUMN id SET DEFAULT nextval('public.favourites_id_seq'::regclass);


--
-- Name: favourites users_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites ALTER COLUMN users_id SET DEFAULT nextval('public.favourites_users_id_seq'::regclass);


--
-- Name: favourites film_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites ALTER COLUMN film_id SET DEFAULT nextval('public.favourites_film_id_seq'::regclass);


--
-- Name: film id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film ALTER COLUMN id SET DEFAULT nextval('public.film_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: genres id_genre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id_genre SET DEFAULT nextval('public.genres_id_genre_seq'::regclass);


--
-- Name: genres id_film; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id_film SET DEFAULT nextval('public.genres_id_film_seq'::regclass);


--
-- Name: grade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade ALTER COLUMN id SET DEFAULT nextval('public.grade_id_seq'::regclass);


--
-- Name: grade id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade ALTER COLUMN id_user SET DEFAULT nextval('public.grade_id_user_seq'::regclass);


--
-- Name: grade id_film; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade ALTER COLUMN id_film SET DEFAULT nextval('public.grade_id_film_seq'::regclass);


--
-- Name: regisseur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseur ALTER COLUMN id SET DEFAULT nextval('public.regisseur_id_seq'::regclass);


--
-- Name: regisseurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs ALTER COLUMN id SET DEFAULT nextval('public.regisseurs_id_seq'::regclass);


--
-- Name: regisseurs id_regisseur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs ALTER COLUMN id_regisseur SET DEFAULT nextval('public.regisseurs_id_regisseur_seq'::regclass);


--
-- Name: regisseurs id_film; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs ALTER COLUMN id_film SET DEFAULT nextval('public.regisseurs_id_film_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (id, name, surname, date_of_birth) FROM stdin;
1	Леонардо	ДиКаприо	1974-11-11
2	Кейт	Уинслет	1975-10-05
3	Билли	Зейн	1966-02-24
4	Кэти	Бейтс	1948-06-28
5	Том	Хэнкс	1956-07-09
6	Робин	Райт	1966-04-08
7	Гэри	Синиз	1955-03-17
8	Роберт	ДауниМладший	1965-04-04
9	Крис	Эванс	1981-06-13
10	Скарлетт	Йоханссон	1984-11-22
11	Крис	Хемсворт	1983-08-11
12	Марк	Руффало	1967-11-22
13	Дэниел	Рэдклифф	1989-07-23
14	Эмма	Уотсон	1990-04-15
15	Руперт	Гринт	1988-08-24
16	Алан	Рикман	1946-02-21
17	Мэгги	Смит	1934-12-28
18	Гэри	Олдман	1958-03-21
19	Киану	Ривз	1964-09-02
20	Лоренс	Фишбёрн	1961-07-30
21	Кэрри-Энн	Мосс	1967-08-21
22	Кристиан	Бэйл	1974-01-30
23	Хит	Леджер	1979-04-04
24	Майкл	Кейн	1933-03-14
25	Аарон	Экхарт	1968-03-12
26	Мэттью	Макконахи	1969-11-04
27	Энн	Хэтэуэй	1982-11-12
28	Джессика	Честейн	1977-03-24
29	Орландо	Блум	1977-01-13
30	Элайджа	Вуд	1981-01-28
31	Вигго	Мортенсен	1958-10-20
32	Иэн	Маккеллен	1939-05-25
33	Шон	Бин	1959-04-17
34	Лив	Тайлер	1977-07-01
35	Джонни	Депп	1963-06-09
36	Джеффри	Раш	1951-07-06
37	Кира	Найтли	1985-03-26
38	Джефф	Бриджес	1949-12-04
39	Марк	Хэмилл	1951-09-25
40	Харрисон	Форд	1942-07-13
41	Кэрри	Фишер	1956-10-21
42	Оскар	Айзек	1979-03-09
43	Чедвик	Боузман	1976-11-29
44	Майкл	Би	1956-07-31
45	Бенедикт	Камбербэтч	1976-07-19
46	Рэйчел	Макадамс	1978-11-17
47	Бри	Ларсон	1989-10-01
48	Галь	Гадот	1985-04-30
49	Генри	Кавилл	1983-05-05
50	Джейсон	Момоа	1979-08-01
51	Дэниел	Крейг	1968-03-02
52	Хавьер	Бардем	1969-03-01
53	Рэйф	Файнс	1962-12-22
54	Джуди	Денч	1934-12-09
55	Мэтт	Дэймон	1970-10-08
56	Кейт	Бланшетт	1969-05-14
57	Тесса	Томпсон	1983-10-03
58	Идрис	Эльба	1972-09-06
59	Джейк	Джилленхол	1980-12-19
60	Райан	Гослинг	1980-11-12
61	Эми	Адамс	1974-08-20
62	Брэдли	Купер	1975-01-05
63	Дженнифер	Лоуренс	1990-08-15
64	Хоакин	Феникс	1974-10-28
65	Роберт	Де Ниро	1943-08-17
66	Аль	Пачино	1940-04-25
67	Марго	Робби	1990-07-02
68	Уилл	Смит	1968-09-25
69	Чарли	Ханнэм	1980-04-10
70	Джуд	Лоу	1972-12-29
71	Крис	Пайн	1980-08-26
72	Зои	Салдана	1978-06-19
73	Дэйв	Батиста	1969-01-18
74	Вин	Дизель	1967-07-18
75	Джеймс	Макэвой	1979-04-21
76	Майкл	Фассбендер	1977-04-02
77	Хью	Джекман	1968-10-12
78	Патрик	Стюарт	1940-07-13
79	Софи	Тёрнер	1996-02-21
80	Натали	Портман	1981-06-09
81	Хейден	Кристенсен	1981-04-19
82	Юэн	Макгрегор	1971-03-31
83	Дейзи	Ридли	1992-04-10
84	Адам	Драйвер	1983-11-19
85	Крис	Пратт	1979-06-21
86	Элизабет	Олсен	1989-02-16
87	Пол	Беттани	1971-05-27
88	Сэм	Уортингтон	1976-08-02
89	Сигурни	Уивер	1949-10-08
90	Шарлиз	Терон	1975-08-07
91	Том	Круз	1962-07-03
92	Ребекка	Фергюсон	1983-10-19
93	Джерард	Батлер	1969-11-13
94	Пенелопа	Крус	1974-04-28
95	Рассел	Кроу	1964-04-07
96	Сандра	Буллок	1964-07-26
97	Джордж	Клуни	1961-05-06
98	Джулия	Робертс	1967-10-28
\.


--
-- Data for Name: actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actors (id, id_actor, id_film) FROM stdin;
1	1	1
2	2	1
3	3	1
4	5	8
5	6	8
6	7	8
7	9	2
8	10	2
9	11	2
10	12	2
11	45	2
12	1	3
13	22	9
14	23	9
15	24	9
16	25	10
17	26	10
18	27	10
19	13	4
20	14	4
21	15	4
22	16	4
23	17	4
24	18	9
25	19	20
26	20	9
27	21	32
28	28	2
29	29	12
30	35	12
31	36	12
32	30	13
33	31	13
34	32	13
35	33	14
36	34	14
37	38	25
38	47	31
39	48	33
40	49	24
41	50	49
42	51	3
43	52	9
44	53	16
45	54	22
46	55	26
47	56	2
48	57	2
49	58	35
50	59	31
51	60	31
52	61	10
53	62	2
54	63	4
55	64	10
56	65	25
57	66	25
58	67	4
59	68	24
60	69	31
61	70	3
62	71	12
63	72	12
64	73	33
65	74	31
66	75	33
67	76	32
68	77	24
69	78	2
70	79	3
71	80	26
72	81	2
73	82	25
74	83	2
75	84	31
76	85	10
77	86	3
78	87	13
79	88	16
80	89	4
81	90	31
82	91	20
83	92	33
84	93	2
85	94	32
86	95	25
87	96	2
88	97	20
89	98	42
90	1	10
91	2	3
92	5	12
93	9	32
94	10	32
95	11	32
96	12	32
97	45	32
98	13	5
99	14	5
100	15	6
101	16	6
102	17	6
103	18	6
104	22	9
105	23	9
106	24	9
107	25	10
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, users_id, film_id, comment) FROM stdin;
\.


--
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favourites (id, users_id, film_id) FROM stdin;
\.


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.film (id, name, review_critique, synopsis, date_release, picture, detailed_description, duration) FROM stdin;
1	Титаник	"Эпическая история любви и трагедии"	"История любви Джека и Роуз на фоне катастрофы лайнера"	1997-12-19	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/2d86be79-ec01-4db0-927d-7faf79e55070/1920x\n	"Титаник рассказывает историю несчастной любви на фоне исторической катастрофы. Джек и Роуз преодолевают социальные барьеры и пытаются выжить. Фильм сочетает романтику и трагедию, оставляя сильное эмоциональное впечатление."	194
2	Мстители: Финал	"Грандиозный финал супергероев Marvel"	"Супергерои объединяются, чтобы победить Таноса"	2019-04-24	https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/71c9fd27-a79a-47e2-a49f-ace11e01bef1/300x	"Фильм завершающий эпопею супергероев Marvel. Команда Мстителей пытается исправить ошибки прошлого и спасти вселенную. Эпические сражения, драматические решения и эмоциональные моменты делают фильм незабываемым."	181
3	Начало	"Фантастическая концепция сновидений"	"Воровство идей через сновидения и подсознание"	2010-07-15	https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/f5845ee0-438a-408a-8538-2e3ed47d8f29/1920x	"Начало погружает зрителя в мир снов и подсознания. Дом Кобб управляет извлечением идей из чужих сновидений. Фильм задает вопросы о реальности и иллюзии, сохраняя напряжение до самого конца."	148
4	Гарри Поттер и философский камень	"Магия, приключения и дружба"	"Гарри поступает в школу магии"	2001-11-16	https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/27ed5c19-a045-49dd-8624-5f629c5d96e0/300x450	"Гарри Поттер узнает, что он волшебник, и поступает в Хогвартс. Он заводит друзей и сталкивается с тайнами школы. Первая часть приключений закладывает основу всей серии о борьбе добра и зла."	152
5	Гарри Поттер и тайная комната	"Увлекательное продолжение истории Гарри"	"Гарри возвращается в Хогвартс и сталкивается с опасностью"	2002-11-14	https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/1ef65bfb-b16b-42aa-a54a-758395253290/300x450	"Во второй части Гарри сталкивается с загадками и угрозами внутри школы. Тайная комната открывает страшные тайны прошлого. Друзья помогают ему преодолеть опасности и раскрыть зловещие планы."	161
6	Гарри Поттер и узник Азкабана	"Тёмная и захватывающая часть с новыми персонажами"	"Гарри узнает о предателе и встречает Сириуса Блэка"	2004-06-04	https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/3eabac99-fb98-4b12-ba9f-6172782d54c6/300x450	"Гарри узнает о побеге Сириуса Блэка и его предполагаемой угрозе. Сюжет раскрывает новые персонажи и опасности. История становится более тёмной и напряжённой, добавляя глубину магическому миру."	142
7	Джон Картер	"Фантастическая эпопея на Марсе"	"Экранизация книги 'Принцесса Марса'"	2012-03-07	https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/76aec0f0-bc47-4715-9818-73d3687da49f/300x450	"Джон Картер оказывается на Марсе и вовлечён в войну между цивилизациями. Он открывает свои способности и пытается выжить. Приключения сочетают фантастику, экшен и романтику."	132
8	Форрест Гамп	"Трогательная история жизни необычного человека"	"История жизни Форреста Гампа"	1994-07-06	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/3560b757-9b95-45ec-af8c-623972370f9d/300x450	"Форрест Гамп проходит через знаковые события истории США. Он сталкивается с трудностями, но сохраняет чистоту души. История трогает и вдохновляет на преодоление жизненных препятствий."	142
9	Темный рыцарь	"Шедевр супергеройского кино"	"Бэтмен против Джокера"	2008-07-18	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/0fa5bf50-d5ad-446f-a599-b26d070c8b99/300x450	"Бэтмен противостоит Джокеру, который сеет хаос в Готэме. Сюжет исследует мораль и справедливость. Фильм насыщен напряжением, драмой и философскими размышлениями о добре и зле."	152
10	Интерстеллар	"Эпическая космическая одиссея"	"Космическая миссия по спасению человечества"	2014-11-07	https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/430042eb-ee69-4818-aed0-a312400a26bf/300x450	"Команда астронавтов отправляется через космическую аномалию, чтобы спасти человечество. Фильм сочетает науку, эмоции и визуальные эффекты. Исследуются темы времени, любви и судьбы человечества."	169
11	Матрица	"Революционный научно-фантастический фильм"	"Нео узнаёт, что мир — иллюзия"	1999-03-31	https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/cf1970bc-3f08-4e0e-a095-2fb57c3aa7c6/300x450	"Нео обнаруживает, что живет в симуляции, контролируемой машинами. Он присоединяется к сопротивлению, чтобы спасти человечество. Фильм задает философские вопросы о реальности и свободе воли."	136
12	Пираты Карибского моря: Проклятие Черной жемчужины	"Весёлое приключение на море"	"Капитан Джек Воробей и приключения на Карибах"	2003-07-09	https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/d7e3dbd6-e4a9-4485-b751-d02f49825166/300x450	"Капитан Джек Воробей вступает в борьбу с проклятыми пиратами. Фильм сочетает юмор, экшен и романтику. Приключения полны неожиданных поворотов и харизматичных персонажей."	143
13	Властелин колец: Братство кольца	"Эпическая фэнтези-сага"	"Фродо получает кольцо, которое нужно уничтожить"	2001-12-19	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/a2d5bcae-a1a9-442f-8195-f5373a5ba77f/300x450	"Фродо отправляется в опасное путешествие, чтобы уничтожить кольцо. Его сопровождают друзья и союзники, преодолевая трудности и битвы. Начало великой эпопеи о борьбе добра и зла."	178
14	Властелин колец: Две крепости	"Продолжение эпической фэнтези-сага"	"Борьба за Средиземье продолжается"	2002-12-18	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/772093e4-7f68-49aa-a805-d654693aee26/300x450	"Сюжет углубляется в войну за Средиземье. Персонажи сталкиваются с предательством, битвами и личными испытаниями. Фильм расширяет масштаб и драматизм истории."	179
15	Властелин колец: Возвращение короля	"Эпическое завершение трилогии"	"Битва за Средиземье и судьба кольца"	2003-12-17	https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/e410c71f-baa1-4fe5-bb29-aedb4662f49b/300x450	"Финальная часть трилогии завершается масштабными сражениями и кульминацией судьбы кольца. Персонажи преодолевают испытания и демонстрируют мужество. История завершается победой добра и восстановлением мира."	201
16	Звёздные войны: Эпизод IV — Новая надежда	"Начало легендарной космической саги"	"Люк Скайуокер начинает борьбу с Империей"	1977-05-25	https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/9bdc6690-de82-4a8c-a114-aa3a353bc1da/300x450	"Люк Скайуокер узнает о своих силах и присоединяется к борьбе с Империей. Вместе с союзниками он стремится спасти галактику. Фильм положил начало культовой космической саге."	121
17	Звёздные войны: Эпизод V — Империя наносит ответный удар	"Темная и напряжённая часть саги"	"Империя атакует повстанцев"	1980-05-21	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/42f4a53f-b353-4700-bbb7-525837c46630/300x450	"Повстанцы терпят поражение, а Люк продолжает обучение у Йоды. Фильм насыщен драмой и неожиданными поворотами. Эмоциональные испытания усиливают напряжение и глубину саги."	124
18	Звёздные войны: Эпизод VI — Возвращение джедая	"Великолепное завершение оригинальной трилогии"	"Люк сражается с Дартом Вейдером"	1983-05-25	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/1ae91486-01cd-424e-8562-119a73add1e6/300x450	"Люк сталкивается с Вейдером и Императором, чтобы спасти галактику. Заключительные сражения и драматические решения героев создают кульминацию истории. Сага завершается победой добра."	131
19	Один дома	"Весёлая рождественская комедия"	"Кевин защищает дом от грабителей"	1990-11-16	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/022a58e3-5b9b-411b-bfb3-09fedb700401/300x450	"Маленький Кевин остаётся один дома на Рождество и защищает дом от двух грабителей. Комедийные ситуации и остроумные ловушки делают фильм веселым и запоминающимся. Отличная семейная история."	103
20	Назад в будущее	"Классическая фантастическая комедия"	"Мартин МакФлай отправляется в прошлое"	1985-07-03	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/73cf2ed0-fd52-47a2-9e26-74104360786a/300x450	"Мартин МакФлай случайно попадает в прошлое на машине времени. Он сталкивается с неожиданными проблемами и пытается исправить события. Фильм сочетает юмор, приключения и фантастику."	116
21	Джуманджи	"Приключения и магия настольной игры"	"Дети находят магическую игру"	1995-12-15	https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/2575da3f-a4f1-4626-9024-8476f916c4e7/300x450	"Дети находят волшебную настольную игру, которая оживляет приключения. Они сталкиваются с опасностями и должны пройти испытания, чтобы вернуться к нормальной жизни. Фильм полон юмора и фантазии."	104
22	Список Шиндлера	"Историческая драма о Холокосте"	"История Оскара Шиндлера, спасшего евреев"	1993-12-15	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/1e1ac6d9-c658-4f5f-937e-d080bca0d893/300x450	"Оскар Шиндлер использует свои связи, чтобы спасти сотни евреев во время Холокоста. Фильм рассказывает о мужестве, сострадании и человеческой доброте. Это сильная и трогательная историческая драма."	195
23	Король Лев	"Классический анимационный фильм Disney"	"История львенка Симбы"	1994-06-24	https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/60aa1abc-b754-4817-ad9c-0bcda427a12b/300x450	"Симба преодолевает потерю отца и принимает своё место короля. История о дружбе, любви и ответственности. Фильм наполнен музыкой, эмоциями и красивой анимацией."	88
24	Аватар	"Фантастический мир Пандоры"	"Человек исследует планету Пандора"	2009-12-18	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/4adf61aa-3cb7-4381-9245-523971e5b4c8/300x450	"Джейк Салли изучает культуру народа На’ви на Пандоре. Он вступает в конфликт между людьми и аборигенами. Фильм сочетает фантастику, экшен и визуально захватывающий мир."	162
25	Гладиатор	"Эпическая историческая драма"	"Максимус становится гладиатором"	2000-05-05	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/7c3460dc-344d-433f-8220-f18d86c8397d/300x450	"Максимус предан и превращен в гладиатора, стремясь к мести. История сочетает драму, боевые сцены и историческую атмосферу. Фильм о чести, смелости и справедливости."	155
35	Чёрная пантера	"Фантастическая история супергероя из Ваканды"	"Т’Чалла возвращается домой и становится королем"	2018-02-16	https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/84419b55-2d11-4fe1-b082-c26df2d82f08/300x450	"Т’Чалла возвращается в Ваканду и сталкивается с угрозой со стороны врагов. Фильм исследует тему лидерства, ответственности и традиций. Экшен и культура страны создают уникальную атмосферу."	134
34	Человек-муравей	"Комедийный и приключенческий супергерой"	"Скотт Лэнг становится Человеком-муравьем"	2015-07-17	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/427ee275-67c0-4a37-b10a-66ca1e4197d5/300x450	"Скотт Лэнг использует костюм Человека-муравья, чтобы совершать героические поступки. Фильм сочетает юмор, экшен и командную работу. Герой преодолевает личные и внешние препятствия."	117
33	Чудо-женщина	"Сильная супергероиня и приключения"	"Диана становится Чудо-женщиной"	2017-06-02	https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/de30cec1-c90e-4d7a-b7e7-4b5db3bdf02c/300x450	"Диана открывает свои силы и становится Чудо-женщиной. Она защищает мир от войны и зла. Фильм сочетает экшен, героизм и эмоциональные моменты."	141
32	Доктор Стрэндж	"Магия и супергеройский экшен"	"Доктор Стрэндж открывает мир магии"	2016-11-04	https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/bb966b79-5b10-485d-88d7-fb6aeb79b185/300x450	"Доктор Стрэндж учится управлять магией после трагической аварии. Он сталкивается с угрозами, которые могут разрушить мир. Фильм сочетает фантастику, экшен и визуальные эффекты."	115
30	Парк Юрского периода	"Научно-фантастический приключенческий фильм"	"Воссоздание динозавров в парке развлечений"	1993-06-11	https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/0d072841-8c4d-40ac-82bc-36e743ef49f5/300x450	"Парк с живыми динозаврами становится ареной опасных событий. Учёные и гости борются за выживание. Фильм сочетает приключения, экшен и научную фантастику."	127
29	Терминатор 2: Судный день	"Классика научной фантастики и экшена"	"Киборг защищает Джона Коннора"	1991-07-03	https://avatars.mds.yandex.net/get-kinopoisk-image/10893610/2dd14742-f241-42ca-9db4-331e3a483c50/300x450	"Киборг возвращается, чтобы защитить Джона Коннора от нового терминатора. Сюжет сочетает экшен, напряжение и вопросы о будущем человечества. Фильм стал культовым произведением жанра."	137
28	Хоббит: Битва пяти воинств	"Эпическое завершение трилогии"	"Кульминационная битва за Одинокую гору"	2014-12-17	https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/ee1276c4-6e67-45cd-94db-8bd47bb21da4/300x450	"Финальная битва за Одинокую гору объединяет всех героев. Сражения и драматические решения создают эпическую атмосферу. История завершается восстановлением справедливости и мира."	144
27	Хоббит: Пустошь Смауга	"Продолжение фэнтезийного приключения"	"Гномы продолжают поход к Одинокой горе"	2013-12-13	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/dd195023-81e0-42bc-9b33-e86ac8abf30e/300x450	"Гномы продолжают поход к Одинокой горе, встречая опасности и чудовищ. Бильбо проявляет смелость и находчивость. Фильм расширяет историю Средиземья и его героев."	161
26	Хоббит: Нежданное путешествие	"Фэнтезийное приключение"	"Бильбо Бэггинс отправляется в путешествие"	2012-12-14	https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/0e569ebd-0639-416b-92c5-2afffbd5d089/300x450	"Бильбо Бэггинс покидает дом и отправляется с гномами на опасное путешествие. Он сталкивается с чудесами и опасностями. Фильм насыщен приключениями, юмором и магией Средиземья."	169
50	Человек-паук: Возвращение домой	"Молодой Человек-паук в Нью-Йорке"	"Питер Паркер балансирует между школой и супергеройством"	2017-07-07	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEgsl41jBPmf5jV6Gc-D1kAmqwymvqBMItJgrBicWoLVFCDN4k-7fh60j1zR5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Питер Паркер старается совмещать жизнь обычного подростка и супергероя. Он сталкивается с угрозами и учится ответственности. Фильм сочетает юмор, экшен и эмоциональные моменты."	133
47	Джокер	"Темная драма о становлении злодея"	"История происхождения Джокера"	2019-10-04	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEgco7FzGP2f0iAXTf-D5lwmtwiatqBNfvJkrBiZB9bVGXjUtw-ffhashh2d5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Фильм показывает путь Артура Флека к становлению Джокером. История исследует общество, психику и причины появления злодея. Мрачная драма с сильной актерской игрой."	122
48	Лига справедливости	"Супергеройская команда против угрозы"	"Супергерои объединяются, чтобы спасти мир"	2017-11-17	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEggs6l7HMWep2Q2CfOf9lwn6yn2oqBNf45MrBiRGpbUdCTF_xunZ1Kl10jJ5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Супергерои объединяются против глобальной угрозы. Фильм исследует командную работу, жертвы и ответственность. История сочетает экшен и динамичное повествование."	120
45	Гравитация	"Космический триллер о выживании"	"Астронавты пытаются вернуться на Землю"	2013-10-04	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEggu41vKNmf9i1rQf-39wQmqyS__qBNa458rXiZFobUVC2colLmLgql4hzR5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Астронавты оказываются в опасной ситуации на орбите Земли. Они борются за выживание и ищут способ вернуться домой. Фильм сочетает визуальные эффекты, напряжение и драму."	91
46	Марсианин\n	"Выживание на Марсе с юмором и наукой"	"Астронавт остаётся на Марсе один"	2015-10-02	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEgcs6l_LPmf62grTeuH1kgn9wiurqBMEss4rBiVAobUQCjQpkOqI3P51gmB5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Марсианин борется за выживание после того, как его оставили на Марсе. Он использует научные знания и смекалку, чтобы остаться живым. Фильм сочетает драму, юмор и науку."	144
43	Король Артур: Легенда меча	"Приключенческий эпос о легенде"	"Артур становится королем"	2017-05-12	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEgYl4lDKP2f-jw-Cfeb4kgn6yH2tqBNYtJ4rXiZForVCC24jwejYhqp50Gl5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Артур открывает своё истинное происхождение и берёт в руки меч Экскалибур. Он сталкивается с врагами и борется за справедливость. Фильм сочетает экшен, драму и мифологию."	126
44	Миссия невыполнима: Последствия	"Шпионский экшен с впечатляющими трюками"	"Итан Хант выполняет опасную миссию"	2018-07-27	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEg4k71vDN3rjigXVeeL4kBe1zX2uvAoItMhnEnMQoq8JDGd4xO7a164l1zJgA5-V4oUHCRugFkR9VWycM-t1fW1Ja61GmG8mo8xTiTi-49ZRx6Q_xOpNavDBZWp4ZfHIQ2wFYoOQqqzQGJcaOXjb4p2VWk1xvAFEZnZqgSTYfW51blWbLZRSIrXQcoQ5v7rHU8-Qcs7CQXXn7ENrdnHy9XZNB2qVuJ-iwAWBOSZd7vCkpHpzXbMeZHhvaac42Fleakd3nT-QTy6D9WquDLGp3m_1j1b981BvzudWbWdy49RjVxBQq72wiMs3mwkXdMLVmo5CeE6xJHZ5Q1q3LcdxflJUa5wKnFwimvldmj6AiPJo6ZF598dMZNHkZXN7R_T0d1Iza6KvoL7QGawTI3TPyaSzY2Z7ihlUVmFRhy3WdWFTfU6bCaZEMa3ue7gCs5T8VNeoScTtVVLI4GFXQlLG22Z2HVGHmZic1QGGEjtr1fyfu0dRTbYzcEhVS58D00h7SnRorxGcTymP0ky1GrOYzWLciVP6w0937_9qV2Bg3ftAdw9DuqW5kuwGujYuasLHkKl-aUWtM1JQQFCrK-RiVW1uepUaim44rdJxqziDmcpyyJ5Q6ONCSdX7QUl5ZvTeSn0FWLmtuoD5BZA8GGHe8qWZdEZlmwxMcHZktgvqXVBneESUOoptG730XboblIHDSdCaXd7fcFDA20Nwf0vT4mpBH0KRpqK0_SWyFDBm1OiImUpQaZYqTW1hdqMy9V17Qm9-iQ-ffByO0U2EB7umyGrWuG7b_Wx-6sxPRnlm8_ZNczBMt7eYjugylzUMY8bVm41ZZk-TLGlXWX-hG8VdfGBQd4ItvHALg-pPhyyXrPd39LJ16dxqS-LAUEtgad_Sc1QxVL-0uajTKZUdI23b1JS3aVJRvSBMeGJgmg3gQXNraXmOOLFiG6_bX6U5kY7FaOqdVfXdSXnw-kNIV1P6ylBPEle5naK09AO2IB1t39-Fu0NsXZola1pbRJUAyFVxWll-qAelci2nxG2lJbunyVHXsFLZz3Zw181oW1BJ28lzaQVNiraLt9MUtxkZbuHhl7J4b0y-A21fXGCrN8xmXkRaVZgJg1YMi-1PmiyxvtNR3Y1Z69NQd8fyaXlFUdX-YEIxepqcpLbpIZMpJ3bi4p28XU5gvgdUSXRfvwfFXHV1eWu-HZ1PCZvGc7Yqo7nFTu-2ctvtVHLn3XR8Wnfj2XJYO1yQjJC96TmkBwFl6NWEjVJ7bIgORklve7sO-3hVQm1Ylh2VayW00FWLM7e38GrJkUX-9kZU0O9rblZv0dxNSR1_hqiKoeAtqDEUYMndm7d-ZHqwMH9PVGu1I_N3dVBWUL4xtnEnrddysgO3i-NB7qh62NRmcdX5cG97Y_XUYXMWVr2Wqor_L6AlDHb87Zi5UF1mqihjS0dcqxvEa3ZNfHCjMJJTMbz0ZpUErLn2SfqSTcX3Qkvz5lZ7aUDk4GxPFVi0qoO80yanICZl3e2xhWd1bLMOTG5hQpsT5GRgUEl3oC2pQQ-e8X6hHpmo6HTPllrr4U9JydJWcGFw79BrQRJju6ubtPkQsxYZXODRqJRyU026E2h4WlWqN-9xcmZZUr8pt3Ilv8VWrymmhM9U4aNt0-pwSeTGaGVSSObxV3wycJ6aob7vFIQhE3781riqVVF7mwhmb21Yhy7Nelxna1aICb9wJrz2dbUIp4vvS-itcMvLZWzP_X98V2fg21VBAXqwrL6w7COpCB11xsKZtF9fe6oHS2pjV7sD8158T0hYog-CYCGN6UWVCaK00Ev5n17rwVJS6Ot8eWluwstrTSB8gZO4s9kTuRo5a_riq5Vhe329IX9eeVq3FddxX0d_SLYdlXU6nPZtpgC9ochAwLl6-MZif-biVVVbV9r9TU0QTLuQk7b2OYUlDn_4yKK6Qn1YnR9EVXlqlBnhYHJyVlK4KoZiLK7tWqMOnonBd_-_Tt3IV0Tr5FJ5Ymnf8kx4PV6juruD_xW6EhxY5PSGhXZMbJM7cnVVcrsTwVpDZHJ-qCWSax6m_02HBpym4VD8uFPmy0pw4PBid2hJ08pWfC5wnre4isgNsDMzRMXMh5R5dXycCkRYeXeDKNR5Y051ZogAkl8FiPlmox-xg-hi9oNQ7udyZNzhSVx_dNLbUlAbXZ65jaLTA6QDDnnl97GRRkl_jhFUWnNllgrRQnxSWE6yMIJpKqHzSJEPr6HqQ-2WdfbjRn3u2k1LYmDE9WdDFEyGjpGszzG1BRJaxvCWiGJsbpAkYmZ2Y7Ib-FlMZW9QixukdyCb7nOkHpuFyGbQmn7y4W9SzvhrTlxC1dpdTjNIt6udk_UChB0DZMHBqq1yeUKbKGl6ZGq9OMFDUnZHVa4ptl8ApfpeuDmfq8xw8ZFvzvdBb-7IaFdEfubidmoiWLqshKr1A7Y5Bkjc_56fZ01iqyJGZFhqgibNfF1Ze3GrH4dtEaX9RbMev6vld_C2SOjpQmvs41ZZdVD16lRSJnKxkKC26DenOSxPwdOjuVp4RasTcmpxWoYTxFd1dHVFsB6nQj6d3lOYJIef6UHfoX3xylZJ7eJVcEJS5_R9XAJhpqqDqfomhjwDe__Wq4tCcUeuMXJPUnGlINpcQEJNV58btUUbtO5OpACRputK0bBRzvxfUOrIbWtzVPHLYFI5XIWzq6_dEKkEH0HF5Iuxd3NqsAdDXW1Rsi_hR3BAdnScBLlqDJ3qX6YFu5fVaP6sZ-rqQGvVxU9afWf02mJSJnG-kq-91SmqJD5F6OiIlVZtYo4RS1VNcZAq-GBdW3xQtBiScQGg8Vi3EaCh_mDKvEv-80JOweNHcElL2_tRWiBBnpi6h9YliD49Z9XPt45jU1-IHXxJeWeJF-V-Zm5wd68Pn1YKn-hYmg6znOM	"Итан Хант и его команда сталкиваются с глобальной угрозой. Фильм наполнен трюками, экшеном и напряжением. История демонстрирует командную работу и смелость."	147
40	Шерлок Холмс: Игра теней	"Продолжение приключений Холмса"	"Холмс против Мориарти"	2011-12-16	https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/27b4bcbe-4048-4362-8e40-b9b42e0ef1c2/300x450	"Холмс сталкивается с гениальным противником Мориарти. Интриги и опасные ситуации держат зрителя в напряжении. Фильм сочетает детектив, экшен и динамичное повествование."	129
42	Аладдин (2019)	"Живая экранизация классической сказки"	"Аладдин в ожившей версии сказки"	2019-05-24	https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/0d068fcf-b13f-45cd-8f27-a897e47438fd/300x450	"Аладдин находит джинна и стремится завоевать сердце принцессы. Фильм сочетает приключения, музыку и визуальные эффекты. История обновлена для современной аудитории."	128
41	Аладдин	"Классическая история с магией и приключениями"	"Аладдин находит волшебную лампу"	1992-11-25	https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/60add1e1-d3ae-4e5c-af67-4fdabadb40ac/300x450	"Аладдин находит волшебную лампу с джинном и мечтает о лучшей жизни. Он сталкивается с препятствиями и злодеем Джафаром. Фильм наполнен приключениями, магией и музыкой."	128
38	Чудо-женщина 1984	"Продолжение истории супергероини"	"Диана сталкивается с новыми угрозами"	2020-12-25	https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/2efdd5e7-feb8-4394-b473-a4ffd661d21f/300x450	"Диана сталкивается с могущественными противниками в 1980-е годы. Она учится использовать свои силы с большей мудростью. Фильм сочетает экшен, драму и ретро-атмосферу."	151
37	Капитан Марвел	"Супергеройский фильм о происхождении"	"Кэрол Дэнверс становится Капитаном Марвел"	2019-03-08	https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/13590f7e-10d8-47eb-9321-c34ce79cd0e6/300x450	"Кэрол Дэнверс обретает суперсилы и узнаёт о своём прошлом. Она защищает Землю от инопланетной угрозы. Фильм сочетает экшен, юмор и развитие персонажа."	123
49	Аквамен	"Подводный эпос о супергерое"	"Артур Карри открывает своё наследие"	2018-12-21	https://kinopoisk-ru.clstorage.net/30j13oX82/e97c5cMLP/kUV3xy3RMP0nz6wpCNnWWupHK9iWXfzFJ2Ii5lF1TW5Agdlc6Wr4AxVcbEggu41vKNmeqiQWFeez0nAmgyCitqBMOs5orByFApbUUCm9-wL2NhvxygDZ5H5yVqskGDHSgCER-SHyBKOV7elRJa_QDmmgnvNNVkyD7v9F7x9tH8-9xSe7JU1ZQQsf_c2kuar2coazANKk_Alvr6rqUQmZotwhfXU5hlhvtaGJzd12fD6dsMaDyWJIhoq7Tc_OWTdvjbl7D71JYREH6ylJrJnyVqa-83SKKICdu-dOLtHxKZ6goQURNR4obyVh9WlVbjQu6YAeF6nKnL7G370nssn7q8nR3yPpUSUdQ299IfBxCkIaFt-84uhEOQtztoYx3WWWSOkBoflefBOF4RUlJWrgHqWweid1GlR6Qm-hV8p103u5_aMvJSlVyR_vLTV8nS4KWs6zBD6AlDk_A05ytaWxerxhvSnVnnxXlZ0RgbF27PbF_KZ77ZKktjJXUa8utR_T3SXHPzW5sZ3XU2mlxHW60rpGp2SWhPRFV9eiUiV5aYoU8cX5vf7EQ2H1daUppowe6ZwuizGmxLYCk4mDqt3na7WxW0MZuTlVu9PxoYw9TiI-fkN4ZhSgQQs7nhrBmUnmFHmlrdEuZJ_JTenNYU6gRm3YpovF3kx2Bo_J0_bRr-uBSbNTtcFdTR9H2YmkUUICMjYXdM48eG1770ra6SXJPugBJXUBWuSnNVnBlZlKIEZhVOYTdZrAKmarJbPm5XcbSS3n070lRfmDt1l5zDniLlLmB_RGnNhxU4f-2hF9-QpwBVEpSQ4A2zX1VclxPvQSJUgqhzVisJb6h6mrbiljkzmVT4-N_V1NA-fFsXABemq6DlOo0hgoZRtzsopdpWEeaJW5yW0GpBs16d01VRJ8nhUUHms9bhwm0nvdI0ZFqxchQW-_8ck5cbN3PS10YVpmPpa_xNq4lF1vd45inXUZplgBBSUR6vyPRdXx0W0iKKpdVK6vfeZIPlqzoVv6xdsTrYknV73F5ZknF7FB-G1CwlLmI2xWTGxdf1vKUjWNKTpMnY3BgdbILxXdNRFxutT6HYyO07XmOJb-g0WvTtlrW1Gtu4sRifnxoxs92aQFjm726r8wUqh8UYejgnbZgW2q1IWZ3REuFD_ZYU0d3XrsYo0IPnc9Ghy-mutFh7r1oyvJsft3FQGtkZvHcXV02c7GSu5X5MJohDGLr6pOTQXdqsRhwX3tftQbMc2JkSXivBrpHH7bzaoE9oazOU9WWWPT2aV7y2EV0QlDWzkdXEHmhprCV4Qe0Bx9o3POinHR7XLgKcERfW7w46FNVcHpQrw6eazCg1VeYKa-Z6nXyoX3v5E9pwMdXeFpi0_FWcTNvhbysnPULghIaSdTsmLBrbWSGM3Z_T1WRMOdzR0tyeIMthGkpp_JuqCmTisFSy55bzcRqbNbcVlVWRtvdbHoaVLuch4P3A5YKDHzk75aeUnF-ni9ybHhLqQf7cFphUmWCCaZ_OITmSa8yoZ_JRvGpRu7gUErJ-kJHdVfv0FB5FF2HtbGv_gSTIB9d5MaqqXp7Z7gAV0pme6En9GZHVFVmnzK0QRqB_n21B7CB9HP1vmj47VJw_fpJT0Vc39defi9Shq25hcgQpR8mYNjfu7xcWm6lJEFxcUqFLOF0cURweZssh2s7tdZzgjicptRdwIlQ89JSXenEXHx9Vf7rY148d7eXs5PMJ5IVBHzfz4WbXmxPvipWRnxnnA7qWnB2dE67JIVoOIb1aaM5k4bLVM6USNLHd3bS00V5UlPU6V5tNlmBiL2Q-wq7Gw9Gy-6bkVBsfrEHU0hzW7EwznpYVXpkvRmVbwmZxUmiPKy5y0X8umjY8ElRxNBAR1txxNdSTDBovo6-pcsaqT8Reuvcuq90ammXM2dSflenFOFZUGJqcK8OgHQYhu16qyO5ocB82p5738BkX835bHViafLxUnwAUr2lu4rhJpYIBXjB1ZWMck9JqQhsUk50qyLwdGVLcH6YHZdiKp3af6UAkaj3Q9yqXtH1X1LL_kBMXGz98GdREkqXjY6DzRmhGiJk_fGquEN7R40-TH5WW6ECykVzb1xulwmeUCKPzVutAr6I0EDbt2XS6GtZ385ORnxgxepjQjx3mo6HtNUTgDU-RcXwu7d6a0i8CGFSU2OaF-llWWhETrIJqksMieZ_tC-bgeJK4LRt_tB_Zc7lZVFBYdTuT3cRd5S7r6_bB7AIA2X-xr6IRmhapxhjWEF2uBLSekVFbHSCGZxkJYPITaQxuYPDUfWRdfrkZlf14XJMVXf621x4AG-jp6Gz6Ra2FCBG-eGnrGN5RJIuX11HUqk7yUpycnJNqT-Cbh-e83i1BZ2h5mz5mnH4zUl318d3cndm1eFRXwRehqueidonrgUeQcjdgrx2VU-eJUNPTl2KAtNUYVp3aJstqk4hit5kkgGzpfBN8otN7uN0V-fEbmpLVe3KdU4UU4Gyp4nbFYoAMlz26bCpQnV_lApdc05ilA7sW05mU22tHJhfIY3Fb7Uhs4z3TNWsa_DgcFXM-mBbZUbl6E1KPli9lruU7wSKKjVB2tSWlHdSf6U-U1p-ZqEHx3NjaGd2rDy3cBmu00SPGYeAwWPCmXLT9FJUzflJbGdU-8FDbi1Ph7Wkhv4ljwUBf9_cpIx-UHqHPnZ5VUWSGcxGVVB1WakusFUwns54qw--gspt07VN5f1LU-fBUl1hQsTcTVUQbJ6doqHICrcZO0Xt_J65fH1ksQ9kRnVSnSLXdldrVlq2Ip9CGZrfeq4lj7zoQs-DafPicGzq42NTUkfV3k1KPVe_mbCp8QmXOD9o4f-6mGJ1WqcHbGZVcJg78FtMYXJyqgmETySB2Gu6PrmX4Hbfr33q4FV4zOtJZ35o9O1FTA13tYyKqv0rjTsdVcbAoa1cSFyrMHBSQ2mlJu5geW1Vab0Eo0QbmNhGpS2EisM	"Артур Карри узнаёт о своём наследии и роли короля Атлантиды. Он сталкивается с врагами и защищает подводный мир. Фильм сочетает экшен, приключения и визуальные эффекты."	143
39	Шерлок Холмс	"Детективные приключения знаменитого сыщика"	"Холмс и Ватсон расследуют сложные дела"	2009-12-25	https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/244e2847-f426-4c60-86ba-34cde7db695f/300x450	"Шерлок Холмс использует дедукцию и ум, чтобы раскрывать преступления. Вместе с Ватсоном они сталкиваются с опасными противниками. Фильм сочетает детектив, экшен и юмор."	128
36	Доктор Стрэндж: В мультивселенной безумия	"Продолжение магических приключений"	"Стрэндж сталкивается с альтернативными реальностями"	2022-05-04	https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/18bc685e-9c23-4b97-9cc3-8a2b17a0c9ad/300x450	"Доктор Стрэндж путешествует по мультивселенной и сталкивается с опасностями. Фильм исследует альтернативные реальности и последствия магии. История сочетает экшен, мистику и драму."	126
31	Человек-паук: Нет пути домой	"Эпическое возвращение Человека-паука"	"Питер Паркер сталкивается с мультивселенной"	2021-12-17	https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/731c4031-7389-44f4-8c15-f9f4e3b0ed90/300x450	"Питер Паркер сталкивается с персонажами из других вселенных. Фильм исследует последствия путешествий во времени и мультивселенных. История наполнена экшеном, драмой и ностальгией."	148
51	Зелёный слоник	"Захватывающая радужная комедия про двух друзей"	"Двое офицеров отправились на гауптвахту"	1999-12-07	https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/acb20d4a-57e2-4ac2-8c89-e550958d65a1/300x450	"Два младших офицера, сидя в одной камере на гауптвахте, вынуждены решать острые социальные и психологические вопросы в небольшом пространстве."	86
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, genre) FROM stdin;
1	Драма
2	Комедия
3	Мелодрама
4	Боевик
5	Ужасы
6	Триллер
7	Детектив
8	Фантастика
9	Фэнтези
10	Мультфильм
11	Семейный
12	Приключения
13	Психологический
14	Исторический
15	Музыкальный
16	Вестерн
17	Криминал
18	Военный
19	Биографический
20	Мистический
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (id, id_genre, id_film) FROM stdin;
1	3	1
2	14	1
3	8	2
4	4	2
5	8	3
6	13	3
7	9	4
8	12	4
9	9	5
10	12	5
11	9	6
12	12	6
13	8	7
14	12	7
15	1	8
16	14	8
17	4	9
18	6	9
19	8	10
20	1	10
21	8	11
22	6	11
23	12	12
24	2	12
25	9	13
26	12	13
27	9	14
28	12	14
29	9	15
30	12	15
31	8	16
32	12	16
33	8	17
34	12	17
35	8	18
36	12	18
37	2	19
38	11	19
39	8	20
40	2	20
41	12	21
42	11	21
43	14	22
44	1	22
45	10	23
46	11	23
47	8	24
48	12	24
49	14	25
50	1	25
51	9	26
52	12	26
53	9	27
54	12	27
55	9	28
56	12	28
57	8	29
58	4	29
59	8	30
60	12	30
61	8	31
62	4	31
63	8	32
64	4	32
65	8	33
66	4	33
67	8	34
68	2	34
69	8	35
70	4	35
71	8	36
72	9	36
73	8	37
74	4	37
75	8	38
76	4	38
77	7	39
78	4	39
79	7	40
80	4	40
81	10	41
82	12	41
83	12	42
84	2	42
85	12	43
86	4	43
87	4	44
88	6	44
89	8	45
90	6	45
91	8	46
92	1	46
93	1	47
94	13	47
95	8	48
96	4	48
97	8	49
98	4	49
99	8	50
100	4	50
\.


--
-- Data for Name: grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grade (id, id_user, id_film, grade, review) FROM stdin;
\.


--
-- Data for Name: regisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regisseur (id, name, surname, date_of_birth) FROM stdin;
1	Джеймс	Кэмерон	1954-08-16
2	Энтони	Руссо	1970-02-03
3	Джо	Руссо	1971-04-18
4	Кристофер	Нолан	1970-07-30
5	Крис	Коламбус	1958-09-10
6	Дэвид	Йейтс	1963-11-30
7	Питер	Джексон	1961-10-31
8	Джордж	Лукас	1944-05-14
9	Стивен	Спилберг	1946-12-18
10	Мартин	Скорсезе	1942-11-17
11	Ридли	Скотт	1937-11-30
12	Дж. Дж.	Эйбрамс	1966-06-27
13	Пэтти	Дженкинс	1971-07-24
14	Гай	Ричи	1968-09-10
15	Гильермо	дель Торо	1964-10-09
16	Джон	Фавро	1966-10-19
\.


--
-- Data for Name: regisseurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regisseurs (id, id_regisseur, id_film) FROM stdin;
1	1	1
2	2	2
3	3	2
4	4	3
5	5	4
6	6	5
7	6	6
8	4	10
9	1	24
10	7	13
11	7	14
12	7	15
13	8	16
14	8	17
15	8	18
16	5	19
17	8	20
18	12	20
19	9	21
20	9	22
21	9	23
22	9	29
23	9	30
24	7	26
25	7	27
26	7	28
27	10	47
28	11	25
29	11	45
30	11	46
31	4	9
32	4	11
33	9	11
34	4	32
35	13	33
36	13	38
37	14	39
38	14	40
39	5	41
40	16	42
41	14	43
42	12	44
43	11	48
44	15	49
45	2	31
46	3	31
47	2	34
48	3	34
49	2	35
50	3	35
51	2	36
52	3	36
53	2	37
54	3	37
55	2	48
56	3	48
57	4	50
58	2	50
59	3	50
60	9	50
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nickname, password, date_of_registrstion, access_rights) FROM stdin;
1	user1	$1$7HQ/ek90$VnWzjx/6iNE/5s.G4Adxe.	2025-12-24	user
2	user2	$1$5V1a55xj$ElIaZnBdlixHf.DhnNexS.	2025-12-24	user
3	user3	$1$JdLIUbRK$e82FVeolsUEp21gTplmzx1	2025-12-24	user
4	user4	$1$xSvcprtT$klyAeWMT5wXY2E.hmqy551	2025-12-24	user
5	user5	$1$fJfqVf3b$hLqSXf7cuZVRF4sDUy9MK.	2025-12-24	user
6	user6	$1$wzyhlEIY$Ja1.YODUPYXTt/o9BKB7R1	2025-12-24	user
7	user7	$1$OmyxxgNU$Kd14nnZeDuzuuAdafdnQ61	2025-12-24	user
8	user8	$1$Bk2QP0IH$w0sfWT83ePtv.FSOtLQ9t0	2025-12-24	user
9	user9	$1$302Dv01w$JxKCqED60y8zsljEIClfP0	2025-12-24	user
10	user10	$1$PZf3lI3H$ZyCNtPh.ylPW542jTiTv60	2025-12-24	user
11	user11	$1$HjCskBFk$LhfTAPunjDCCElbGouJGq/	2025-12-24	user
12	user12	$1$vsA.BXCv$gc4mHfjH656cqITY.9gcq0	2025-12-24	user
13	user13	$1$Ab/P6OB8$RnGXjx.LkA6/08kngit78/	2025-12-24	user
14	user14	$1$3RAwWEgW$kUIqkizazf8THJXqh6qBr/	2025-12-24	user
15	user15	$1$d52An2Lx$8pKp.GQO998Bb0oVGfHww0	2025-12-24	user
16	user16	$1$Q37.dVyj$9aKZNsho2qnzN0w9U1Osu0	2025-12-24	user
17	user17	$1$8WNl2eVe$KZBgPNKWL6p/dyhXaZuDq0	2025-12-24	user
18	user18	$1$OlYU5ruE$Ba76sokx6MSTFJxkx7Xyt.	2025-12-24	user
19	user19	$1$wLYrG.my$EsxGCIMd4PB1HIA49aOi7/	2025-12-24	user
20	admin_user	$1$WIYSTOvO$JbABaws9gjEFYz8cSWJb7.	2025-12-24	admin
\.


--
-- Name: actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_id_seq', 1, false);


--
-- Name: actors_id_actor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actors_id_actor_seq', 52, true);


--
-- Name: actors_id_film_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actors_id_film_seq', 52, true);


--
-- Name: actors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actors_id_seq', 52, true);


--
-- Name: comment_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_film_id_seq', 1, false);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 1, false);


--
-- Name: comment_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_users_id_seq', 1, false);


--
-- Name: favourites_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_film_id_seq', 1, false);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: favourites_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_users_id_seq', 1, false);


--
-- Name: film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.film_id_seq', 1, false);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 1, false);


--
-- Name: genres_id_film_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_film_seq', 26, true);


--
-- Name: genres_id_genre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_genre_seq', 26, true);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_seq', 26, true);


--
-- Name: grade_id_film_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grade_id_film_seq', 1, false);


--
-- Name: grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grade_id_seq', 1, false);


--
-- Name: grade_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grade_id_user_seq', 1, false);


--
-- Name: regisseur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regisseur_id_seq', 1, false);


--
-- Name: regisseurs_id_film_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regisseurs_id_film_seq', 1, false);


--
-- Name: regisseurs_id_regisseur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regisseurs_id_regisseur_seq', 1, false);


--
-- Name: regisseurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regisseurs_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 20, true);


--
-- Name: actor actor_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pk PRIMARY KEY (id);


--
-- Name: actors actors_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pk PRIMARY KEY (id);


--
-- Name: comment comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pk PRIMARY KEY (id);


--
-- Name: favourites favourites_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pk PRIMARY KEY (id);


--
-- Name: film film_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pk PRIMARY KEY (id);


--
-- Name: genre genre_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pk PRIMARY KEY (id);


--
-- Name: genres genres_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pk PRIMARY KEY (id);


--
-- Name: grade grade_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade
    ADD CONSTRAINT grade_pk PRIMARY KEY (id);


--
-- Name: regisseur regisseur_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseur
    ADD CONSTRAINT regisseur_pk PRIMARY KEY (id);


--
-- Name: regisseurs regisseurs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs
    ADD CONSTRAINT regisseurs_pk PRIMARY KEY (id);


--
-- Name: users user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: users users_nickname_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nickname_unique UNIQUE (nickname);


--
-- Name: actors actors_actor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_actor_fk FOREIGN KEY (id_actor) REFERENCES public.actor(id);


--
-- Name: actors actors_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_film_fk FOREIGN KEY (id_film) REFERENCES public.film(id);


--
-- Name: comment comment_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_film_fk FOREIGN KEY (film_id) REFERENCES public.film(id);


--
-- Name: comment comment_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id);


--
-- Name: favourites favourites_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_film_fk FOREIGN KEY (film_id) REFERENCES public.film(id);


--
-- Name: favourites favourites_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id);


--
-- Name: genres genres_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_film_fk FOREIGN KEY (id_film) REFERENCES public.film(id);


--
-- Name: genres genres_genre_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_genre_fk FOREIGN KEY (id_genre) REFERENCES public.genre(id);


--
-- Name: grade grade_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade
    ADD CONSTRAINT grade_film_fk FOREIGN KEY (id_film) REFERENCES public.film(id);


--
-- Name: grade grade_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade
    ADD CONSTRAINT grade_user_fk FOREIGN KEY (id_user) REFERENCES public.users(id);


--
-- Name: regisseurs regisseurs_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs
    ADD CONSTRAINT regisseurs_film_fk FOREIGN KEY (id_film) REFERENCES public.film(id);


--
-- Name: regisseurs regisseurs_regisseur_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regisseurs
    ADD CONSTRAINT regisseurs_regisseur_fk FOREIGN KEY (id_regisseur) REFERENCES public.regisseur(id);


--
-- PostgreSQL database dump complete
--

\unrestrict Gex8euJZA7WOpssCX1nIIenyYJHpgOefM2ZScnWvv5vwL1BTGghyVgv12zRn11R

