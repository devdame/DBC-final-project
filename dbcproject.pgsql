--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: analyzed_posts; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE analyzed_posts (
    id integer NOT NULL,
    school_id integer,
    overall_sentiment character varying(255),
    original_publish_time character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.analyzed_posts OWNER TO andrewwittrock;

--
-- Name: analyzed_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE analyzed_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analyzed_posts_id_seq OWNER TO andrewwittrock;

--
-- Name: analyzed_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE analyzed_posts_id_seq OWNED BY analyzed_posts.id;


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE keywords (
    id integer NOT NULL,
    analyzed_post_id integer,
    text character varying(255),
    sentiment character varying(255),
    confidence double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.keywords OWNER TO andrewwittrock;

--
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keywords_id_seq OWNER TO andrewwittrock;

--
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE keywords_id_seq OWNED BY keywords.id;


--
-- Name: original_posts; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE original_posts (
    id integer NOT NULL,
    text text,
    school_id integer,
    geofeedia_school_id character varying(255),
    original_publish_time character varying(255),
    external_id character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.original_posts OWNER TO andrewwittrock;

--
-- Name: original_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE original_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.original_posts_id_seq OWNER TO andrewwittrock;

--
-- Name: original_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE original_posts_id_seq OWNED BY original_posts.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE ratings (
    id integer NOT NULL,
    topic_id integer,
    school_id integer,
    total_post_count integer DEFAULT 0,
    positive_post_count integer DEFAULT 0,
    negative_post_count integer DEFAULT 0,
    neutral_post_count integer DEFAULT 0,
    mixed_post_count integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.ratings OWNER TO andrewwittrock;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ratings_id_seq OWNER TO andrewwittrock;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE ratings_id_seq OWNED BY ratings.id;


--
-- Name: reference_words; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE reference_words (
    id integer NOT NULL,
    name character varying(255),
    canonical_name character varying(255),
    topic_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.reference_words OWNER TO andrewwittrock;

--
-- Name: reference_words_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE reference_words_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_words_id_seq OWNER TO andrewwittrock;

--
-- Name: reference_words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE reference_words_id_seq OWNED BY reference_words.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO andrewwittrock;

--
-- Name: school_word_counts; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE school_word_counts (
    id integer NOT NULL,
    school_id integer,
    reference_word_id integer,
    word_count integer DEFAULT 0,
    positive_word_count integer DEFAULT 0,
    negative_word_count integer DEFAULT 0,
    neutral_word_count integer DEFAULT 0,
    mixed_word_count integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.school_word_counts OWNER TO andrewwittrock;

--
-- Name: school_word_counts_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE school_word_counts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.school_word_counts_id_seq OWNER TO andrewwittrock;

--
-- Name: school_word_counts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE school_word_counts_id_seq OWNED BY school_word_counts.id;


--
-- Name: schools; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE schools (
    id integer NOT NULL,
    name character varying(255),
    student_body_count integer,
    first_post_time character varying(255),
    most_recent_post_time character varying(255),
    geofeedia_id character varying(255),
    post_count integer DEFAULT 0,
    positive_post_count integer DEFAULT 0,
    negative_post_count integer DEFAULT 0,
    neutral_post_count integer DEFAULT 0,
    mixed_post_count integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.schools OWNER TO andrewwittrock;

--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schools_id_seq OWNER TO andrewwittrock;

--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE TABLE topics (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.topics OWNER TO andrewwittrock;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewwittrock
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topics_id_seq OWNER TO andrewwittrock;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewwittrock
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY analyzed_posts ALTER COLUMN id SET DEFAULT nextval('analyzed_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY keywords ALTER COLUMN id SET DEFAULT nextval('keywords_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY original_posts ALTER COLUMN id SET DEFAULT nextval('original_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY ratings ALTER COLUMN id SET DEFAULT nextval('ratings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY reference_words ALTER COLUMN id SET DEFAULT nextval('reference_words_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY school_word_counts ALTER COLUMN id SET DEFAULT nextval('school_word_counts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewwittrock
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Data for Name: analyzed_posts; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY analyzed_posts (id, school_id, overall_sentiment, original_publish_time, created_at, updated_at) FROM stdin;
\.


--
-- Name: analyzed_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('analyzed_posts_id_seq', 24290, false);


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY keywords (id, analyzed_post_id, text, sentiment, confidence, created_at, updated_at) FROM stdin;
\.


--
-- Name: keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('keywords_id_seq', 51973, false);


--
-- Data for Name: original_posts; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY original_posts (id, text, school_id, geofeedia_school_id, original_publish_time, external_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: original_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('original_posts_id_seq', 1, false);


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY ratings (id, topic_id, school_id, total_post_count, positive_post_count, negative_post_count, neutral_post_count, mixed_post_count, created_at, updated_at) FROM stdin;
37	18	2	12	8	4	0	0	2014-03-25 15:09:20.876484	2014-03-25 15:17:31.791137
5	5	1	46	30	16	0	0	2014-03-25 15:09:20.840881	2014-03-25 15:17:18.746481
34	15	2	17	7	10	0	0	2014-03-25 15:09:20.87386	2014-03-25 15:17:24.857749
7	7	1	255	96	159	0	0	2014-03-25 15:09:20.843034	2014-03-25 15:17:23.415055
32	13	2	36	22	14	0	0	2014-03-25 15:09:20.87186	2014-03-25 15:17:31.865555
33	14	2	13	7	6	0	0	2014-03-25 15:09:20.873035	2014-03-25 15:17:28.670995
26	7	2	203	67	136	0	0	2014-03-25 15:09:20.865961	2014-03-25 15:17:32.611743
36	17	2	11	6	5	0	0	2014-03-25 15:09:20.875614	2014-03-25 15:17:30.262677
44	6	3	212	145	67	0	0	2014-03-25 15:09:20.886495	2014-03-25 15:16:39.790456
27	8	2	43	36	7	0	0	2014-03-25 15:09:20.866922	2014-03-25 15:17:32.679254
24	5	2	61	35	26	0	0	2014-03-25 15:09:20.863861	2014-03-25 15:17:28.728245
16	16	1	19	11	8	0	0	2014-03-25 15:09:20.851683	2014-03-25 15:14:42.545941
51	13	3	35	12	23	0	0	2014-03-25 15:09:20.893454	2014-03-25 15:16:35.847692
19	19	1	123	111	11	0	1	2014-03-25 15:09:20.854734	2014-03-25 15:17:23.974848
10	10	1	3	0	3	0	0	2014-03-25 15:09:20.845648	2014-03-25 15:14:33.886907
14	14	1	18	8	10	0	0	2014-03-25 15:09:20.849534	2014-03-25 15:14:38.947536
1	1	1	245	221	21	0	3	2014-03-25 15:09:20.79039	2014-03-25 15:17:23.978615
30	11	2	24	13	11	0	0	2014-03-25 15:09:20.869816	2014-03-25 15:17:32.749595
6	6	1	277	162	101	0	14	2014-03-25 15:09:20.842067	2014-03-25 15:17:24.026279
31	12	2	151	124	27	0	0	2014-03-25 15:09:20.870992	2014-03-25 15:17:32.770571
35	16	2	7	4	3	0	0	2014-03-25 15:09:20.87471	2014-03-25 15:17:32.822429
52	14	3	16	6	10	0	0	2014-03-25 15:09:20.894324	2014-03-25 15:16:39.318124
38	19	2	56	35	21	0	0	2014-03-25 15:09:20.877795	2014-03-25 15:17:32.825188
8	8	1	200	191	9	0	0	2014-03-25 15:09:20.84393	2014-03-25 15:17:24.11539
2	2	1	30	23	7	0	0	2014-03-25 15:09:20.793631	2014-03-25 15:17:23.076963
3	3	1	38	36	2	0	0	2014-03-25 15:09:20.795115	2014-03-25 15:14:29.194133
22	3	2	6	5	1	0	0	2014-03-25 15:09:20.861832	2014-03-25 15:17:30.643329
15	15	1	34	18	16	0	0	2014-03-25 15:09:20.850421	2014-03-25 15:17:23.237146
40	2	3	14	9	5	0	0	2014-03-25 15:09:20.882957	2014-03-25 15:16:24.295036
58	1	4	69	53	15	0	1	2014-03-25 15:09:20.903716	2014-03-25 15:17:15.619916
23	4	2	12	12	0	0	0	2014-03-25 15:09:20.862734	2014-03-25 15:17:30.667402
56	18	3	41	34	7	0	0	2014-03-25 15:09:20.898445	2014-03-25 15:16:29.653249
49	11	3	43	35	8	0	0	2014-03-25 15:09:20.891516	2014-03-25 15:16:34.320499
57	19	3	82	66	15	0	1	2014-03-25 15:09:20.899659	2014-03-25 15:16:38.733129
47	9	3	90	74	16	0	0	2014-03-25 15:09:20.889434	2014-03-25 15:16:38.757161
48	10	3	3	2	1	0	0	2014-03-25 15:09:20.890531	2014-03-25 15:16:27.546176
39	1	3	207	170	37	0	0	2014-03-25 15:09:20.882041	2014-03-25 15:16:39.444056
29	10	2	9	3	6	0	0	2014-03-25 15:09:20.868942	2014-03-25 15:15:13.245977
20	1	2	122	108	14	0	0	2014-03-25 15:09:20.859919	2014-03-25 15:17:32.974801
62	5	4	88	58	30	0	0	2014-03-25 15:09:20.907795	2014-03-25 15:17:15.669626
21	2	2	17	15	2	0	0	2014-03-25 15:09:20.860929	2014-03-25 15:17:31.705038
67	10	4	3	2	1	0	0	2014-03-25 15:09:20.912495	2014-03-25 15:17:14.90135
41	3	3	23	16	7	0	0	2014-03-25 15:09:20.883902	2014-03-25 15:16:37.532022
60	3	4	5	4	1	0	0	2014-03-25 15:09:20.905736	2014-03-25 15:17:10.350558
45	7	3	165	108	57	0	0	2014-03-25 15:09:20.887399	2014-03-25 15:16:39.479231
9	9	1	55	40	15	0	0	2014-03-25 15:09:20.844789	2014-03-25 15:17:21.119212
65	8	4	40	36	4	0	0	2014-03-25 15:09:20.910829	2014-03-25 15:17:14.951147
76	19	4	24	19	5	0	0	2014-03-25 15:09:20.920934	2014-03-25 15:17:12.459008
43	5	3	61	47	14	0	0	2014-03-25 15:09:20.885644	2014-03-25 15:16:37.941651
53	15	3	62	42	20	0	0	2014-03-25 15:09:20.895515	2014-03-25 15:16:39.602021
55	17	3	28	17	11	0	0	2014-03-25 15:09:20.897565	2014-03-25 15:16:27.693215
50	12	3	419	381	38	0	0	2014-03-25 15:09:20.892436	2014-03-25 15:16:39.628465
68	11	4	10	7	3	0	0	2014-03-25 15:09:20.913393	2014-03-25 15:17:10.436032
46	8	3	89	77	12	0	0	2014-03-25 15:09:20.888331	2014-03-25 15:16:39.771751
54	16	3	9	4	5	0	0	2014-03-25 15:09:20.896402	2014-03-25 15:16:37.980208
42	4	3	41	35	6	0	0	2014-03-25 15:09:20.884794	2014-03-25 15:16:39.786375
71	14	4	7	2	5	0	0	2014-03-25 15:09:20.916021	2014-03-25 15:17:11.061963
11	11	1	84	79	5	0	0	2014-03-25 15:09:20.84656	2014-03-25 15:17:21.18895
70	13	4	21	8	13	0	0	2014-03-25 15:09:20.915134	2014-03-25 15:17:15.030221
75	18	4	19	19	0	0	0	2014-03-25 15:09:20.920005	2014-03-25 15:17:12.462552
74	17	4	6	6	0	0	0	2014-03-25 15:09:20.918882	2014-03-25 15:17:11.11028
13	13	1	108	41	66	0	1	2014-03-25 15:09:20.848354	2014-03-25 15:17:24.260231
28	9	2	41	31	10	0	0	2014-03-25 15:09:20.867808	2014-03-25 15:17:33.449331
66	9	4	19	16	3	0	0	2014-03-25 15:09:20.911647	2014-03-25 15:17:14.275838
63	6	4	70	53	17	0	0	2014-03-25 15:09:20.908808	2014-03-25 15:17:16.392096
64	7	4	72	41	28	0	3	2014-03-25 15:09:20.909705	2014-03-25 15:17:14.28635
72	15	4	16	12	4	0	0	2014-03-25 15:09:20.917007	2014-03-25 15:17:15.134439
4	4	1	35	35	0	0	0	2014-03-25 15:09:20.796149	2014-03-25 15:17:22.565854
25	6	2	76	53	23	0	0	2014-03-25 15:09:20.86479	2014-03-25 15:17:33.468473
17	17	1	98	65	30	1	2	2014-03-25 15:09:20.852677	2014-03-25 15:17:22.090794
61	4	4	8	8	0	0	0	2014-03-25 15:09:20.906632	2014-03-25 15:17:12.714356
18	18	1	21	18	3	0	0	2014-03-25 15:09:20.853686	2014-03-25 15:17:24.398958
73	16	4	10	4	6	0	0	2014-03-25 15:09:20.917984	2014-03-25 15:17:12.193566
69	12	4	167	144	23	0	0	2014-03-25 15:09:20.914293	2014-03-25 15:17:16.576274
59	2	4	9	4	5	0	0	2014-03-25 15:09:20.904645	2014-03-25 15:17:08.310412
12	12	1	317	245	71	0	1	2014-03-25 15:09:20.847476	2014-03-25 15:17:24.599151
\.


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('ratings_id_seq', 76, true);


--
-- Data for Name: reference_words; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY reference_words (id, name, canonical_name, topic_id, created_at, updated_at) FROM stdin;
1	nerd	nerd	3	2014-03-25 15:09:12.206019	2014-03-25 15:09:12.206019
2	geek	geek	3	2014-03-25 15:09:12.212105	2014-03-25 15:09:12.212105
3	nerds	nerds	3	2014-03-25 15:09:12.21532	2014-03-25 15:09:12.21532
4	geeks	geeks	3	2014-03-25 15:09:12.218864	2014-03-25 15:09:12.218864
5	xbox	xbox	3	2014-03-25 15:09:12.222627	2014-03-25 15:09:12.222627
6	ps4	ps4	3	2014-03-25 15:09:12.225967	2014-03-25 15:09:12.225967
7	ps3	ps3	3	2014-03-25 15:09:12.229223	2014-03-25 15:09:12.229223
8	super nintendo	supernintendo	3	2014-03-25 15:09:12.232299	2014-03-25 15:09:12.232299
9	nintendo	nintendo	3	2014-03-25 15:09:12.235382	2014-03-25 15:09:12.235382
10	wii	wii	3	2014-03-25 15:09:12.238637	2014-03-25 15:09:12.238637
11	nintendo wii	nintendowii	3	2014-03-25 15:09:12.241858	2014-03-25 15:09:12.241858
12	n64	n64	3	2014-03-25 15:09:12.245354	2014-03-25 15:09:12.245354
13	miyazaki	miyazaki	3	2014-03-25 15:09:12.248942	2014-03-25 15:09:12.248942
14	totoro	totoro	3	2014-03-25 15:09:12.252409	2014-03-25 15:09:12.252409
15	spirited away	spiritedaway	3	2014-03-25 15:09:12.255794	2014-03-25 15:09:12.255794
16	cat bus	catbus	3	2014-03-25 15:09:12.258928	2014-03-25 15:09:12.258928
17	howl's moving castle	howl'smovingcastle	3	2014-03-25 15:09:12.262125	2014-03-25 15:09:12.262125
18	princess mononoke	princessmononoke	3	2014-03-25 15:09:12.265398	2014-03-25 15:09:12.265398
19	ponyo	ponyo	3	2014-03-25 15:09:12.268157	2014-03-25 15:09:12.268157
20	lego	lego	3	2014-03-25 15:09:12.271365	2014-03-25 15:09:12.271365
21	legos	legos	3	2014-03-25 15:09:12.27482	2014-03-25 15:09:12.27482
22	lego movie	legomovie	3	2014-03-25 15:09:12.278235	2014-03-25 15:09:12.278235
23	mini fig	minifig	3	2014-03-25 15:09:12.281328	2014-03-25 15:09:12.281328
24	mini figs	minifigs	3	2014-03-25 15:09:12.284123	2014-03-25 15:09:12.284123
25	lego mania	legomania	3	2014-03-25 15:09:12.287277	2014-03-25 15:09:12.287277
26	pottermania	pottermania	3	2014-03-25 15:09:12.29052	2014-03-25 15:09:12.29052
27	muppets	muppets	3	2014-03-25 15:09:12.293232	2014-03-25 15:09:12.293232
28	the mary sue	themarysue	3	2014-03-25 15:09:12.296358	2014-03-25 15:09:12.296358
29	io9	io9	3	2014-03-25 15:09:12.299853	2014-03-25 15:09:12.299853
30	spec fic	specfic	3	2014-03-25 15:09:12.303432	2014-03-25 15:09:12.303432
31	anime	anime	3	2014-03-25 15:09:12.307022	2014-03-25 15:09:12.307022
32	cowboy bebop	cowboybebop	3	2014-03-25 15:09:12.310424	2014-03-25 15:09:12.310424
33	fanfic	fanfic	3	2014-03-25 15:09:12.313708	2014-03-25 15:09:12.313708
34	fanfiction	fanfiction	3	2014-03-25 15:09:12.316931	2014-03-25 15:09:12.316931
35	fan-fic	fan-fic	3	2014-03-25 15:09:12.320103	2014-03-25 15:09:12.320103
36	fan-fiction	fan-fiction	3	2014-03-25 15:09:12.323221	2014-03-25 15:09:12.323221
37	fangirl	fangirl	3	2014-03-25 15:09:12.326792	2014-03-25 15:09:12.326792
38	fangirling	fangirling	3	2014-03-25 15:09:12.329886	2014-03-25 15:09:12.329886
39	geeking out	geekingout	3	2014-03-25 15:09:12.333115	2014-03-25 15:09:12.333115
40	geek out	geekout	3	2014-03-25 15:09:12.374589	2014-03-25 15:09:12.374589
41	geeked out	geekedout	3	2014-03-25 15:09:12.378575	2014-03-25 15:09:12.378575
42	speculative fiction	speculativefiction	3	2014-03-25 15:09:12.381871	2014-03-25 15:09:12.381871
43	manga	manga	3	2014-03-25 15:09:12.384978	2014-03-25 15:09:12.384978
44	gameboy	gameboy	3	2014-03-25 15:09:12.388188	2014-03-25 15:09:12.388188
45	playstation	playstation	3	2014-03-25 15:09:12.390994	2014-03-25 15:09:12.390994
46	league	league	3	2014-03-25 15:09:12.394217	2014-03-25 15:09:12.394217
47	the guild	theguild	3	2014-03-25 15:09:12.396972	2014-03-25 15:09:12.396972
48	armor	armor	3	2014-03-25 15:09:12.4003	2014-03-25 15:09:12.4003
49	chain mail	chainmail	3	2014-03-25 15:09:12.403041	2014-03-25 15:09:12.403041
50	ren faire	renfaire	3	2014-03-25 15:09:12.405585	2014-03-25 15:09:12.405585
51	ren fest	renfest	3	2014-03-25 15:09:12.40859	2014-03-25 15:09:12.40859
52	renaissance faire	renaissancefaire	3	2014-03-25 15:09:12.41165	2014-03-25 15:09:12.41165
53	renaissance fair	renaissancefair	3	2014-03-25 15:09:12.414684	2014-03-25 15:09:12.414684
54	ren fair	renfair	3	2014-03-25 15:09:12.417827	2014-03-25 15:09:12.417827
55	wand	wand	3	2014-03-25 15:09:12.421485	2014-03-25 15:09:12.421485
56	critical hit	criticalhit	3	2014-03-25 15:09:12.424668	2014-03-25 15:09:12.424668
57	critical fail	criticalfail	3	2014-03-25 15:09:12.427548	2014-03-25 15:09:12.427548
58	critical failure	criticalfailure	3	2014-03-25 15:09:12.430785	2014-03-25 15:09:12.430785
59	nat 20	nat20	3	2014-03-25 15:09:12.433735	2014-03-25 15:09:12.433735
60	natural 20	natural20	3	2014-03-25 15:09:12.436908	2014-03-25 15:09:12.436908
61	nat 1	nat1	3	2014-03-25 15:09:12.439575	2014-03-25 15:09:12.439575
62	natural 1	natural1	3	2014-03-25 15:09:12.442828	2014-03-25 15:09:12.442828
63	natural twenty	naturaltwenty	3	2014-03-25 15:09:12.445761	2014-03-25 15:09:12.445761
64	nat twenty	nattwenty	3	2014-03-25 15:09:12.448715	2014-03-25 15:09:12.448715
65	natural one	naturalone	3	2014-03-25 15:09:12.452209	2014-03-25 15:09:12.452209
66	nat one	natone	3	2014-03-25 15:09:12.455169	2014-03-25 15:09:12.455169
67	roll a critical	rollacritical	3	2014-03-25 15:09:12.458512	2014-03-25 15:09:12.458512
68	roll a nat 20	rollanat20	3	2014-03-25 15:09:12.461457	2014-03-25 15:09:12.461457
69	roll for initiative	rollforinitiative	3	2014-03-25 15:09:12.464468	2014-03-25 15:09:12.464468
70	charisma score	charismascore	3	2014-03-25 15:09:12.467595	2014-03-25 15:09:12.467595
71	intelligence score	intelligencescore	3	2014-03-25 15:09:12.470597	2014-03-25 15:09:12.470597
72	wisdom score	wisdomscore	3	2014-03-25 15:09:12.47369	2014-03-25 15:09:12.47369
73	strength score	strengthscore	3	2014-03-25 15:09:12.476754	2014-03-25 15:09:12.476754
74	constitution score	constitutionscore	3	2014-03-25 15:09:12.479624	2014-03-25 15:09:12.479624
75	dexterity score	dexterityscore	3	2014-03-25 15:09:12.482868	2014-03-25 15:09:12.482868
76	character sheet	charactersheet	3	2014-03-25 15:09:12.486271	2014-03-25 15:09:12.486271
77	d&d session	d&dsession	3	2014-03-25 15:09:12.48944	2014-03-25 15:09:12.48944
78	d&d game	d&dgame	3	2014-03-25 15:09:12.492911	2014-03-25 15:09:12.492911
79	bioshock	bioshock	3	2014-03-25 15:09:12.496213	2014-03-25 15:09:12.496213
80	bioshock infinite	bioshockinfinite	3	2014-03-25 15:09:12.499486	2014-03-25 15:09:12.499486
81	minecraft	minecraft	3	2014-03-25 15:09:12.504185	2014-03-25 15:09:12.504185
82	lolcats	lolcats	3	2014-03-25 15:09:12.507408	2014-03-25 15:09:12.507408
83	lolcat	lolcat	3	2014-03-25 15:09:12.5104	2014-03-25 15:09:12.5104
84	doge	doge	3	2014-03-25 15:09:12.513114	2014-03-25 15:09:12.513114
85	bitcoin	bitcoin	3	2014-03-25 15:09:12.51591	2014-03-25 15:09:12.51591
86	dogecoin	dogecoin	3	2014-03-25 15:09:12.518717	2014-03-25 15:09:12.518717
87	japanophile	japanophile	3	2014-03-25 15:09:12.521549	2014-03-25 15:09:12.521549
88	doctor who	doctorwho	3	2014-03-25 15:09:12.524735	2014-03-25 15:09:12.524735
89	dr who	drwho	3	2014-03-25 15:09:12.527644	2014-03-25 15:09:12.527644
90	dr. who	dr.who	3	2014-03-25 15:09:12.530732	2014-03-25 15:09:12.530732
91	dalek	dalek	3	2014-03-25 15:09:12.533846	2014-03-25 15:09:12.533846
92	cyberman	cyberman	3	2014-03-25 15:09:12.536894	2014-03-25 15:09:12.536894
93	cybermen	cybermen	3	2014-03-25 15:09:12.540081	2014-03-25 15:09:12.540081
94	daleks	daleks	3	2014-03-25 15:09:12.542726	2014-03-25 15:09:12.542726
95	whovian	whovian	3	2014-03-25 15:09:12.546274	2014-03-25 15:09:12.546274
96	matt smith	mattsmith	3	2014-03-25 15:09:12.549192	2014-03-25 15:09:12.549192
97	david tennant	davidtennant	3	2014-03-25 15:09:12.552026	2014-03-25 15:09:12.552026
98	nerd rage	nerdrage	3	2014-03-25 15:09:12.555489	2014-03-25 15:09:12.555489
99	liz lemon	lizlemon	3	2014-03-25 15:09:12.558948	2014-03-25 15:09:12.558948
100	30 rock	30rock	3	2014-03-25 15:09:12.562597	2014-03-25 15:09:12.562597
101	peter capaldi	petercapaldi	3	2014-03-25 15:09:12.565479	2014-03-25 15:09:12.565479
102	capaldi	capaldi	3	2014-03-25 15:09:12.56863	2014-03-25 15:09:12.56863
103	firefly	firefly	3	2014-03-25 15:09:12.57217	2014-03-25 15:09:12.57217
104	whedon	whedon	3	2014-03-25 15:09:12.575861	2014-03-25 15:09:12.575861
105	joss whedon	josswhedon	3	2014-03-25 15:09:12.578745	2014-03-25 15:09:12.578745
106	buffy	buffy	3	2014-03-25 15:09:12.581781	2014-03-25 15:09:12.581781
107	btvs	btvs	3	2014-03-25 15:09:12.584776	2014-03-25 15:09:12.584776
108	scifi	scifi	3	2014-03-25 15:09:12.587798	2014-03-25 15:09:12.587798
109	reddit	reddit	3	2014-03-25 15:09:12.591785	2014-03-25 15:09:12.591785
110	star wars	starwars	3	2014-03-25 15:09:12.59499	2014-03-25 15:09:12.59499
111	star trek	startrek	3	2014-03-25 15:09:12.598293	2014-03-25 15:09:12.598293
112	trekkie	trekkie	3	2014-03-25 15:09:12.601222	2014-03-25 15:09:12.601222
113	trekkies	trekkies	3	2014-03-25 15:09:12.604243	2014-03-25 15:09:12.604243
114	trekker	trekker	3	2014-03-25 15:09:12.60738	2014-03-25 15:09:12.60738
115	trekkers	trekkers	3	2014-03-25 15:09:12.610528	2014-03-25 15:09:12.610528
116	meme	meme	3	2014-03-25 15:09:12.613552	2014-03-25 15:09:12.613552
117	nerdcore	nerdcore	3	2014-03-25 15:09:12.616737	2014-03-25 15:09:12.616737
118	nerdfighter	nerdfighter	3	2014-03-25 15:09:12.620093	2014-03-25 15:09:12.620093
119	nerdfighters	nerdfighters	3	2014-03-25 15:09:12.623722	2014-03-25 15:09:12.623722
120	nerdfighteria	nerdfighteria	3	2014-03-25 15:09:12.628138	2014-03-25 15:09:12.628138
121	cosplay	cosplay	3	2014-03-25 15:09:12.631339	2014-03-25 15:09:12.631339
122	dungeons and dragons	dungeonsanddragons	3	2014-03-25 15:09:12.634976	2014-03-25 15:09:12.634976
123	dungeons & dragons	dungeons&dragons	3	2014-03-25 15:09:12.638605	2014-03-25 15:09:12.638605
124	d&d	d&d	3	2014-03-25 15:09:12.641714	2014-03-25 15:09:12.641714
125	d20	d20	3	2014-03-25 15:09:12.645061	2014-03-25 15:09:12.645061
126	20 sided die	20sideddie	3	2014-03-25 15:09:12.648144	2014-03-25 15:09:12.648144
127	dice set	diceset	3	2014-03-25 15:09:12.6511	2014-03-25 15:09:12.6511
128	set of dice	setofdice	3	2014-03-25 15:09:12.654228	2014-03-25 15:09:12.654228
129	twenty sided die	twentysideddie	3	2014-03-25 15:09:12.65761	2014-03-25 15:09:12.65761
130	d10	d10	3	2014-03-25 15:09:12.660889	2014-03-25 15:09:12.660889
131	d12	d12	3	2014-03-25 15:09:12.663814	2014-03-25 15:09:12.663814
132	d8	d8	3	2014-03-25 15:09:12.667283	2014-03-25 15:09:12.667283
133	d4	d4	3	2014-03-25 15:09:12.670414	2014-03-25 15:09:12.670414
134	rpg	rpg	3	2014-03-25 15:09:12.673864	2014-03-25 15:09:12.673864
135	role playing game	roleplayinggame	3	2014-03-25 15:09:12.67697	2014-03-25 15:09:12.67697
136	tabletop	tabletop	3	2014-03-25 15:09:12.680489	2014-03-25 15:09:12.680489
137	tabletop game	tabletopgame	3	2014-03-25 15:09:12.683877	2014-03-25 15:09:12.683877
138	settlers of catan	settlersofcatan	3	2014-03-25 15:09:12.687244	2014-03-25 15:09:12.687244
139	catan	catan	3	2014-03-25 15:09:12.690222	2014-03-25 15:09:12.690222
140	board games	boardgames	3	2014-03-25 15:09:12.693207	2014-03-25 15:09:12.693207
141	board game	boardgame	3	2014-03-25 15:09:12.696304	2014-03-25 15:09:12.696304
142	munchkin	munchkin	3	2014-03-25 15:09:12.699083	2014-03-25 15:09:12.699083
143	four chan	fourchan	3	2014-03-25 15:09:12.70239	2014-03-25 15:09:12.70239
144	4chan	4chan	3	2014-03-25 15:09:12.705346	2014-03-25 15:09:12.705346
145	comics	comics	3	2014-03-25 15:09:12.708971	2014-03-25 15:09:12.708971
146	marvel	marvel	3	2014-03-25 15:09:12.71197	2014-03-25 15:09:12.71197
147	dc comics	dccomics	3	2014-03-25 15:09:12.715468	2014-03-25 15:09:12.715468
148	orphan black	orphanblack	3	2014-03-25 15:09:12.718527	2014-03-25 15:09:12.718527
149	agents of shield	agentsofshield	3	2014-03-25 15:09:12.722014	2014-03-25 15:09:12.722014
150	agents of s.h.i.e.l.d.	agentsofs.h.i.e.l.d.	3	2014-03-25 15:09:12.725188	2014-03-25 15:09:12.725188
151	pi	pi	3	2014-03-25 15:09:12.728566	2014-03-25 15:09:12.728566
152	magic	magic	3	2014-03-25 15:09:12.731612	2014-03-25 15:09:12.731612
153	magic the gathering	magicthegathering	3	2014-03-25 15:09:12.735022	2014-03-25 15:09:12.735022
154	magic cards	magiccards	3	2014-03-25 15:09:12.73806	2014-03-25 15:09:12.73806
155	miniatures	miniatures	3	2014-03-25 15:09:12.74115	2014-03-25 15:09:12.74115
156	battle mat	battlemat	3	2014-03-25 15:09:12.744401	2014-03-25 15:09:12.744401
157	battle board	battleboard	3	2014-03-25 15:09:12.748037	2014-03-25 15:09:12.748037
158	world of warcraft	worldofwarcraft	3	2014-03-25 15:09:12.751182	2014-03-25 15:09:12.751182
159	w.o.w.	w.o.w.	3	2014-03-25 15:09:12.754265	2014-03-25 15:09:12.754265
160	newb	newb	3	2014-03-25 15:09:12.757597	2014-03-25 15:09:12.757597
161	noob	noob	3	2014-03-25 15:09:12.760593	2014-03-25 15:09:12.760593
162	n00b	n00b	3	2014-03-25 15:09:12.763712	2014-03-25 15:09:12.763712
163	pwn	pwn	3	2014-03-25 15:09:12.766705	2014-03-25 15:09:12.766705
164	pwned	pwned	3	2014-03-25 15:09:12.769911	2014-03-25 15:09:12.769911
165	night cheese	nightcheese	3	2014-03-25 15:09:12.772921	2014-03-25 15:09:12.772921
166	adventure time	adventuretime	3	2014-03-25 15:09:12.776046	2014-03-25 15:09:12.776046
167	finn and jake	finnandjake	3	2014-03-25 15:09:12.779095	2014-03-25 15:09:12.779095
168	lsp	lsp	3	2014-03-25 15:09:12.782249	2014-03-25 15:09:12.782249
169	lumpy space princess	lumpyspaceprincess	3	2014-03-25 15:09:12.785021	2014-03-25 15:09:12.785021
170	princess bubblegum	princessbubblegum	3	2014-03-25 15:09:12.787921	2014-03-25 15:09:12.787921
171	marceline	marceline	3	2014-03-25 15:09:12.790723	2014-03-25 15:09:12.790723
172	the ice king	theiceking	3	2014-03-25 15:09:12.794079	2014-03-25 15:09:12.794079
173	amy pond	amypond	3	2014-03-25 15:09:12.796954	2014-03-25 15:09:12.796954
174	tardis	tardis	3	2014-03-25 15:09:12.800175	2014-03-25 15:09:12.800175
175	the tardis	thetardis	3	2014-03-25 15:09:12.803467	2014-03-25 15:09:12.803467
176	sonic screwdriver	sonicscrewdriver	3	2014-03-25 15:09:12.806733	2014-03-25 15:09:12.806733
177	tribbles	tribbles	3	2014-03-25 15:09:12.81015	2014-03-25 15:09:12.81015
178	george takei	georgetakei	3	2014-03-25 15:09:12.813171	2014-03-25 15:09:12.813171
179	takei	takei	3	2014-03-25 15:09:12.816382	2014-03-25 15:09:12.816382
180	sulu	sulu	3	2014-03-25 15:09:12.819559	2014-03-25 15:09:12.819559
181	captain kirk	captainkirk	3	2014-03-25 15:09:12.822837	2014-03-25 15:09:12.822837
182	janeway	janeway	3	2014-03-25 15:09:12.853399	2014-03-25 15:09:12.853399
183	picard	picard	3	2014-03-25 15:09:12.858022	2014-03-25 15:09:12.858022
184	captain picard	captainpicard	3	2014-03-25 15:09:12.862299	2014-03-25 15:09:12.862299
185	jean luc picard	jeanlucpicard	3	2014-03-25 15:09:12.865962	2014-03-25 15:09:12.865962
186	captain janeway	captainjaneway	3	2014-03-25 15:09:12.870072	2014-03-25 15:09:12.870072
187	spock	spock	3	2014-03-25 15:09:12.87414	2014-03-25 15:09:12.87414
188	big bangthe big bang	bigbangthebigbang	3	2014-03-25 15:09:12.877999	2014-03-25 15:09:12.877999
189	the big bang theory	thebigbangtheory	3	2014-03-25 15:09:12.88152	2014-03-25 15:09:12.88152
190	fake geek girl	fakegeekgirl	3	2014-03-25 15:09:12.885372	2014-03-25 15:09:12.885372
191	fake geek girls	fakegeekgirls	3	2014-03-25 15:09:12.889106	2014-03-25 15:09:12.889106
192	geek girl	geekgirl	3	2014-03-25 15:09:12.893098	2014-03-25 15:09:12.893098
193	geek girls	geekgirls	3	2014-03-25 15:09:12.896867	2014-03-25 15:09:12.896867
194	think geek	thinkgeek	3	2014-03-25 15:09:12.900738	2014-03-25 15:09:12.900738
195	futurama	futurama	3	2014-03-25 15:09:12.904724	2014-03-25 15:09:12.904724
196	sci-fi	sci-fi	3	2014-03-25 15:09:12.910176	2014-03-25 15:09:12.910176
197	syfy	syfy	3	2014-03-25 15:09:12.913985	2014-03-25 15:09:12.913985
198	game of thrones	gameofthrones	3	2014-03-25 15:09:12.917589	2014-03-25 15:09:12.917589
199	winter is coming	winteriscoming	3	2014-03-25 15:09:12.921395	2014-03-25 15:09:12.921395
200	westeros	westeros	3	2014-03-25 15:09:12.925538	2014-03-25 15:09:12.925538
201	the cones of dunshire	theconesofdunshire	3	2014-03-25 15:09:12.929205	2014-03-25 15:09:12.929205
202	cones of dunshire	conesofdunshire	3	2014-03-25 15:09:12.933247	2014-03-25 15:09:12.933247
203	leslie knope	leslieknope	3	2014-03-25 15:09:12.937219	2014-03-25 15:09:12.937219
204	ben wyatt	benwyatt	3	2014-03-25 15:09:12.941311	2014-03-25 15:09:12.941311
205	torchwood	torchwood	3	2014-03-25 15:09:12.987056	2014-03-25 15:09:12.987056
206	jack harkness	jackharkness	3	2014-03-25 15:09:12.99101	2014-03-25 15:09:12.99101
207	river song	riversong	3	2014-03-25 15:09:12.99424	2014-03-25 15:09:12.99424
208	face of bo	faceofbo	3	2014-03-25 15:09:12.997023	2014-03-25 15:09:12.997023
209	geronimo	geronimo	3	2014-03-25 15:09:12.999867	2014-03-25 15:09:12.999867
210	the girl who waited	thegirlwhowaited	3	2014-03-25 15:09:13.003176	2014-03-25 15:09:13.003176
211	harry potter	harrypotter	3	2014-03-25 15:09:13.006111	2014-03-25 15:09:13.006111
212	the boy who lived	theboywholived	3	2014-03-25 15:09:13.009053	2014-03-25 15:09:13.009053
213	voldemort	voldemort	3	2014-03-25 15:09:13.012232	2014-03-25 15:09:13.012232
214	rowling	rowling	3	2014-03-25 15:09:13.015156	2014-03-25 15:09:13.015156
215	hermione granger	hermionegranger	3	2014-03-25 15:09:13.018458	2014-03-25 15:09:13.018458
216	ron weasley	ronweasley	3	2014-03-25 15:09:13.02125	2014-03-25 15:09:13.02125
217	snape	snape	3	2014-03-25 15:09:13.024519	2014-03-25 15:09:13.024519
218	severus snape	severussnape	3	2014-03-25 15:09:13.027716	2014-03-25 15:09:13.027716
219	marvel vs dc	marvelvsdc	3	2014-03-25 15:09:13.030773	2014-03-25 15:09:13.030773
220	dc vs marvel	dcvsmarvel	3	2014-03-25 15:09:13.033796	2014-03-25 15:09:13.033796
221	mischief managed	mischiefmanaged	3	2014-03-25 15:09:13.036725	2014-03-25 15:09:13.036725
222	time travel	timetravel	3	2014-03-25 15:09:13.03987	2014-03-25 15:09:13.03987
223	space time	spacetime	3	2014-03-25 15:09:13.042888	2014-03-25 15:09:13.042888
224	spacetime	spacetime	3	2014-03-25 15:09:13.046028	2014-03-25 15:09:13.046028
225	space time continuum	spacetimecontinuum	3	2014-03-25 15:09:13.049185	2014-03-25 15:09:13.049185
226	the verse	theverse	3	2014-03-25 15:09:13.052239	2014-03-25 15:09:13.052239
227	buffy the vampire slayer	buffythevampireslayer	3	2014-03-25 15:09:13.056532	2014-03-25 15:09:13.056532
228	dragons	dragons	3	2014-03-25 15:09:13.060179	2014-03-25 15:09:13.060179
229	king cobra	kingcobra	6	2014-03-25 15:09:13.063163	2014-03-25 15:09:13.063163
230	schwasted	schwasted	6	2014-03-25 15:09:13.065973	2014-03-25 15:09:13.065973
231	schwasty	schwasty	6	2014-03-25 15:09:13.069493	2014-03-25 15:09:13.069493
232	40 oz	40oz	6	2014-03-25 15:09:13.073734	2014-03-25 15:09:13.073734
233	40s	40s	6	2014-03-25 15:09:13.077608	2014-03-25 15:09:13.077608
234	forties	forties	6	2014-03-25 15:09:13.080862	2014-03-25 15:09:13.080862
235	fourtys	fourtys	6	2014-03-25 15:09:13.084099	2014-03-25 15:09:13.084099
236	shenanigans	shenanigans	6	2014-03-25 15:09:13.08732	2014-03-25 15:09:13.08732
237	fotie	fotie	6	2014-03-25 15:09:13.090388	2014-03-25 15:09:13.090388
238	foties	foties	6	2014-03-25 15:09:13.093756	2014-03-25 15:09:13.093756
239	rally	rally	6	2014-03-25 15:09:13.096519	2014-03-25 15:09:13.096519
240	boones farm	boonesfarm	6	2014-03-25 15:09:13.099578	2014-03-25 15:09:13.099578
241	boone's farm	boone'sfarm	6	2014-03-25 15:09:13.102885	2014-03-25 15:09:13.102885
242	mad dog	maddog	6	2014-03-25 15:09:13.105764	2014-03-25 15:09:13.105764
243	drunk life	drunklife	6	2014-03-25 15:09:13.108877	2014-03-25 15:09:13.108877
244	high life	highlife	6	2014-03-25 15:09:13.111865	2014-03-25 15:09:13.111865
245	franzia	franzia	6	2014-03-25 15:09:13.115237	2014-03-25 15:09:13.115237
246	box wine	boxwine	6	2014-03-25 15:09:13.119062	2014-03-25 15:09:13.119062
247	boxed wine	boxedwine	6	2014-03-25 15:09:13.122117	2014-03-25 15:09:13.122117
248	chillable red	chillablered	6	2014-03-25 15:09:13.125208	2014-03-25 15:09:13.125208
249	liquor store	liquorstore	6	2014-03-25 15:09:13.128371	2014-03-25 15:09:13.128371
250	party hard	partyhard	6	2014-03-25 15:09:13.131684	2014-03-25 15:09:13.131684
251	party hardy	partyhardy	6	2014-03-25 15:09:13.134742	2014-03-25 15:09:13.134742
252	get shitty	getshitty	6	2014-03-25 15:09:13.137911	2014-03-25 15:09:13.137911
253	St Patty	stpatty	6	2014-03-25 15:09:13.141404	2014-03-25 15:09:13.141404
254	St. Patty's	st.patty's	6	2014-03-25 15:09:13.144712	2014-03-25 15:09:13.144712
255	fancy drinks	fancydrinks	6	2014-03-25 15:09:13.147821	2014-03-25 15:09:13.147821
256	struggle bus	strugglebus	6	2014-03-25 15:09:13.15106	2014-03-25 15:09:13.15106
257	circle of death	circleofdeath	6	2014-03-25 15:09:13.15411	2014-03-25 15:09:13.15411
258	kings cup	kingscup	6	2014-03-25 15:09:13.157107	2014-03-25 15:09:13.157107
259	king's cup	king'scup	6	2014-03-25 15:09:13.160112	2014-03-25 15:09:13.160112
260	darts	darts	6	2014-03-25 15:09:13.16325	2014-03-25 15:09:13.16325
261	taco bell	tacobell	6	2014-03-25 15:09:13.166386	2014-03-25 15:09:13.166386
262	saturday night	saturdaynight	6	2014-03-25 15:09:13.169384	2014-03-25 15:09:13.169384
263	friday night	fridaynight	6	2014-03-25 15:09:13.172262	2014-03-25 15:09:13.172262
264	tgif	tgif	6	2014-03-25 15:09:13.175401	2014-03-25 15:09:13.175401
265	beer porn	beerporn	6	2014-03-25 15:09:13.178732	2014-03-25 15:09:13.178732
266	beer snob	beersnob	6	2014-03-25 15:09:13.18164	2014-03-25 15:09:13.18164
267	beergasm	beergasm	6	2014-03-25 15:09:13.184702	2014-03-25 15:09:13.184702
268	beerstagram	beerstagram	6	2014-03-25 15:09:13.187757	2014-03-25 15:09:13.187757
269	craft beer	craftbeer	6	2014-03-25 15:09:13.190747	2014-03-25 15:09:13.190747
270	hangover	hangover	6	2014-03-25 15:09:13.193794	2014-03-25 15:09:13.193794
271	hung over	hungover	6	2014-03-25 15:09:13.197117	2014-03-25 15:09:13.197117
272	so hung over	sohungover	6	2014-03-25 15:09:13.200649	2014-03-25 15:09:13.200649
273	hung over as shit	hungoverasshit	6	2014-03-25 15:09:13.20394	2014-03-25 15:09:13.20394
274	huge hangover	hugehangover	6	2014-03-25 15:09:13.207126	2014-03-25 15:09:13.207126
275	party on	partyon	6	2014-03-25 15:09:13.21065	2014-03-25 15:09:13.21065
276	hookah	hookah	6	2014-03-25 15:09:13.214206	2014-03-25 15:09:13.214206
277	hookah bar	hookahbar	6	2014-03-25 15:09:13.217551	2014-03-25 15:09:13.217551
278	jack daniels	jackdaniels	6	2014-03-25 15:09:13.220344	2014-03-25 15:09:13.220344
279	jim beam	jimbeam	6	2014-03-25 15:09:13.22356	2014-03-25 15:09:13.22356
280	jameson	jameson	6	2014-03-25 15:09:13.226988	2014-03-25 15:09:13.226988
281	captain morgan	captainmorgan	6	2014-03-25 15:09:13.230209	2014-03-25 15:09:13.230209
282	moonshine	moonshine	6	2014-03-25 15:09:13.233287	2014-03-25 15:09:13.233287
283	smirnoff	smirnoff	6	2014-03-25 15:09:13.236262	2014-03-25 15:09:13.236262
284	absolut	absolut	6	2014-03-25 15:09:13.23946	2014-03-25 15:09:13.23946
285	312	312	6	2014-03-25 15:09:13.242535	2014-03-25 15:09:13.242535
286	goose island	gooseisland	6	2014-03-25 15:09:13.245619	2014-03-25 15:09:13.245619
287	whiskey sour	whiskeysour	6	2014-03-25 15:09:13.248695	2014-03-25 15:09:13.248695
288	gin and tonic	ginandtonic	6	2014-03-25 15:09:13.251743	2014-03-25 15:09:13.251743
289	whiskey coke	whiskeycoke	6	2014-03-25 15:09:13.254686	2014-03-25 15:09:13.254686
290	whiskey and diet	whiskeyanddiet	6	2014-03-25 15:09:13.25788	2014-03-25 15:09:13.25788
291	whisky	whisky	6	2014-03-25 15:09:13.260834	2014-03-25 15:09:13.260834
292	absinthe	absinthe	6	2014-03-25 15:09:13.26376	2014-03-25 15:09:13.26376
293	ouzo	ouzo	6	2014-03-25 15:09:13.266986	2014-03-25 15:09:13.266986
294	jager bomb	jagerbomb	6	2014-03-25 15:09:13.269774	2014-03-25 15:09:13.269774
295	sake	sake	6	2014-03-25 15:09:13.273111	2014-03-25 15:09:13.273111
296	sake bomb	sakebomb	6	2014-03-25 15:09:13.276346	2014-03-25 15:09:13.276346
297	sake bombs	sakebombs	6	2014-03-25 15:09:13.279283	2014-03-25 15:09:13.279283
298	jager bombs	jagerbombs	6	2014-03-25 15:09:13.282364	2014-03-25 15:09:13.282364
299	corona	corona	6	2014-03-25 15:09:13.285467	2014-03-25 15:09:13.285467
300	heineken	heineken	6	2014-03-25 15:09:13.288594	2014-03-25 15:09:13.288594
301	dos equis	dosequis	6	2014-03-25 15:09:13.292119	2014-03-25 15:09:13.292119
302	bud light	budlight	6	2014-03-25 15:09:13.29495	2014-03-25 15:09:13.29495
303	coors light	coorslight	6	2014-03-25 15:09:13.297697	2014-03-25 15:09:13.297697
304	miller light	millerlight	6	2014-03-25 15:09:13.300518	2014-03-25 15:09:13.300518
305	coors	coors	6	2014-03-25 15:09:13.303665	2014-03-25 15:09:13.303665
306	sauza	sauza	6	2014-03-25 15:09:13.306782	2014-03-25 15:09:13.306782
307	jose cuervo	josecuervo	6	2014-03-25 15:09:13.309793	2014-03-25 15:09:13.309793
308	el jimador	eljimador	6	2014-03-25 15:09:13.31269	2014-03-25 15:09:13.31269
309	russian standard	russianstandard	6	2014-03-25 15:09:13.315855	2014-03-25 15:09:13.315855
310	svedka	svedka	6	2014-03-25 15:09:13.319266	2014-03-25 15:09:13.319266
311	patron	patron	6	2014-03-25 15:09:13.322998	2014-03-25 15:09:13.322998
312	hennessy	hennessy	6	2014-03-25 15:09:13.326521	2014-03-25 15:09:13.326521
313	dom perignon	domperignon	6	2014-03-25 15:09:13.329813	2014-03-25 15:09:13.329813
314	champagne	champagne	6	2014-03-25 15:09:13.332998	2014-03-25 15:09:13.332998
315	champagne of beers	champagneofbeers	6	2014-03-25 15:09:13.336335	2014-03-25 15:09:13.336335
316	don julio	donjulio	6	2014-03-25 15:09:13.339316	2014-03-25 15:09:13.339316
317	beefeater	beefeater	6	2014-03-25 15:09:13.342496	2014-03-25 15:09:13.342496
318	seagrams	seagrams	6	2014-03-25 15:09:13.345431	2014-03-25 15:09:13.345431
319	malort	malort	6	2014-03-25 15:09:13.348474	2014-03-25 15:09:13.348474
320	bitters	bitters	6	2014-03-25 15:09:13.351601	2014-03-25 15:09:13.351601
653	gay	gay	10	2014-03-25 15:09:14.615004	2014-03-25 15:09:14.615004
321	bombay gin	bombaygin	6	2014-03-25 15:09:13.354824	2014-03-25 15:09:13.354824
322	tanqueray	tanqueray	6	2014-03-25 15:09:13.35783	2014-03-25 15:09:13.35783
323	coconut rum	coconutrum	6	2014-03-25 15:09:13.36076	2014-03-25 15:09:13.36076
324	baileys	baileys	6	2014-03-25 15:09:13.363913	2014-03-25 15:09:13.363913
325	baileys irish cream	baileysirishcream	6	2014-03-25 15:09:13.366996	2014-03-25 15:09:13.366996
326	grey goose	greygoose	6	2014-03-25 15:09:13.370144	2014-03-25 15:09:13.370144
327	gray goose	graygoose	6	2014-03-25 15:09:13.37306	2014-03-25 15:09:13.37306
328	ketel one	ketelone	6	2014-03-25 15:09:13.376339	2014-03-25 15:09:13.376339
329	belvedere	belvedere	6	2014-03-25 15:09:13.379153	2014-03-25 15:09:13.379153
330	stolichnaya	stolichnaya	6	2014-03-25 15:09:13.382022	2014-03-25 15:09:13.382022
331	uv blue	uvblue	6	2014-03-25 15:09:13.385133	2014-03-25 15:09:13.385133
332	lush	lush	6	2014-03-25 15:09:13.388018	2014-03-25 15:09:13.388018
333	alkie	alkie	6	2014-03-25 15:09:13.390915	2014-03-25 15:09:13.390915
334	alcoholic	alcoholic	6	2014-03-25 15:09:13.39433	2014-03-25 15:09:13.39433
335	booze hound	boozehound	6	2014-03-25 15:09:13.397211	2014-03-25 15:09:13.397211
336	Saturday	saturday	6	2014-03-25 15:09:13.400364	2014-03-25 15:09:13.400364
337	Friday	friday	6	2014-03-25 15:09:13.403514	2014-03-25 15:09:13.403514
338	tailgate	tailgate	6	2014-03-25 15:09:13.406716	2014-03-25 15:09:13.406716
339	pregame	pregame	6	2014-03-25 15:09:13.409599	2014-03-25 15:09:13.409599
340	pre-game	pre-game	6	2014-03-25 15:09:13.412586	2014-03-25 15:09:13.412586
341	pregaming	pregaming	6	2014-03-25 15:09:13.415539	2014-03-25 15:09:13.415539
342	pre-gaming	pre-gaming	6	2014-03-25 15:09:13.418586	2014-03-25 15:09:13.418586
343	after bar	afterbar	6	2014-03-25 15:09:13.421473	2014-03-25 15:09:13.421473
344	after-bar	after-bar	6	2014-03-25 15:09:13.42444	2014-03-25 15:09:13.42444
345	a-bar	a-bar	6	2014-03-25 15:09:13.427958	2014-03-25 15:09:13.427958
346	cut loose	cutloose	6	2014-03-25 15:09:13.431268	2014-03-25 15:09:13.431268
347	get down	getdown	6	2014-03-25 15:09:13.434265	2014-03-25 15:09:13.434265
348	party down	partydown	6	2014-03-25 15:09:13.465806	2014-03-25 15:09:13.465806
349	hotbox	hotbox	6	2014-03-25 15:09:13.469352	2014-03-25 15:09:13.469352
350	smokeout	smokeout	6	2014-03-25 15:09:13.473304	2014-03-25 15:09:13.473304
351	reefer	reefer	6	2014-03-25 15:09:13.477244	2014-03-25 15:09:13.477244
352	rave	rave	6	2014-03-25 15:09:13.481336	2014-03-25 15:09:13.481336
353	raver	raver	6	2014-03-25 15:09:13.48472	2014-03-25 15:09:13.48472
354	orgy	orgy	6	2014-03-25 15:09:13.488876	2014-03-25 15:09:13.488876
355	blunt	blunt	6	2014-03-25 15:09:13.492854	2014-03-25 15:09:13.492854
356	after hours	afterhours	6	2014-03-25 15:09:13.497163	2014-03-25 15:09:13.497163
357	spliff	spliff	6	2014-03-25 15:09:13.500508	2014-03-25 15:09:13.500508
358	joint	joint	6	2014-03-25 15:09:13.505337	2014-03-25 15:09:13.505337
359	walk of shame	walkofshame	6	2014-03-25 15:09:13.50963	2014-03-25 15:09:13.50963
360	sex cult	sexcult	6	2014-03-25 15:09:13.512971	2014-03-25 15:09:13.512971
361	vermouth	vermouth	6	2014-03-25 15:09:13.517064	2014-03-25 15:09:13.517064
362	alcohol delivery	alcoholdelivery	6	2014-03-25 15:09:13.521949	2014-03-25 15:09:13.521949
363	boozahol	boozahol	6	2014-03-25 15:09:13.526489	2014-03-25 15:09:13.526489
364	boozaholic	boozaholic	6	2014-03-25 15:09:13.531016	2014-03-25 15:09:13.531016
365	booze	booze	6	2014-03-25 15:09:13.535611	2014-03-25 15:09:13.535611
366	margaritas	margaritas	6	2014-03-25 15:09:13.539747	2014-03-25 15:09:13.539747
367	martini	martini	6	2014-03-25 15:09:13.54383	2014-03-25 15:09:13.54383
368	martinis	martinis	6	2014-03-25 15:09:13.547503	2014-03-25 15:09:13.547503
369	margarita	margarita	6	2014-03-25 15:09:13.551794	2014-03-25 15:09:13.551794
370	margs	margs	6	2014-03-25 15:09:13.556071	2014-03-25 15:09:13.556071
371	tailgaiting	tailgaiting	6	2014-03-25 15:09:13.604463	2014-03-25 15:09:13.604463
372	stoner	stoner	6	2014-03-25 15:09:13.608166	2014-03-25 15:09:13.608166
373	spring break	springbreak	6	2014-03-25 15:09:13.610976	2014-03-25 15:09:13.610976
374	freakin weekend	freakinweekend	6	2014-03-25 15:09:13.615232	2014-03-25 15:09:13.615232
375	stoner mindset	stonermindset	6	2014-03-25 15:09:13.618451	2014-03-25 15:09:13.618451
376	bottle	bottle	6	2014-03-25 15:09:13.622055	2014-03-25 15:09:13.622055
377	drinks	drinks	6	2014-03-25 15:09:13.6257	2014-03-25 15:09:13.6257
378	unlimited ass	unlimitedass	6	2014-03-25 15:09:13.62928	2014-03-25 15:09:13.62928
379	beer	beer	6	2014-03-25 15:09:13.632159	2014-03-25 15:09:13.632159
380	alcohol	alcohol	6	2014-03-25 15:09:13.6359	2014-03-25 15:09:13.6359
381	shots	shots	6	2014-03-25 15:09:13.639678	2014-03-25 15:09:13.639678
382	rage	rage	6	2014-03-25 15:09:13.643346	2014-03-25 15:09:13.643346
383	ragin	ragin	6	2014-03-25 15:09:13.646854	2014-03-25 15:09:13.646854
384	ragin'	ragin'	6	2014-03-25 15:09:13.649783	2014-03-25 15:09:13.649783
385	vape	vape	6	2014-03-25 15:09:13.652661	2014-03-25 15:09:13.652661
386	vaporizer	vaporizer	6	2014-03-25 15:09:13.655974	2014-03-25 15:09:13.655974
387	codeine	codeine	6	2014-03-25 15:09:13.658966	2014-03-25 15:09:13.658966
388	morphine	morphine	6	2014-03-25 15:09:13.662182	2014-03-25 15:09:13.662182
389	vicodin	vicodin	6	2014-03-25 15:09:13.665165	2014-03-25 15:09:13.665165
390	hydrocodone	hydrocodone	6	2014-03-25 15:09:13.668383	2014-03-25 15:09:13.668383
391	oxycontin	oxycontin	6	2014-03-25 15:09:13.67143	2014-03-25 15:09:13.67143
392	oxy cotton	oxycotton	6	2014-03-25 15:09:13.67467	2014-03-25 15:09:13.67467
393	hopped up	hoppedup	6	2014-03-25 15:09:13.67783	2014-03-25 15:09:13.67783
394	nugs	nugs	6	2014-03-25 15:09:13.68076	2014-03-25 15:09:13.68076
395	dank weed	dankweed	6	2014-03-25 15:09:13.683759	2014-03-25 15:09:13.683759
396	good weed	goodweed	6	2014-03-25 15:09:13.68688	2014-03-25 15:09:13.68688
397	chronic	chronic	6	2014-03-25 15:09:13.690031	2014-03-25 15:09:13.690031
398	dank nugs	danknugs	6	2014-03-25 15:09:13.693241	2014-03-25 15:09:13.693241
399	tripping	tripping	6	2014-03-25 15:09:13.696332	2014-03-25 15:09:13.696332
400	hallucinating	hallucinating	6	2014-03-25 15:09:13.69952	2014-03-25 15:09:13.69952
401	ball so hard	ballsohard	6	2014-03-25 15:09:13.702283	2014-03-25 15:09:13.702283
402	dope	dope	6	2014-03-25 15:09:13.705084	2014-03-25 15:09:13.705084
403	karaoke	karaoke	6	2014-03-25 15:09:13.708686	2014-03-25 15:09:13.708686
404	head shop	headshop	6	2014-03-25 15:09:13.712286	2014-03-25 15:09:13.712286
405	dat ass	datass	6	2014-03-25 15:09:13.715319	2014-03-25 15:09:13.715319
406	raging	raging	6	2014-03-25 15:09:13.718522	2014-03-25 15:09:13.718522
407	rager	rager	6	2014-03-25 15:09:13.721633	2014-03-25 15:09:13.721633
408	hammered	hammered	6	2014-03-25 15:09:13.725705	2014-03-25 15:09:13.725705
409	springbreak	springbreak	6	2014-03-25 15:09:13.731332	2014-03-25 15:09:13.731332
410	collegelife	collegelife	6	2014-03-25 15:09:13.734581	2014-03-25 15:09:13.734581
411	blacked out	blackedout	6	2014-03-25 15:09:13.737809	2014-03-25 15:09:13.737809
412	drugs	drugs	6	2014-03-25 15:09:13.740902	2014-03-25 15:09:13.740902
413	drink	drink	6	2014-03-25 15:09:13.743888	2014-03-25 15:09:13.743888
414	smoke	smoke	6	2014-03-25 15:09:13.74698	2014-03-25 15:09:13.74698
415	wasted	wasted	6	2014-03-25 15:09:13.749996	2014-03-25 15:09:13.749996
416	shitfaced	shitfaced	6	2014-03-25 15:09:13.753086	2014-03-25 15:09:13.753086
417	shit faced	shitfaced	6	2014-03-25 15:09:13.756298	2014-03-25 15:09:13.756298
418	shithoused	shithoused	6	2014-03-25 15:09:13.759727	2014-03-25 15:09:13.759727
419	browned out	brownedout	6	2014-03-25 15:09:13.763077	2014-03-25 15:09:13.763077
420	blasted	blasted	6	2014-03-25 15:09:13.766248	2014-03-25 15:09:13.766248
421	tipsy	tipsy	6	2014-03-25 15:09:13.769107	2014-03-25 15:09:13.769107
422	drunk	drunk	6	2014-03-25 15:09:13.772492	2014-03-25 15:09:13.772492
423	drank	drank	6	2014-03-25 15:09:13.775384	2014-03-25 15:09:13.775384
424	blotto	blotto	6	2014-03-25 15:09:13.778469	2014-03-25 15:09:13.778469
425	smokin	smokin	6	2014-03-25 15:09:13.781504	2014-03-25 15:09:13.781504
426	kush	kush	6	2014-03-25 15:09:13.784703	2014-03-25 15:09:13.784703
427	dank	dank	6	2014-03-25 15:09:13.787807	2014-03-25 15:09:13.787807
428	pot	pot	6	2014-03-25 15:09:13.790847	2014-03-25 15:09:13.790847
429	weed	weed	6	2014-03-25 15:09:13.793838	2014-03-25 15:09:13.793838
430	blazed	blazed	6	2014-03-25 15:09:13.796879	2014-03-25 15:09:13.796879
431	blazing	blazing	6	2014-03-25 15:09:13.799892	2014-03-25 15:09:13.799892
432	party	party	6	2014-03-25 15:09:13.803013	2014-03-25 15:09:13.803013
433	partying	partying	6	2014-03-25 15:09:13.806116	2014-03-25 15:09:13.806116
434	cig	cig	6	2014-03-25 15:09:13.809108	2014-03-25 15:09:13.809108
435	cigarettes	cigarettes	6	2014-03-25 15:09:13.812162	2014-03-25 15:09:13.812162
436	acid	acid	6	2014-03-25 15:09:13.81544	2014-03-25 15:09:13.81544
437	lsd	lsd	6	2014-03-25 15:09:13.818822	2014-03-25 15:09:13.818822
438	mdma	mdma	6	2014-03-25 15:09:13.821883	2014-03-25 15:09:13.821883
439	ecstasy	ecstasy	6	2014-03-25 15:09:13.825077	2014-03-25 15:09:13.825077
440	blackout	blackout	6	2014-03-25 15:09:13.828042	2014-03-25 15:09:13.828042
441	black out	blackout	6	2014-03-25 15:09:13.831388	2014-03-25 15:09:13.831388
442	wine	wine	6	2014-03-25 15:09:13.834233	2014-03-25 15:09:13.834233
443	liquor	liquor	6	2014-03-25 15:09:13.837368	2014-03-25 15:09:13.837368
444	whiskey	whiskey	6	2014-03-25 15:09:13.840302	2014-03-25 15:09:13.840302
445	rum	rum	6	2014-03-25 15:09:13.843438	2014-03-25 15:09:13.843438
446	gin	gin	6	2014-03-25 15:09:13.846589	2014-03-25 15:09:13.846589
447	vodka	vodka	6	2014-03-25 15:09:13.849843	2014-03-25 15:09:13.849843
448	tequila	tequila	6	2014-03-25 15:09:13.852957	2014-03-25 15:09:13.852957
449	rumpleminze	rumpleminze	6	2014-03-25 15:09:13.85609	2014-03-25 15:09:13.85609
450	goldschlager	goldschlager	6	2014-03-25 15:09:13.859164	2014-03-25 15:09:13.859164
451	kahlua	kahlua	6	2014-03-25 15:09:13.862222	2014-03-25 15:09:13.862222
452	jager	jager	6	2014-03-25 15:09:13.86514	2014-03-25 15:09:13.86514
453	jagermeister	jagermeister	6	2014-03-25 15:09:13.868323	2014-03-25 15:09:13.868323
454	budweiser	budweiser	6	2014-03-25 15:09:13.871328	2014-03-25 15:09:13.871328
455	leinenkugels	leinenkugels	6	2014-03-25 15:09:13.87433	2014-03-25 15:09:13.87433
456	leinies	leinies	6	2014-03-25 15:09:13.877542	2014-03-25 15:09:13.877542
457	pbr	pbr	6	2014-03-25 15:09:13.880528	2014-03-25 15:09:13.880528
458	pabst	pabst	6	2014-03-25 15:09:13.883535	2014-03-25 15:09:13.883535
459	pabst blue ribbon	pabstblueribbon	6	2014-03-25 15:09:13.886555	2014-03-25 15:09:13.886555
460	miller high life	millerhighlife	6	2014-03-25 15:09:13.889671	2014-03-25 15:09:13.889671
461	mgd	mgd	6	2014-03-25 15:09:13.893172	2014-03-25 15:09:13.893172
462	blatts	blatts	6	2014-03-25 15:09:13.896519	2014-03-25 15:09:13.896519
463	hamms	hamms	6	2014-03-25 15:09:13.899707	2014-03-25 15:09:13.899707
464	porter	porter	6	2014-03-25 15:09:13.902777	2014-03-25 15:09:13.902777
465	stout	stout	6	2014-03-25 15:09:13.905593	2014-03-25 15:09:13.905593
466	ipa	ipa	6	2014-03-25 15:09:13.90849	2014-03-25 15:09:13.90849
467	amber ale	amberale	6	2014-03-25 15:09:13.911635	2014-03-25 15:09:13.911635
468	red ale	redale	6	2014-03-25 15:09:13.914666	2014-03-25 15:09:13.914666
469	beer pong	beerpong	6	2014-03-25 15:09:13.917856	2014-03-25 15:09:13.917856
470	frat	frat	6	2014-03-25 15:09:13.921071	2014-03-25 15:09:13.921071
471	greek	greek	6	2014-03-25 15:09:13.924343	2014-03-25 15:09:13.924343
472	sorority	sorority	6	2014-03-25 15:09:13.927821	2014-03-25 15:09:13.927821
473	club	club	6	2014-03-25 15:09:13.930975	2014-03-25 15:09:13.930975
474	420	420	6	2014-03-25 15:09:13.934058	2014-03-25 15:09:13.934058
475	4:20	4:20	6	2014-03-25 15:09:13.937218	2014-03-25 15:09:13.937218
476	four twenty	fourtwenty	6	2014-03-25 15:09:13.940278	2014-03-25 15:09:13.940278
477	so high	sohigh	6	2014-03-25 15:09:13.943501	2014-03-25 15:09:13.943501
478	get high	gethigh	6	2014-03-25 15:09:13.946528	2014-03-25 15:09:13.946528
479	get blazed	getblazed	6	2014-03-25 15:09:13.949663	2014-03-25 15:09:13.949663
480	get drunk	getdrunk	6	2014-03-25 15:09:13.953164	2014-03-25 15:09:13.953164
481	get shitfaced	getshitfaced	6	2014-03-25 15:09:13.956971	2014-03-25 15:09:13.956971
482	get wasted	getwasted	6	2014-03-25 15:09:13.960092	2014-03-25 15:09:13.960092
483	get blackout	getblackout	6	2014-03-25 15:09:13.965479	2014-03-25 15:09:13.965479
484	blackout drunk	blackoutdrunk	6	2014-03-25 15:09:13.9686	2014-03-25 15:09:13.9686
485	bath salts	bathsalts	6	2014-03-25 15:09:13.971606	2014-03-25 15:09:13.971606
486	busch	busch	6	2014-03-25 15:09:13.975012	2014-03-25 15:09:13.975012
487	schlitz	schlitz	6	2014-03-25 15:09:13.978279	2014-03-25 15:09:13.978279
488	keystone	keystone	6	2014-03-25 15:09:13.981173	2014-03-25 15:09:13.981173
489	30 rack	30rack	6	2014-03-25 15:09:13.984297	2014-03-25 15:09:13.984297
490	thirty rack	thirtyrack	6	2014-03-25 15:09:13.987376	2014-03-25 15:09:13.987376
491	rolling rock	rollingrock	6	2014-03-25 15:09:13.990326	2014-03-25 15:09:13.990326
492	steel reserve	steelreserve	6	2014-03-25 15:09:13.993665	2014-03-25 15:09:13.993665
493	house party	houseparty	6	2014-03-25 15:09:13.996554	2014-03-25 15:09:13.996554
494	hooka	hooka	6	2014-03-25 15:09:14.000622	2014-03-25 15:09:14.000622
495	ritalin	ritalin	6	2014-03-25 15:09:14.003728	2014-03-25 15:09:14.003728
496	adderall	adderall	6	2014-03-25 15:09:14.006869	2014-03-25 15:09:14.006869
497	shinerbock	shinerbock	6	2014-03-25 15:09:14.009918	2014-03-25 15:09:14.009918
498	cocktail	cocktail	6	2014-03-25 15:09:14.013994	2014-03-25 15:09:14.013994
499	study	study	7	2014-03-25 15:09:14.02059	2014-03-25 15:09:14.02059
500	test	test	7	2014-03-25 15:09:14.023807	2014-03-25 15:09:14.023807
501	class	class	7	2014-03-25 15:09:14.026986	2014-03-25 15:09:14.026986
502	school	school	7	2014-03-25 15:09:14.03015	2014-03-25 15:09:14.03015
503	essay	essay	7	2014-03-25 15:09:14.033412	2014-03-25 15:09:14.033412
504	essays	essays	7	2014-03-25 15:09:14.036633	2014-03-25 15:09:14.036633
505	final paper	finalpaper	7	2014-03-25 15:09:14.040306	2014-03-25 15:09:14.040306
506	classes	classes	7	2014-03-25 15:09:14.043584	2014-03-25 15:09:14.043584
507	schools	schools	7	2014-03-25 15:09:14.046509	2014-03-25 15:09:14.046509
508	colleges	colleges	7	2014-03-25 15:09:14.049463	2014-03-25 15:09:14.049463
509	academics	academics	7	2014-03-25 15:09:14.052526	2014-03-25 15:09:14.052526
510	courses	courses	7	2014-03-25 15:09:14.055792	2014-03-25 15:09:14.055792
511	tests	tests	7	2014-03-25 15:09:14.086493	2014-03-25 15:09:14.086493
512	lab	lab	7	2014-03-25 15:09:14.090631	2014-03-25 15:09:14.090631
513	lab report	labreport	7	2014-03-25 15:09:14.094881	2014-03-25 15:09:14.094881
514	panelist	panelist	7	2014-03-25 15:09:14.09907	2014-03-25 15:09:14.09907
515	panelists	panelists	7	2014-03-25 15:09:14.103272	2014-03-25 15:09:14.103272
516	ta	ta	7	2014-03-25 15:09:14.107643	2014-03-25 15:09:14.107643
517	teachers assistant	teachersassistant	7	2014-03-25 15:09:14.111899	2014-03-25 15:09:14.111899
518	teaching assistant	teachingassistant	7	2014-03-25 15:09:14.116294	2014-03-25 15:09:14.116294
519	lab reports	labreports	7	2014-03-25 15:09:14.121485	2014-03-25 15:09:14.121485
520	discussion group	discussiongroup	7	2014-03-25 15:09:14.127636	2014-03-25 15:09:14.127636
521	quiz	quiz	7	2014-03-25 15:09:14.132279	2014-03-25 15:09:14.132279
522	quizzes	quizzes	7	2014-03-25 15:09:14.136889	2014-03-25 15:09:14.136889
523	quizes	quizes	7	2014-03-25 15:09:14.140626	2014-03-25 15:09:14.140626
524	pop quiz	popquiz	7	2014-03-25 15:09:14.144803	2014-03-25 15:09:14.144803
525	classroom	classroom	7	2014-03-25 15:09:14.148773	2014-03-25 15:09:14.148773
526	college bound	collegebound	7	2014-03-25 15:09:14.152726	2014-03-25 15:09:14.152726
527	go study	gostudy	7	2014-03-25 15:09:14.157097	2014-03-25 15:09:14.157097
528	all-nighter	all-nighter	7	2014-03-25 15:09:14.16126	2014-03-25 15:09:14.16126
529	all nighter	allnighter	7	2014-03-25 15:09:14.165017	2014-03-25 15:09:14.165017
530	pull an all nighter	pullanallnighter	7	2014-03-25 15:09:14.168537	2014-03-25 15:09:14.168537
531	pull an all-nighter	pullanall-nighter	7	2014-03-25 15:09:14.172598	2014-03-25 15:09:14.172598
532	hard test	hardtest	7	2014-03-25 15:09:14.176656	2014-03-25 15:09:14.176656
533	easy test	easytest	7	2014-03-25 15:09:14.180379	2014-03-25 15:09:14.180379
534	hard class	hardclass	7	2014-03-25 15:09:14.184892	2014-03-25 15:09:14.184892
535	easy class	easyclass	7	2014-03-25 15:09:14.229685	2014-03-25 15:09:14.229685
536	easy a	easya	7	2014-03-25 15:09:14.233206	2014-03-25 15:09:14.233206
537	drop out	dropout	7	2014-03-25 15:09:14.236238	2014-03-25 15:09:14.236238
538	drop-out	drop-out	7	2014-03-25 15:09:14.239315	2014-03-25 15:09:14.239315
539	college	college	7	2014-03-25 15:09:14.242478	2014-03-25 15:09:14.242478
540	academic	academic	7	2014-03-25 15:09:14.24534	2014-03-25 15:09:14.24534
541	ace	ace	7	2014-03-25 15:09:14.248465	2014-03-25 15:09:14.248465
542	grade	grade	7	2014-03-25 15:09:14.251551	2014-03-25 15:09:14.251551
543	studying	studying	7	2014-03-25 15:09:14.254603	2014-03-25 15:09:14.254603
544	professor	professor	7	2014-03-25 15:09:14.258143	2014-03-25 15:09:14.258143
545	guest speaker	guestspeaker	7	2014-03-25 15:09:14.261348	2014-03-25 15:09:14.261348
546	study break	studybreak	7	2014-03-25 15:09:14.264196	2014-03-25 15:09:14.264196
547	prof	prof	7	2014-03-25 15:09:14.267561	2014-03-25 15:09:14.267561
548	homework	homework	7	2014-03-25 15:09:14.270709	2014-03-25 15:09:14.270709
549	hw	hw	7	2014-03-25 15:09:14.273548	2014-03-25 15:09:14.273548
550	philosophy	philosophy	7	2014-03-25 15:09:14.276762	2014-03-25 15:09:14.276762
551	statistics	statistics	7	2014-03-25 15:09:14.279799	2014-03-25 15:09:14.279799
552	botany	botany	7	2014-03-25 15:09:14.282844	2014-03-25 15:09:14.282844
553	degree	degree	7	2014-03-25 15:09:14.285954	2014-03-25 15:09:14.285954
554	office hours	officehours	7	2014-03-25 15:09:14.289318	2014-03-25 15:09:14.289318
555	students	students	7	2014-03-25 15:09:14.292498	2014-03-25 15:09:14.292498
556	student	student	7	2014-03-25 15:09:14.295721	2014-03-25 15:09:14.295721
557	anthropology	anthropology	7	2014-03-25 15:09:14.29905	2014-03-25 15:09:14.29905
558	physics	physics	7	2014-03-25 15:09:14.30232	2014-03-25 15:09:14.30232
559	biology	biology	7	2014-03-25 15:09:14.305376	2014-03-25 15:09:14.305376
560	neuroscience	neuroscience	7	2014-03-25 15:09:14.308498	2014-03-25 15:09:14.308498
561	neuro	neuro	7	2014-03-25 15:09:14.311313	2014-03-25 15:09:14.311313
562	microbiology	microbiology	7	2014-03-25 15:09:14.314566	2014-03-25 15:09:14.314566
563	teacher	teacher	7	2014-03-25 15:09:14.317595	2014-03-25 15:09:14.317595
564	grad school	gradschool	7	2014-03-25 15:09:14.320694	2014-03-25 15:09:14.320694
565	graduate school	graduateschool	7	2014-03-25 15:09:14.323838	2014-03-25 15:09:14.323838
566	graduate	graduate	7	2014-03-25 15:09:14.32715	2014-03-25 15:09:14.32715
567	grad student	gradstudent	7	2014-03-25 15:09:14.330061	2014-03-25 15:09:14.330061
568	graduate student	graduatestudent	7	2014-03-25 15:09:14.33322	2014-03-25 15:09:14.33322
569	graduate studies	graduatestudies	7	2014-03-25 15:09:14.336542	2014-03-25 15:09:14.336542
570	grad students	gradstudents	7	2014-03-25 15:09:14.339791	2014-03-25 15:09:14.339791
571	graduate students	graduatestudents	7	2014-03-25 15:09:14.343009	2014-03-25 15:09:14.343009
572	undergrads	undergrads	7	2014-03-25 15:09:14.346261	2014-03-25 15:09:14.346261
573	upperclassmen	upperclassmen	7	2014-03-25 15:09:14.349142	2014-03-25 15:09:14.349142
574	upperclassman	upperclassman	7	2014-03-25 15:09:14.352269	2014-03-25 15:09:14.352269
575	underclassmen	underclassmen	7	2014-03-25 15:09:14.355372	2014-03-25 15:09:14.355372
576	underclassman	underclassman	7	2014-03-25 15:09:14.358709	2014-03-25 15:09:14.358709
577	freshman	freshman	7	2014-03-25 15:09:14.362053	2014-03-25 15:09:14.362053
578	sophomore	sophomore	7	2014-03-25 15:09:14.365997	2014-03-25 15:09:14.365997
579	junior	junior	7	2014-03-25 15:09:14.370645	2014-03-25 15:09:14.370645
580	senior	senior	7	2014-03-25 15:09:14.374665	2014-03-25 15:09:14.374665
581	college freshmen	collegefreshmen	7	2014-03-25 15:09:14.377622	2014-03-25 15:09:14.377622
582	college freshman	collegefreshman	7	2014-03-25 15:09:14.38081	2014-03-25 15:09:14.38081
583	freshmen	freshmen	7	2014-03-25 15:09:14.383824	2014-03-25 15:09:14.383824
584	sophomores	sophomores	7	2014-03-25 15:09:14.387073	2014-03-25 15:09:14.387073
585	juniors	juniors	7	2014-03-25 15:09:14.390183	2014-03-25 15:09:14.390183
586	seniors	seniors	7	2014-03-25 15:09:14.393203	2014-03-25 15:09:14.393203
587	freshman year	freshmanyear	7	2014-03-25 15:09:14.396208	2014-03-25 15:09:14.396208
588	senior year	senioryear	7	2014-03-25 15:09:14.39926	2014-03-25 15:09:14.39926
589	graduation	graduation	7	2014-03-25 15:09:14.402359	2014-03-25 15:09:14.402359
590	college graduation	collegegraduation	7	2014-03-25 15:09:14.40554	2014-03-25 15:09:14.40554
591	university	university	7	2014-03-25 15:09:14.409517	2014-03-25 15:09:14.409517
592	study hall	studyhall	7	2014-03-25 15:09:14.41262	2014-03-25 15:09:14.41262
593	engineering	engineering	7	2014-03-25 15:09:14.415971	2014-03-25 15:09:14.415971
594	productive	productive	7	2014-03-25 15:09:14.419137	2014-03-25 15:09:14.419137
595	science	science	7	2014-03-25 15:09:14.422346	2014-03-25 15:09:14.422346
596	scholar	scholar	7	2014-03-25 15:09:14.42556	2014-03-25 15:09:14.42556
597	scholarship	scholarship	7	2014-03-25 15:09:14.4289	2014-03-25 15:09:14.4289
598	brain	brain	7	2014-03-25 15:09:14.43219	2014-03-25 15:09:14.43219
599	liberal arts	liberalarts	7	2014-03-25 15:09:14.435818	2014-03-25 15:09:14.435818
600	humanities	humanities	7	2014-03-25 15:09:14.438994	2014-03-25 15:09:14.438994
601	english	english	7	2014-03-25 15:09:14.441965	2014-03-25 15:09:14.441965
602	history	history	7	2014-03-25 15:09:14.44496	2014-03-25 15:09:14.44496
603	women's studies	women'sstudies	7	2014-03-25 15:09:14.448086	2014-03-25 15:09:14.448086
604	creative writing	creativewriting	7	2014-03-25 15:09:14.451272	2014-03-25 15:09:14.451272
605	paper	paper	7	2014-03-25 15:09:14.45527	2014-03-25 15:09:14.45527
606	midterm	midterm	7	2014-03-25 15:09:14.458318	2014-03-25 15:09:14.458318
607	final	final	7	2014-03-25 15:09:14.461471	2014-03-25 15:09:14.461471
608	chem	chem	7	2014-03-25 15:09:14.464578	2014-03-25 15:09:14.464578
609	chemistry	chemistry	7	2014-03-25 15:09:14.467708	2014-03-25 15:09:14.467708
610	allnighter	allnighter	7	2014-03-25 15:09:14.470926	2014-03-25 15:09:14.470926
611	internship	internship	7	2014-03-25 15:09:14.47549	2014-03-25 15:09:14.47549
612	grad	grad	7	2014-03-25 15:09:14.478488	2014-03-25 15:09:14.478488
613	semester	semester	7	2014-03-25 15:09:14.482714	2014-03-25 15:09:14.482714
614	quarter	quarter	7	2014-03-25 15:09:14.486023	2014-03-25 15:09:14.486023
615	trimester	trimester	7	2014-03-25 15:09:14.48948	2014-03-25 15:09:14.48948
616	term	term	7	2014-03-25 15:09:14.492805	2014-03-25 15:09:14.492805
617	terms	terms	7	2014-03-25 15:09:14.495754	2014-03-25 15:09:14.495754
618	semesters	semesters	7	2014-03-25 15:09:14.499007	2014-03-25 15:09:14.499007
619	quarters	quarters	7	2014-03-25 15:09:14.502039	2014-03-25 15:09:14.502039
620	trimesters	trimesters	7	2014-03-25 15:09:14.505071	2014-03-25 15:09:14.505071
621	econ	econ	7	2014-03-25 15:09:14.508313	2014-03-25 15:09:14.508313
622	study guide	studyguide	7	2014-03-25 15:09:14.511738	2014-03-25 15:09:14.511738
623	grades	grades	7	2014-03-25 15:09:14.514724	2014-03-25 15:09:14.514724
624	studybreak	studybreak	7	2014-03-25 15:09:14.517997	2014-03-25 15:09:14.517997
625	laboratory	laboratory	7	2014-03-25 15:09:14.522232	2014-03-25 15:09:14.522232
626	calc	calc	7	2014-03-25 15:09:14.525085	2014-03-25 15:09:14.525085
627	calculus	calculus	7	2014-03-25 15:09:14.528291	2014-03-25 15:09:14.528291
628	trig	trig	7	2014-03-25 15:09:14.531462	2014-03-25 15:09:14.531462
629	trigonometry	trigonometry	7	2014-03-25 15:09:14.534577	2014-03-25 15:09:14.534577
630	algebra	algebra	7	2014-03-25 15:09:14.537769	2014-03-25 15:09:14.537769
631	thesis	thesis	7	2014-03-25 15:09:14.540994	2014-03-25 15:09:14.540994
632	advisor	advisor	7	2014-03-25 15:09:14.54455	2014-03-25 15:09:14.54455
633	dissertation	dissertation	7	2014-03-25 15:09:14.547721	2014-03-25 15:09:14.547721
634	seminar	seminar	7	2014-03-25 15:09:14.550693	2014-03-25 15:09:14.550693
635	report	report	7	2014-03-25 15:09:14.553676	2014-03-25 15:09:14.553676
636	admissions	admissions	7	2014-03-25 15:09:14.557943	2014-03-25 15:09:14.557943
637	prereqs	prereqs	7	2014-03-25 15:09:14.560931	2014-03-25 15:09:14.560931
638	prerequisites	prerequisites	7	2014-03-25 15:09:14.563946	2014-03-25 15:09:14.563946
639	gen eds	geneds	7	2014-03-25 15:09:14.567126	2014-03-25 15:09:14.567126
640	general education	generaleducation	7	2014-03-25 15:09:14.570086	2014-03-25 15:09:14.570086
641	education	education	7	2014-03-25 15:09:14.573852	2014-03-25 15:09:14.573852
642	GRE	gre	7	2014-03-25 15:09:14.577689	2014-03-25 15:09:14.577689
643	LSAT	lsat	7	2014-03-25 15:09:14.580929	2014-03-25 15:09:14.580929
644	project	project	7	2014-03-25 15:09:14.584254	2014-03-25 15:09:14.584254
645	MCAT	mcat	7	2014-03-25 15:09:14.587581	2014-03-25 15:09:14.587581
646	academy	academy	7	2014-03-25 15:09:14.593299	2014-03-25 15:09:14.593299
647	library	library	7	2014-03-25 15:09:14.596278	2014-03-25 15:09:14.596278
648	math	math	7	2014-03-25 15:09:14.599513	2014-03-25 15:09:14.599513
649	computer science	computerscience	7	2014-03-25 15:09:14.602509	2014-03-25 15:09:14.602509
650	comp sci	compsci	7	2014-03-25 15:09:14.605664	2014-03-25 15:09:14.605664
651	j-term	j-term	7	2014-03-25 15:09:14.608723	2014-03-25 15:09:14.608723
652	lgbt	lgbt	10	2014-03-25 15:09:14.611798	2014-03-25 15:09:14.611798
654	boi	boi	10	2014-03-25 15:09:14.618052	2014-03-25 15:09:14.618052
655	bois	bois	10	2014-03-25 15:09:14.621	2014-03-25 15:09:14.621
656	lesbian	lesbian	10	2014-03-25 15:09:14.625362	2014-03-25 15:09:14.625362
657	bisexual	bisexual	10	2014-03-25 15:09:14.629245	2014-03-25 15:09:14.629245
658	bi	bi	10	2014-03-25 15:09:14.632683	2014-03-25 15:09:14.632683
659	trans	trans	10	2014-03-25 15:09:14.635835	2014-03-25 15:09:14.635835
660	transgender	transgender	10	2014-03-25 15:09:14.639174	2014-03-25 15:09:14.639174
661	drag queen	dragqueen	10	2014-03-25 15:09:14.642492	2014-03-25 15:09:14.642492
662	drag queens	dragqueens	10	2014-03-25 15:09:14.645397	2014-03-25 15:09:14.645397
663	you better work	youbetterwork	10	2014-03-25 15:09:14.64852	2014-03-25 15:09:14.64852
664	you betta work	youbettawork	10	2014-03-25 15:09:14.65167	2014-03-25 15:09:14.65167
665	pansexual	pansexual	10	2014-03-25 15:09:14.655	2014-03-25 15:09:14.655
666	queer	queer	10	2014-03-25 15:09:14.658322	2014-03-25 15:09:14.658322
667	genderqueer	genderqueer	10	2014-03-25 15:09:14.661664	2014-03-25 15:09:14.661664
668	gender queer	genderqueer	10	2014-03-25 15:09:14.664662	2014-03-25 15:09:14.664662
669	gender	gender	10	2014-03-25 15:09:14.667808	2014-03-25 15:09:14.667808
670	asexual	asexual	10	2014-03-25 15:09:14.67097	2014-03-25 15:09:14.67097
671	post-op	post-op	10	2014-03-25 15:09:14.673974	2014-03-25 15:09:14.673974
672	post op	postop	10	2014-03-25 15:09:14.676969	2014-03-25 15:09:14.676969
673	pride parade	prideparade	10	2014-03-25 15:09:14.679934	2014-03-25 15:09:14.679934
674	gay pride	gaypride	10	2014-03-25 15:09:14.682984	2014-03-25 15:09:14.682984
675	homosexual	homosexual	10	2014-03-25 15:09:14.714654	2014-03-25 15:09:14.714654
676	butch	butch	10	2014-03-25 15:09:14.718295	2014-03-25 15:09:14.718295
677	femme	femme	10	2014-03-25 15:09:14.722599	2014-03-25 15:09:14.722599
678	fag	fag	10	2014-03-25 15:09:14.727207	2014-03-25 15:09:14.727207
679	fags	fags	10	2014-03-25 15:09:14.731161	2014-03-25 15:09:14.731161
680	faggot	faggot	10	2014-03-25 15:09:14.735143	2014-03-25 15:09:14.735143
681	faggots	faggots	10	2014-03-25 15:09:14.738553	2014-03-25 15:09:14.738553
682	homo	homo	10	2014-03-25 15:09:14.7427	2014-03-25 15:09:14.7427
683	homos	homos	10	2014-03-25 15:09:14.746366	2014-03-25 15:09:14.746366
684	dyke	dyke	10	2014-03-25 15:09:14.750194	2014-03-25 15:09:14.750194
685	boystown	boystown	10	2014-03-25 15:09:14.753868	2014-03-25 15:09:14.753868
686	hunty	hunty	10	2014-03-25 15:09:14.758071	2014-03-25 15:09:14.758071
687	throw shade	throwshade	10	2014-03-25 15:09:14.761687	2014-03-25 15:09:14.761687
688	rainbow	rainbow	10	2014-03-25 15:09:14.765832	2014-03-25 15:09:14.765832
689	drag ball	dragball	10	2014-03-25 15:09:14.769372	2014-03-25 15:09:14.769372
690	rupaul	rupaul	10	2014-03-25 15:09:14.773441	2014-03-25 15:09:14.773441
691	rupauls drag race	rupaulsdragrace	10	2014-03-25 15:09:14.777465	2014-03-25 15:09:14.777465
692	rupaul's drag race	rupaul'sdragrace	10	2014-03-25 15:09:14.781809	2014-03-25 15:09:14.781809
693	sharon needles	sharonneedles	10	2014-03-25 15:09:14.785722	2014-03-25 15:09:14.785722
694	raja	raja	10	2014-03-25 15:09:14.790032	2014-03-25 15:09:14.790032
695	michelle visage	michellevisage	10	2014-03-25 15:09:14.794312	2014-03-25 15:09:14.794312
696	willam	willam	10	2014-03-25 15:09:14.798532	2014-03-25 15:09:14.798532
697	jinkx monsoon	jinkxmonsoon	10	2014-03-25 15:09:14.803446	2014-03-25 15:09:14.803446
698	courtney act	courtneyact	10	2014-03-25 15:09:14.807074	2014-03-25 15:09:14.807074
699	chad michaels	chadmichaels	10	2014-03-25 15:09:14.854073	2014-03-25 15:09:14.854073
700	latrice royale	latriceroyale	10	2014-03-25 15:09:14.857865	2014-03-25 15:09:14.857865
701	jiggly caliente	jigglycaliente	10	2014-03-25 15:09:14.861082	2014-03-25 15:09:14.861082
702	pandora boxxx	pandoraboxxx	10	2014-03-25 15:09:14.864549	2014-03-25 15:09:14.864549
703	jujubee	jujubee	10	2014-03-25 15:09:14.867475	2014-03-25 15:09:14.867475
704	gsa	gsa	10	2014-03-25 15:09:14.871896	2014-03-25 15:09:14.871896
705	homophobe	homophobe	10	2014-03-25 15:09:14.875257	2014-03-25 15:09:14.875257
706	homophobic	homophobic	10	2014-03-25 15:09:14.878206	2014-03-25 15:09:14.878206
707	manila luzon	manilaluzon	10	2014-03-25 15:09:14.881344	2014-03-25 15:09:14.881344
708	nina flowers	ninaflowers	10	2014-03-25 15:09:14.884621	2014-03-25 15:09:14.884621
709	shangela	shangela	10	2014-03-25 15:09:14.888041	2014-03-25 15:09:14.888041
710	jessica wild	jessicawild	10	2014-03-25 15:09:14.89126	2014-03-25 15:09:14.89126
711	tyra sanchez	tyrasanchez	10	2014-03-25 15:09:14.894584	2014-03-25 15:09:14.894584
712	yara sofia	yarasofia	10	2014-03-25 15:09:14.897973	2014-03-25 15:09:14.897973
713	alyssa edwards	alyssaedwards	10	2014-03-25 15:09:14.901299	2014-03-25 15:09:14.901299
714	bianca del rio	biancadelrio	10	2014-03-25 15:09:14.904589	2014-03-25 15:09:14.904589
715	laganja estranja	laganjaestranja	10	2014-03-25 15:09:14.907942	2014-03-25 15:09:14.907942
716	harvey milk	harveymilk	10	2014-03-25 15:09:14.910911	2014-03-25 15:09:14.910911
717	halleloo	halleloo	10	2014-03-25 15:09:14.915224	2014-03-25 15:09:14.915224
718	gay rights	gayrights	10	2014-03-25 15:09:14.919522	2014-03-25 15:09:14.919522
719	lgbt rights	lgbtrights	10	2014-03-25 15:09:14.922753	2014-03-25 15:09:14.922753
720	gay marriage	gaymarriage	10	2014-03-25 15:09:14.926011	2014-03-25 15:09:14.926011
721	right to marriage	righttomarriage	10	2014-03-25 15:09:14.929312	2014-03-25 15:09:14.929312
722	gay boy	gayboy	10	2014-03-25 15:09:14.932337	2014-03-25 15:09:14.932337
723	gay girl	gaygirl	10	2014-03-25 15:09:14.937551	2014-03-25 15:09:14.937551
724	gay guy	gayguy	10	2014-03-25 15:09:14.941179	2014-03-25 15:09:14.941179
725	career	career	13	2014-03-25 15:09:14.944517	2014-03-25 15:09:14.944517
726	business	business	13	2014-03-25 15:09:14.948055	2014-03-25 15:09:14.948055
727	management	management	13	2014-03-25 15:09:14.950967	2014-03-25 15:09:14.950967
728	marketing	marketing	13	2014-03-25 15:09:14.9545	2014-03-25 15:09:14.9545
729	job	job	13	2014-03-25 15:09:14.957668	2014-03-25 15:09:14.957668
730	work	work	13	2014-03-25 15:09:14.960613	2014-03-25 15:09:14.960613
731	workplace	workplace	13	2014-03-25 15:09:14.96374	2014-03-25 15:09:14.96374
732	office	office	13	2014-03-25 15:09:14.966749	2014-03-25 15:09:14.966749
733	overtime	overtime	13	2014-03-25 15:09:14.969854	2014-03-25 15:09:14.969854
734	work week	workweek	13	2014-03-25 15:09:14.972997	2014-03-25 15:09:14.972997
735	networking	networking	13	2014-03-25 15:09:14.976272	2014-03-25 15:09:14.976272
736	worknight	worknight	13	2014-03-25 15:09:14.979146	2014-03-25 15:09:14.979146
737	work night	worknight	13	2014-03-25 15:09:14.982232	2014-03-25 15:09:14.982232
738	shift	shift	13	2014-03-25 15:09:14.985297	2014-03-25 15:09:14.985297
739	interview	interview	13	2014-03-25 15:09:14.988302	2014-03-25 15:09:14.988302
740	work blows	workblows	13	2014-03-25 15:09:14.991381	2014-03-25 15:09:14.991381
741	shitty job	shittyjob	13	2014-03-25 15:09:14.994478	2014-03-25 15:09:14.994478
742	hate my job	hatemyjob	13	2014-03-25 15:09:14.997552	2014-03-25 15:09:14.997552
743	bullshit job	bullshitjob	13	2014-03-25 15:09:15.000623	2014-03-25 15:09:15.000623
744	apprentice	apprentice	13	2014-03-25 15:09:15.003769	2014-03-25 15:09:15.003769
745	apprenticeship	apprenticeship	13	2014-03-25 15:09:15.007116	2014-03-25 15:09:15.007116
746	intern	intern	13	2014-03-25 15:09:15.010492	2014-03-25 15:09:15.010492
747	internship	internship	13	2014-03-25 15:09:15.013676	2014-03-25 15:09:15.013676
748	manager	manager	13	2014-03-25 15:09:15.017104	2014-03-25 15:09:15.017104
749	regional manager	regionalmanager	13	2014-03-25 15:09:15.020211	2014-03-25 15:09:15.020211
750	my manager	mymanager	13	2014-03-25 15:09:15.023064	2014-03-25 15:09:15.023064
751	my boss	myboss	13	2014-03-25 15:09:15.025992	2014-03-25 15:09:15.025992
752	new job	newjob	13	2014-03-25 15:09:15.029102	2014-03-25 15:09:15.029102
753	old job	oldjob	13	2014-03-25 15:09:15.032209	2014-03-25 15:09:15.032209
754	better job	betterjob	13	2014-03-25 15:09:15.03537	2014-03-25 15:09:15.03537
755	promotion	promotion	13	2014-03-25 15:09:15.038518	2014-03-25 15:09:15.038518
756	get a raise	getaraise	13	2014-03-25 15:09:15.041444	2014-03-25 15:09:15.041444
757	need a raise	needaraise	13	2014-03-25 15:09:15.044461	2014-03-25 15:09:15.044461
758	working overtime	workingovertime	13	2014-03-25 15:09:15.047546	2014-03-25 15:09:15.047546
759	get a promotion	getapromotion	13	2014-03-25 15:09:15.050619	2014-03-25 15:09:15.050619
760	ceo	ceo	13	2014-03-25 15:09:15.053599	2014-03-25 15:09:15.053599
761	cto	cto	13	2014-03-25 15:09:15.056824	2014-03-25 15:09:15.056824
762	company president	companypresident	13	2014-03-25 15:09:15.059971	2014-03-25 15:09:15.059971
763	paid intern	paidintern	13	2014-03-25 15:09:15.065676	2014-03-25 15:09:15.065676
764	unpaid intern	unpaidintern	13	2014-03-25 15:09:15.068884	2014-03-25 15:09:15.068884
765	interns	interns	13	2014-03-25 15:09:15.07205	2014-03-25 15:09:15.07205
766	internships	internships	13	2014-03-25 15:09:15.07593	2014-03-25 15:09:15.07593
767	paid internship	paidinternship	13	2014-03-25 15:09:15.079386	2014-03-25 15:09:15.079386
768	unpaid internship	unpaidinternship	13	2014-03-25 15:09:15.083109	2014-03-25 15:09:15.083109
769	job interview	jobinterview	13	2014-03-25 15:09:15.087981	2014-03-25 15:09:15.087981
770	group interview	groupinterview	13	2014-03-25 15:09:15.092344	2014-03-25 15:09:15.092344
771	resume	resume	13	2014-03-25 15:09:15.095687	2014-03-25 15:09:15.095687
772	job application	jobapplication	13	2014-03-25 15:09:15.099385	2014-03-25 15:09:15.099385
773	cv	cv	13	2014-03-25 15:09:15.102366	2014-03-25 15:09:15.102366
774	coworker	coworker	13	2014-03-25 15:09:15.105859	2014-03-25 15:09:15.105859
775	coworkers	coworkers	13	2014-03-25 15:09:15.108977	2014-03-25 15:09:15.108977
776	my coworker	mycoworker	13	2014-03-25 15:09:15.112111	2014-03-25 15:09:15.112111
777	my coworkers	mycoworkers	13	2014-03-25 15:09:15.115374	2014-03-25 15:09:15.115374
778	co-worker	co-worker	13	2014-03-25 15:09:15.118836	2014-03-25 15:09:15.118836
779	co-workers	co-workers	13	2014-03-25 15:09:15.121715	2014-03-25 15:09:15.121715
780	hr	hr	13	2014-03-25 15:09:15.124974	2014-03-25 15:09:15.124974
781	human resources	humanresources	13	2014-03-25 15:09:15.128308	2014-03-25 15:09:15.128308
782	at my job	atmyjob	13	2014-03-25 15:09:15.131482	2014-03-25 15:09:15.131482
783	at work	atwork	13	2014-03-25 15:09:15.134582	2014-03-25 15:09:15.134582
784	at my work	atmywork	13	2014-03-25 15:09:15.13803	2014-03-25 15:09:15.13803
785	romance	romance	8	2014-03-25 15:09:15.141219	2014-03-25 15:09:15.141219
786	hookup	hookup	8	2014-03-25 15:09:15.144019	2014-03-25 15:09:15.144019
787	hook up	hookup	8	2014-03-25 15:09:15.147222	2014-03-25 15:09:15.147222
788	husband and wife	husbandandwife	8	2014-03-25 15:09:15.150454	2014-03-25 15:09:15.150454
789	power couple	powercouple	8	2014-03-25 15:09:15.15362	2014-03-25 15:09:15.15362
790	slurty	slurty	8	2014-03-25 15:09:15.156745	2014-03-25 15:09:15.156745
791	flirty	flirty	8	2014-03-25 15:09:15.159553	2014-03-25 15:09:15.159553
792	main squeeze	mainsqueeze	8	2014-03-25 15:09:15.162994	2014-03-25 15:09:15.162994
793	wedding	wedding	8	2014-03-25 15:09:15.166556	2014-03-25 15:09:15.166556
794	weddings	weddings	8	2014-03-25 15:09:15.170465	2014-03-25 15:09:15.170465
795	propose	propose	8	2014-03-25 15:09:15.17376	2014-03-25 15:09:15.17376
796	proposed	proposed	8	2014-03-25 15:09:15.17701	2014-03-25 15:09:15.17701
797	engaged	engaged	8	2014-03-25 15:09:15.180063	2014-03-25 15:09:15.180063
798	engagement	engagement	8	2014-03-25 15:09:15.183182	2014-03-25 15:09:15.183182
799	got engaged	gotengaged	8	2014-03-25 15:09:15.186472	2014-03-25 15:09:15.186472
800	get engaged	getengaged	8	2014-03-25 15:09:15.189685	2014-03-25 15:09:15.189685
801	married	married	8	2014-03-25 15:09:15.193304	2014-03-25 15:09:15.193304
802	get married	getmarried	8	2014-03-25 15:09:15.19635	2014-03-25 15:09:15.19635
803	have kids	havekids	8	2014-03-25 15:09:15.199431	2014-03-25 15:09:15.199431
804	procreate	procreate	8	2014-03-25 15:09:15.202532	2014-03-25 15:09:15.202532
805	hooked up	hookedup	8	2014-03-25 15:09:15.206017	2014-03-25 15:09:15.206017
806	had sex	hadsex	8	2014-03-25 15:09:15.209399	2014-03-25 15:09:15.209399
807	have sex	havesex	8	2014-03-25 15:09:15.213038	2014-03-25 15:09:15.213038
808	good lay	goodlay	8	2014-03-25 15:09:15.216372	2014-03-25 15:09:15.216372
809	got laid	gotlaid	8	2014-03-25 15:09:15.219555	2014-03-25 15:09:15.219555
810	get laid	getlaid	8	2014-03-25 15:09:15.223027	2014-03-25 15:09:15.223027
811	vibrator	vibrator	8	2014-03-25 15:09:15.226101	2014-03-25 15:09:15.226101
812	dildo	dildo	8	2014-03-25 15:09:15.229437	2014-03-25 15:09:15.229437
813	sex toy	sextoy	8	2014-03-25 15:09:15.23277	2014-03-25 15:09:15.23277
814	condom	condom	8	2014-03-25 15:09:15.236507	2014-03-25 15:09:15.236507
815	pussy	pussy	8	2014-03-25 15:09:15.239986	2014-03-25 15:09:15.239986
816	turned on	turnedon	8	2014-03-25 15:09:15.243295	2014-03-25 15:09:15.243295
817	horny	horny	8	2014-03-25 15:09:15.246275	2014-03-25 15:09:15.246275
818	lover	lover	8	2014-03-25 15:09:15.249258	2014-03-25 15:09:15.249258
819	lovers	lovers	8	2014-03-25 15:09:15.25235	2014-03-25 15:09:15.25235
820	break up	breakup	8	2014-03-25 15:09:15.255369	2014-03-25 15:09:15.255369
821	broke up	brokeup	8	2014-03-25 15:09:15.258446	2014-03-25 15:09:15.258446
822	breaking up	breakingup	8	2014-03-25 15:09:15.261462	2014-03-25 15:09:15.261462
823	dumped	dumped	8	2014-03-25 15:09:15.264563	2014-03-25 15:09:15.264563
824	contraceptives	contraceptives	8	2014-03-25 15:09:15.267766	2014-03-25 15:09:15.267766
825	contraceptive	contraceptive	8	2014-03-25 15:09:15.270748	2014-03-25 15:09:15.270748
826	iud	iud	8	2014-03-25 15:09:15.273803	2014-03-25 15:09:15.273803
827	good boyfriend	goodboyfriend	8	2014-03-25 15:09:15.276974	2014-03-25 15:09:15.276974
828	good girlfriend	goodgirlfriend	8	2014-03-25 15:09:15.280159	2014-03-25 15:09:15.280159
829	awesome boyfriend	awesomeboyfriend	8	2014-03-25 15:09:15.283735	2014-03-25 15:09:15.283735
830	awesome girlfriend	awesomegirlfriend	8	2014-03-25 15:09:15.286727	2014-03-25 15:09:15.286727
831	love	love	8	2014-03-25 15:09:15.290023	2014-03-25 15:09:15.290023
832	adore	adore	8	2014-03-25 15:09:15.293014	2014-03-25 15:09:15.293014
833	in love	inlove	8	2014-03-25 15:09:15.296219	2014-03-25 15:09:15.296219
834	so in love	soinlove	8	2014-03-25 15:09:15.299351	2014-03-25 15:09:15.299351
835	smitten	smitten	8	2014-03-25 15:09:15.302591	2014-03-25 15:09:15.302591
836	boy crush	boycrush	8	2014-03-25 15:09:15.306258	2014-03-25 15:09:15.306258
837	girl crush	girlcrush	8	2014-03-25 15:09:15.309772	2014-03-25 15:09:15.309772
838	sex	sex	8	2014-03-25 15:09:15.313238	2014-03-25 15:09:15.313238
839	crush	crush	8	2014-03-25 15:09:15.348212	2014-03-25 15:09:15.348212
840	flowers	flowers	8	2014-03-25 15:09:15.352081	2014-03-25 15:09:15.352081
841	date	date	8	2014-03-25 15:09:15.355786	2014-03-25 15:09:15.355786
842	date night	datenight	8	2014-03-25 15:09:15.359777	2014-03-25 15:09:15.359777
843	dinner date	dinnerdate	8	2014-03-25 15:09:15.363677	2014-03-25 15:09:15.363677
844	girlfriend	girlfriend	8	2014-03-25 15:09:15.368124	2014-03-25 15:09:15.368124
845	boyfriend	boyfriend	8	2014-03-25 15:09:15.372357	2014-03-25 15:09:15.372357
846	wife	wife	8	2014-03-25 15:09:15.376538	2014-03-25 15:09:15.376538
847	husband	husband	8	2014-03-25 15:09:15.380238	2014-03-25 15:09:15.380238
848	marriage	marriage	8	2014-03-25 15:09:15.384476	2014-03-25 15:09:15.384476
849	significant other	significantother	8	2014-03-25 15:09:15.38834	2014-03-25 15:09:15.38834
850	s. o.	s.o.	8	2014-03-25 15:09:15.392634	2014-03-25 15:09:15.392634
851	s.o.	s.o.	8	2014-03-25 15:09:15.396655	2014-03-25 15:09:15.396655
852	spouse	spouse	8	2014-03-25 15:09:15.401155	2014-03-25 15:09:15.401155
853	fitness	fitness	11	2014-03-25 15:09:15.405257	2014-03-25 15:09:15.405257
854	protein	protein	11	2014-03-25 15:09:15.408625	2014-03-25 15:09:15.408625
855	workout	workout	11	2014-03-25 15:09:15.412504	2014-03-25 15:09:15.412504
856	p90x	p90x	11	2014-03-25 15:09:15.416455	2014-03-25 15:09:15.416455
857	gym	gym	11	2014-03-25 15:09:15.420367	2014-03-25 15:09:15.420367
858	swole	swole	11	2014-03-25 15:09:15.424381	2014-03-25 15:09:15.424381
859	swoll	swoll	11	2014-03-25 15:09:15.428416	2014-03-25 15:09:15.428416
860	swol	swol	11	2014-03-25 15:09:15.432378	2014-03-25 15:09:15.432378
861	do you even lift	doyouevenlift	11	2014-03-25 15:09:15.435947	2014-03-25 15:09:15.435947
862	parkour	parkour	11	2014-03-25 15:09:15.440244	2014-03-25 15:09:15.440244
863	bodyweight	bodyweight	11	2014-03-25 15:09:15.444726	2014-03-25 15:09:15.444726
864	bmi	bmi	11	2014-03-25 15:09:15.490435	2014-03-25 15:09:15.490435
865	diet	diet	11	2014-03-25 15:09:15.495374	2014-03-25 15:09:15.495374
866	dieting	dieting	11	2014-03-25 15:09:15.498921	2014-03-25 15:09:15.498921
867	weight	weight	11	2014-03-25 15:09:15.502173	2014-03-25 15:09:15.502173
868	marathon	marathon	11	2014-03-25 15:09:15.505246	2014-03-25 15:09:15.505246
869	half marathon	halfmarathon	11	2014-03-25 15:09:15.508144	2014-03-25 15:09:15.508144
870	bike	bike	11	2014-03-25 15:09:15.511286	2014-03-25 15:09:15.511286
871	bicycle	bicycle	11	2014-03-25 15:09:15.51439	2014-03-25 15:09:15.51439
872	bicyclist	bicyclist	11	2014-03-25 15:09:15.517701	2014-03-25 15:09:15.517701
873	bike ride	bikeride	11	2014-03-25 15:09:15.521282	2014-03-25 15:09:15.521282
874	ride my bike	ridemybike	11	2014-03-25 15:09:15.524791	2014-03-25 15:09:15.524791
875	half-marathon	half-marathon	11	2014-03-25 15:09:15.528296	2014-03-25 15:09:15.528296
876	running	running	11	2014-03-25 15:09:15.531175	2014-03-25 15:09:15.531175
877	triathalon	triathalon	11	2014-03-25 15:09:15.534292	2014-03-25 15:09:15.534292
878	5k	5k	11	2014-03-25 15:09:15.537451	2014-03-25 15:09:15.537451
879	five k	fivek	11	2014-03-25 15:09:15.540673	2014-03-25 15:09:15.540673
880	cycling	cycling	11	2014-03-25 15:09:15.543822	2014-03-25 15:09:15.543822
881	jog	jog	11	2014-03-25 15:09:15.546895	2014-03-25 15:09:15.546895
882	jogging	jogging	11	2014-03-25 15:09:15.550067	2014-03-25 15:09:15.550067
883	body mass index	bodymassindex	11	2014-03-25 15:09:15.553284	2014-03-25 15:09:15.553284
884	body mass	bodymass	11	2014-03-25 15:09:15.556589	2014-03-25 15:09:15.556589
885	body weight	bodyweight	11	2014-03-25 15:09:15.559808	2014-03-25 15:09:15.559808
886	lose weight	loseweight	11	2014-03-25 15:09:15.563213	2014-03-25 15:09:15.563213
887	lost weight	lostweight	11	2014-03-25 15:09:15.566185	2014-03-25 15:09:15.566185
888	skinny	skinny	11	2014-03-25 15:09:15.569523	2014-03-25 15:09:15.569523
889	thin	thin	11	2014-03-25 15:09:15.574107	2014-03-25 15:09:15.574107
890	fat	fat	11	2014-03-25 15:09:15.577656	2014-03-25 15:09:15.577656
891	obese	obese	11	2014-03-25 15:09:15.58142	2014-03-25 15:09:15.58142
892	paleo	paleo	11	2014-03-25 15:09:15.585981	2014-03-25 15:09:15.585981
893	weight watchers	weightwatchers	11	2014-03-25 15:09:15.589105	2014-03-25 15:09:15.589105
894	pounds	pounds	11	2014-03-25 15:09:15.592951	2014-03-25 15:09:15.592951
895	snowboard	snowboard	11	2014-03-25 15:09:15.596459	2014-03-25 15:09:15.596459
896	biking	biking	11	2014-03-25 15:09:15.600529	2014-03-25 15:09:15.600529
897	hiking	hiking	11	2014-03-25 15:09:15.603875	2014-03-25 15:09:15.603875
898	ski	ski	11	2014-03-25 15:09:15.60703	2014-03-25 15:09:15.60703
899	yoga	yoga	11	2014-03-25 15:09:15.610329	2014-03-25 15:09:15.610329
900	hatha yoga	hathayoga	11	2014-03-25 15:09:15.613392	2014-03-25 15:09:15.613392
901	hatha	hatha	11	2014-03-25 15:09:15.616831	2014-03-25 15:09:15.616831
902	finance	finance	14	2014-03-25 15:09:15.619761	2014-03-25 15:09:15.619761
903	finances	finances	14	2014-03-25 15:09:15.624112	2014-03-25 15:09:15.624112
904	destitute	destitute	14	2014-03-25 15:09:15.6279	2014-03-25 15:09:15.6279
905	financial needs	financialneeds	14	2014-03-25 15:09:15.63168	2014-03-25 15:09:15.63168
906	financial aid	financialaid	14	2014-03-25 15:09:15.63465	2014-03-25 15:09:15.63465
907	wallet	wallet	14	2014-03-25 15:09:15.637981	2014-03-25 15:09:15.637981
908	out of pocket	outofpocket	14	2014-03-25 15:09:15.641637	2014-03-25 15:09:15.641637
909	savings	savings	14	2014-03-25 15:09:15.644732	2014-03-25 15:09:15.644732
910	checking	checking	14	2014-03-25 15:09:15.647824	2014-03-25 15:09:15.647824
911	my savings	mysavings	14	2014-03-25 15:09:15.651044	2014-03-25 15:09:15.651044
912	dipping into my savings	dippingintomysavings	14	2014-03-25 15:09:15.653969	2014-03-25 15:09:15.653969
913	save money	savemoney	14	2014-03-25 15:09:15.657304	2014-03-25 15:09:15.657304
914	coupon	coupon	14	2014-03-25 15:09:15.66065	2014-03-25 15:09:15.66065
915	coupons	coupons	14	2014-03-25 15:09:15.663872	2014-03-25 15:09:15.663872
916	coupon queen	couponqueen	14	2014-03-25 15:09:15.667006	2014-03-25 15:09:15.667006
917	welfare	welfare	14	2014-03-25 15:09:15.670074	2014-03-25 15:09:15.670074
918	food stamps	foodstamps	14	2014-03-25 15:09:15.673392	2014-03-25 15:09:15.673392
919	unemploment check	unemplomentcheck	14	2014-03-25 15:09:15.676434	2014-03-25 15:09:15.676434
920	utilities	utilities	14	2014-03-25 15:09:15.679976	2014-03-25 15:09:15.679976
921	utility bills	utilitybills	14	2014-03-25 15:09:15.683449	2014-03-25 15:09:15.683449
922	gas bill	gasbill	14	2014-03-25 15:09:15.686745	2014-03-25 15:09:15.686745
923	electric bill	electricbill	14	2014-03-25 15:09:15.690218	2014-03-25 15:09:15.690218
924	heating bill	heatingbill	14	2014-03-25 15:09:15.693476	2014-03-25 15:09:15.693476
925	cable bill	cablebill	14	2014-03-25 15:09:15.696751	2014-03-25 15:09:15.696751
926	internet bill	internetbill	14	2014-03-25 15:09:15.700364	2014-03-25 15:09:15.700364
927	broke	broke	14	2014-03-25 15:09:15.704524	2014-03-25 15:09:15.704524
928	cheap	cheap	14	2014-03-25 15:09:15.708083	2014-03-25 15:09:15.708083
929	expensive	expensive	14	2014-03-25 15:09:15.711628	2014-03-25 15:09:15.711628
930	money	money	14	2014-03-25 15:09:15.714933	2014-03-25 15:09:15.714933
931	bills	bills	14	2014-03-25 15:09:15.718213	2014-03-25 15:09:15.718213
932	credit	credit	14	2014-03-25 15:09:15.721814	2014-03-25 15:09:15.721814
933	credit card	creditcard	14	2014-03-25 15:09:15.724774	2014-03-25 15:09:15.724774
934	charge it	chargeit	14	2014-03-25 15:09:15.728026	2014-03-25 15:09:15.728026
935	debit card	debitcard	14	2014-03-25 15:09:15.731353	2014-03-25 15:09:15.731353
936	student loan	studentloan	14	2014-03-25 15:09:15.734898	2014-03-25 15:09:15.734898
937	student loans	studentloans	14	2014-03-25 15:09:15.73825	2014-03-25 15:09:15.73825
938	payment	payment	14	2014-03-25 15:09:15.741494	2014-03-25 15:09:15.741494
939	payments	payments	14	2014-03-25 15:09:15.745004	2014-03-25 15:09:15.745004
940	loan payments	loanpayments	14	2014-03-25 15:09:15.74797	2014-03-25 15:09:15.74797
941	student debt	studentdebt	14	2014-03-25 15:09:15.751366	2014-03-25 15:09:15.751366
942	debt	debt	14	2014-03-25 15:09:15.754692	2014-03-25 15:09:15.754692
943	loan	loan	14	2014-03-25 15:09:15.759113	2014-03-25 15:09:15.759113
944	bank account	bankaccount	14	2014-03-25 15:09:15.762345	2014-03-25 15:09:15.762345
945	bank	bank	14	2014-03-25 15:09:15.765702	2014-03-25 15:09:15.765702
946	dolla dolla billz	dolladollabillz	14	2014-03-25 15:09:15.768598	2014-03-25 15:09:15.768598
947	dolla dolla bills	dolladollabills	14	2014-03-25 15:09:15.771904	2014-03-25 15:09:15.771904
948	moolah	moolah	14	2014-03-25 15:09:15.774949	2014-03-25 15:09:15.774949
949	dollaz	dollaz	14	2014-03-25 15:09:15.777993	2014-03-25 15:09:15.777993
950	dollars	dollars	14	2014-03-25 15:09:15.781163	2014-03-25 15:09:15.781163
951	hundo	hundo	14	2014-03-25 15:09:15.784158	2014-03-25 15:09:15.784158
952	pricey	pricey	14	2014-03-25 15:09:15.78725	2014-03-25 15:09:15.78725
953	too expensive	tooexpensive	14	2014-03-25 15:09:15.79048	2014-03-25 15:09:15.79048
954	so cheap	socheap	14	2014-03-25 15:09:15.793376	2014-03-25 15:09:15.793376
955	way too expensive	waytooexpensive	14	2014-03-25 15:09:15.796537	2014-03-25 15:09:15.796537
956	out of money	outofmoney	14	2014-03-25 15:09:15.799978	2014-03-25 15:09:15.799978
957	get paid	getpaid	14	2014-03-25 15:09:15.802912	2014-03-25 15:09:15.802912
958	get my paycheck	getmypaycheck	14	2014-03-25 15:09:15.806261	2014-03-25 15:09:15.806261
959	got my paycheck	gotmypaycheck	14	2014-03-25 15:09:15.809628	2014-03-25 15:09:15.809628
960	got paid	gotpaid	14	2014-03-25 15:09:15.812816	2014-03-25 15:09:15.812816
961	housing	housing	16	2014-03-25 15:09:15.816129	2014-03-25 15:09:15.816129
962	rent	rent	16	2014-03-25 15:09:15.819616	2014-03-25 15:09:15.819616
963	lease	lease	16	2014-03-25 15:09:15.822803	2014-03-25 15:09:15.822803
964	dorm	dorm	16	2014-03-25 15:09:15.825738	2014-03-25 15:09:15.825738
965	apartment	apartment	16	2014-03-25 15:09:15.828721	2014-03-25 15:09:15.828721
966	house	house	16	2014-03-25 15:09:15.831995	2014-03-25 15:09:15.831995
967	apartment search	apartmentsearch	16	2014-03-25 15:09:15.835128	2014-03-25 15:09:15.835128
968	apartment hunt	apartmenthunt	16	2014-03-25 15:09:15.83827	2014-03-25 15:09:15.83827
969	domu	domu	16	2014-03-25 15:09:15.841565	2014-03-25 15:09:15.841565
970	renting	renting	16	2014-03-25 15:09:15.844617	2014-03-25 15:09:15.844617
971	my lease	mylease	16	2014-03-25 15:09:15.847647	2014-03-25 15:09:15.847647
972	signed my lease	signedmylease	16	2014-03-25 15:09:15.851201	2014-03-25 15:09:15.851201
973	sign my lease	signmylease	16	2014-03-25 15:09:15.854178	2014-03-25 15:09:15.854178
974	cosign	cosign	16	2014-03-25 15:09:15.857536	2014-03-25 15:09:15.857536
975	apartment application	apartmentapplication	16	2014-03-25 15:09:15.860779	2014-03-25 15:09:15.860779
976	rental application	rentalapplication	16	2014-03-25 15:09:15.864302	2014-03-25 15:09:15.864302
977	gender	gender	15	2014-03-25 15:09:15.867228	2014-03-25 15:09:15.867228
978	women	women	15	2014-03-25 15:09:15.870429	2014-03-25 15:09:15.870429
979	men	men	15	2014-03-25 15:09:15.874	2014-03-25 15:09:15.874
980	female	female	15	2014-03-25 15:09:15.878029	2014-03-25 15:09:15.878029
981	sexual harrassment	sexualharrassment	15	2014-03-25 15:09:15.882467	2014-03-25 15:09:15.882467
982	princess	princess	15	2014-03-25 15:09:15.886099	2014-03-25 15:09:15.886099
983	sexual assault	sexualassault	15	2014-03-25 15:09:15.889404	2014-03-25 15:09:15.889404
984	rape	rape	15	2014-03-25 15:09:15.892394	2014-03-25 15:09:15.892394
985	sexually harrassed	sexuallyharrassed	15	2014-03-25 15:09:15.896042	2014-03-25 15:09:15.896042
986	sexually assaulted	sexuallyassaulted	15	2014-03-25 15:09:15.899235	2014-03-25 15:09:15.899235
987	raped	raped	15	2014-03-25 15:09:15.902279	2014-03-25 15:09:15.902279
988	victim blaming	victimblaming	15	2014-03-25 15:09:15.905158	2014-03-25 15:09:15.905158
989	slut shaming	slutshaming	15	2014-03-25 15:09:15.908204	2014-03-25 15:09:15.908204
990	slut shame	slutshame	15	2014-03-25 15:09:15.91146	2014-03-25 15:09:15.91146
991	bitch	bitch	15	2014-03-25 15:09:15.914538	2014-03-25 15:09:15.914538
992	bitches	bitches	15	2014-03-25 15:09:15.917722	2014-03-25 15:09:15.917722
993	sluts	sluts	15	2014-03-25 15:09:15.92116	2014-03-25 15:09:15.92116
994	whores	whores	15	2014-03-25 15:09:15.924669	2014-03-25 15:09:15.924669
995	cunts	cunts	15	2014-03-25 15:09:15.927707	2014-03-25 15:09:15.927707
996	sexxx	sexxx	15	2014-03-25 15:09:15.930864	2014-03-25 15:09:15.930864
997	submissive	submissive	15	2014-03-25 15:09:15.934082	2014-03-25 15:09:15.934082
998	jezebel	jezebel	15	2014-03-25 15:09:15.937068	2014-03-25 15:09:15.937068
999	the hairpin	thehairpin	15	2014-03-25 15:09:15.939939	2014-03-25 15:09:15.939939
1000	feminist news	feministnews	15	2014-03-25 15:09:15.943091	2014-03-25 15:09:15.943091
1001	feminist magazine	feministmagazine	15	2014-03-25 15:09:15.946287	2014-03-25 15:09:15.946287
1002	feminist blog	feministblog	15	2014-03-25 15:09:15.949357	2014-03-25 15:09:15.949357
1003	feminist website	feministwebsite	15	2014-03-25 15:09:15.953024	2014-03-25 15:09:15.953024
1004	feminist	feminist	15	2014-03-25 15:09:15.956595	2014-03-25 15:09:15.956595
1005	feminazi	feminazi	15	2014-03-25 15:09:15.988396	2014-03-25 15:09:15.988396
1006	slut	slut	15	2014-03-25 15:09:15.99351	2014-03-25 15:09:15.99351
1007	slutty	slutty	15	2014-03-25 15:09:15.998015	2014-03-25 15:09:15.998015
1008	ho	ho	15	2014-03-25 15:09:16.001784	2014-03-25 15:09:16.001784
1009	flasher	flasher	15	2014-03-25 15:09:16.006073	2014-03-25 15:09:16.006073
1010	flashed	flashed	15	2014-03-25 15:09:16.010312	2014-03-25 15:09:16.010312
1011	cat-call	cat-call	15	2014-03-25 15:09:16.013959	2014-03-25 15:09:16.013959
1012	cat-called	cat-called	15	2014-03-25 15:09:16.017744	2014-03-25 15:09:16.017744
1013	cat called	catcalled	15	2014-03-25 15:09:16.021755	2014-03-25 15:09:16.021755
1014	cat call	catcall	15	2014-03-25 15:09:16.026005	2014-03-25 15:09:16.026005
1015	catcall	catcall	15	2014-03-25 15:09:16.030405	2014-03-25 15:09:16.030405
1016	catcalled	catcalled	15	2014-03-25 15:09:16.034564	2014-03-25 15:09:16.034564
1017	twat	twat	15	2014-03-25 15:09:16.03805	2014-03-25 15:09:16.03805
1018	sex positive	sexpositive	15	2014-03-25 15:09:16.042287	2014-03-25 15:09:16.042287
1019	whore	whore	15	2014-03-25 15:09:16.045869	2014-03-25 15:09:16.045869
1020	cunt	cunt	15	2014-03-25 15:09:16.049708	2014-03-25 15:09:16.049708
1021	ladies	ladies	15	2014-03-25 15:09:16.054064	2014-03-25 15:09:16.054064
1022	gender roles	genderroles	15	2014-03-25 15:09:16.059694	2014-03-25 15:09:16.059694
1023	gender studies	genderstudies	15	2014-03-25 15:09:16.0641	2014-03-25 15:09:16.0641
1024	gender binary	genderbinary	15	2014-03-25 15:09:16.069761	2014-03-25 15:09:16.069761
1025	patriarchy	patriarchy	15	2014-03-25 15:09:16.075684	2014-03-25 15:09:16.075684
1026	mra	mra	15	2014-03-25 15:09:16.079592	2014-03-25 15:09:16.079592
1027	mens rights activist	mensrightsactivist	15	2014-03-25 15:09:16.083901	2014-03-25 15:09:16.083901
1028	mens rights	mensrights	15	2014-03-25 15:09:16.129232	2014-03-25 15:09:16.129232
1029	examine your privelege	examineyourprivelege	15	2014-03-25 15:09:16.132835	2014-03-25 15:09:16.132835
1030	politics	politics	17	2014-03-25 15:09:16.146847	2014-03-25 15:09:16.146847
1031	political	political	17	2014-03-25 15:09:16.150361	2014-03-25 15:09:16.150361
1032	fillibuster	fillibuster	17	2014-03-25 15:09:16.154207	2014-03-25 15:09:16.154207
1033	gridlock	gridlock	17	2014-03-25 15:09:16.157443	2014-03-25 15:09:16.157443
1034	boycott	boycott	17	2014-03-25 15:09:16.160913	2014-03-25 15:09:16.160913
1035	divestment	divestment	17	2014-03-25 15:09:16.164219	2014-03-25 15:09:16.164219
1036	grassroots	grassroots	17	2014-03-25 15:09:16.167707	2014-03-25 15:09:16.167707
1037	sanctions	sanctions	17	2014-03-25 15:09:16.171194	2014-03-25 15:09:16.171194
1038	election	election	17	2014-03-25 15:09:16.175163	2014-03-25 15:09:16.175163
1039	mayor	mayor	17	2014-03-25 15:09:16.17884	2014-03-25 15:09:16.17884
1040	senate	senate	17	2014-03-25 15:09:16.182756	2014-03-25 15:09:16.182756
1041	senator	senator	17	2014-03-25 15:09:16.186561	2014-03-25 15:09:16.186561
1042	congress	congress	17	2014-03-25 15:09:16.190182	2014-03-25 15:09:16.190182
1043	congressman	congressman	17	2014-03-25 15:09:16.194695	2014-03-25 15:09:16.194695
1044	congresswoman	congresswoman	17	2014-03-25 15:09:16.199554	2014-03-25 15:09:16.199554
1045	congressperson	congressperson	17	2014-03-25 15:09:16.20434	2014-03-25 15:09:16.20434
1046	congress person	congressperson	17	2014-03-25 15:09:16.208207	2014-03-25 15:09:16.208207
1047	chelsea clinton	chelseaclinton	17	2014-03-25 15:09:16.211616	2014-03-25 15:09:16.211616
1048	clinton	clinton	17	2014-03-25 15:09:16.214698	2014-03-25 15:09:16.214698
1049	representative	representative	17	2014-03-25 15:09:16.218278	2014-03-25 15:09:16.218278
1050	rep	rep	17	2014-03-25 15:09:16.221529	2014-03-25 15:09:16.221529
1051	fuck obama	fuckobama	17	2014-03-25 15:09:16.224779	2014-03-25 15:09:16.224779
1052	potus	potus	17	2014-03-25 15:09:16.228241	2014-03-25 15:09:16.228241
1053	flotus	flotus	17	2014-03-25 15:09:16.231097	2014-03-25 15:09:16.231097
1054	democrat	democrat	17	2014-03-25 15:09:16.234545	2014-03-25 15:09:16.234545
1055	dem	dem	17	2014-03-25 15:09:16.23745	2014-03-25 15:09:16.23745
1056	republican	republican	17	2014-03-25 15:09:16.24066	2014-03-25 15:09:16.24066
1057	conservative	conservative	17	2014-03-25 15:09:16.244019	2014-03-25 15:09:16.244019
1058	liberal	liberal	17	2014-03-25 15:09:16.247088	2014-03-25 15:09:16.247088
1059	dems	dems	17	2014-03-25 15:09:16.250448	2014-03-25 15:09:16.250448
1060	democrats	democrats	17	2014-03-25 15:09:16.253599	2014-03-25 15:09:16.253599
1061	republicans	republicans	17	2014-03-25 15:09:16.256784	2014-03-25 15:09:16.256784
1062	communist	communist	17	2014-03-25 15:09:16.260354	2014-03-25 15:09:16.260354
1063	facist	facist	17	2014-03-25 15:09:16.264065	2014-03-25 15:09:16.264065
1064	protest	protest	17	2014-03-25 15:09:16.267392	2014-03-25 15:09:16.267392
1065	occupy wall street	occupywallstreet	17	2014-03-25 15:09:16.270289	2014-03-25 15:09:16.270289
1066	wall street	wallstreet	17	2014-03-25 15:09:16.273745	2014-03-25 15:09:16.273745
1067	post-all	post-all	17	2014-03-25 15:09:16.276978	2014-03-25 15:09:16.276978
1068	sit-in	sit-in	17	2014-03-25 15:09:16.280085	2014-03-25 15:09:16.280085
1069	post all	postall	17	2014-03-25 15:09:16.283437	2014-03-25 15:09:16.283437
1070	sit in	sitin	17	2014-03-25 15:09:16.28671	2014-03-25 15:09:16.28671
1071	Capitol Hill	capitolhill	17	2014-03-25 15:09:16.290079	2014-03-25 15:09:16.290079
1072	whitehouse	whitehouse	17	2014-03-25 15:09:16.293905	2014-03-25 15:09:16.293905
1073	white house	whitehouse	17	2014-03-25 15:09:16.297295	2014-03-25 15:09:16.297295
1074	newt gingrich	newtgingrich	17	2014-03-25 15:09:16.300582	2014-03-25 15:09:16.300582
1075	gingrich	gingrich	17	2014-03-25 15:09:16.303484	2014-03-25 15:09:16.303484
1076	student election	studentelection	17	2014-03-25 15:09:16.3072	2014-03-25 15:09:16.3072
1077	student elections	studentelections	17	2014-03-25 15:09:16.311052	2014-03-25 15:09:16.311052
1078	vote	vote	17	2014-03-25 15:09:16.314266	2014-03-25 15:09:16.314266
1079	voter	voter	17	2014-03-25 15:09:16.317541	2014-03-25 15:09:16.317541
1080	voter registration	voterregistration	17	2014-03-25 15:09:16.320459	2014-03-25 15:09:16.320459
1081	special interest	specialinterest	17	2014-03-25 15:09:16.324202	2014-03-25 15:09:16.324202
1082	special interests	specialinterests	17	2014-03-25 15:09:16.32758	2014-03-25 15:09:16.32758
1083	pac	pac	17	2014-03-25 15:09:16.33087	2014-03-25 15:09:16.33087
1084	super pac	superpac	17	2014-03-25 15:09:16.33396	2014-03-25 15:09:16.33396
1085	super-pac	super-pac	17	2014-03-25 15:09:16.337284	2014-03-25 15:09:16.337284
1086	lobbyist	lobbyist	17	2014-03-25 15:09:16.340597	2014-03-25 15:09:16.340597
1087	lobbyists	lobbyists	17	2014-03-25 15:09:16.343759	2014-03-25 15:09:16.343759
1088	obama	obama	17	2014-03-25 15:09:16.346675	2014-03-25 15:09:16.346675
1089	barack obama	barackobama	17	2014-03-25 15:09:16.349807	2014-03-25 15:09:16.349807
1090	barack osama	barackosama	17	2014-03-25 15:09:16.353159	2014-03-25 15:09:16.353159
1091	hillary clinton	hillaryclinton	17	2014-03-25 15:09:16.356916	2014-03-25 15:09:16.356916
1092	bill clinton	billclinton	17	2014-03-25 15:09:16.359917	2014-03-25 15:09:16.359917
1093	john mccain	johnmccain	17	2014-03-25 15:09:16.362763	2014-03-25 15:09:16.362763
1094	joe biden	joebiden	17	2014-03-25 15:09:16.36591	2014-03-25 15:09:16.36591
1095	condoleeza rice	condoleezarice	17	2014-03-25 15:09:16.369289	2014-03-25 15:09:16.369289
1096	george bush	georgebush	17	2014-03-25 15:09:16.372439	2014-03-25 15:09:16.372439
1097	reagan	reagan	17	2014-03-25 15:09:16.375336	2014-03-25 15:09:16.375336
1098	nixon	nixon	17	2014-03-25 15:09:16.378394	2014-03-25 15:09:16.378394
1099	supreme court	supremecourt	17	2014-03-25 15:09:16.381443	2014-03-25 15:09:16.381443
1100	wendy davis	wendydavis	17	2014-03-25 15:09:16.384657	2014-03-25 15:09:16.384657
1101	gabrielle giffords	gabriellegiffords	17	2014-03-25 15:09:16.388117	2014-03-25 15:09:16.388117
1102	michelle bachmann	michellebachmann	17	2014-03-25 15:09:16.391795	2014-03-25 15:09:16.391795
1103	jon stewart	jonstewart	17	2014-03-25 15:09:16.394819	2014-03-25 15:09:16.394819
1104	john stewart	johnstewart	17	2014-03-25 15:09:16.398462	2014-03-25 15:09:16.398462
1105	steven colbert	stevencolbert	17	2014-03-25 15:09:16.402179	2014-03-25 15:09:16.402179
1106	colbert	colbert	17	2014-03-25 15:09:16.405951	2014-03-25 15:09:16.405951
1107	non-profit	non-profit	17	2014-03-25 15:09:16.409069	2014-03-25 15:09:16.409069
1108	npo	npo	17	2014-03-25 15:09:16.412375	2014-03-25 15:09:16.412375
1109	volunteer	volunteer	17	2014-03-25 15:09:16.416292	2014-03-25 15:09:16.416292
1110	paul ryan	paulryan	17	2014-03-25 15:09:16.420092	2014-03-25 15:09:16.420092
1111	scott walker	scottwalker	17	2014-03-25 15:09:16.42359	2014-03-25 15:09:16.42359
1112	charity	charity	17	2014-03-25 15:09:16.427569	2014-03-25 15:09:16.427569
1113	red cross	redcross	17	2014-03-25 15:09:16.431336	2014-03-25 15:09:16.431336
1114	candidate	candidate	17	2014-03-25 15:09:16.434682	2014-03-25 15:09:16.434682
1115	primaries	primaries	17	2014-03-25 15:09:16.4383	2014-03-25 15:09:16.4383
1116	sarah palin	sarahpalin	17	2014-03-25 15:09:16.441619	2014-03-25 15:09:16.441619
1117	todd akin	toddakin	17	2014-03-25 15:09:16.444815	2014-03-25 15:09:16.444815
1118	ruth bader-ginsburg	ruthbader-ginsburg	17	2014-03-25 15:09:16.448005	2014-03-25 15:09:16.448005
1119	ruth bader-ginsberg	ruthbader-ginsberg	17	2014-03-25 15:09:16.451528	2014-03-25 15:09:16.451528
1120	john edwards	johnedwards	17	2014-03-25 15:09:16.454784	2014-03-25 15:09:16.454784
1121	putin	putin	17	2014-03-25 15:09:16.458055	2014-03-25 15:09:16.458055
1122	vladimir putin	vladimirputin	17	2014-03-25 15:09:16.461157	2014-03-25 15:09:16.461157
1123	riots	riots	17	2014-03-25 15:09:16.464776	2014-03-25 15:09:16.464776
1124	government	government	17	2014-03-25 15:09:16.467844	2014-03-25 15:09:16.467844
1125	gov	gov	17	2014-03-25 15:09:16.471216	2014-03-25 15:09:16.471216
1126	law	law	17	2014-03-25 15:09:16.474516	2014-03-25 15:09:16.474516
1127	kate bailey hutchinson	katebaileyhutchinson	17	2014-03-25 15:09:16.478115	2014-03-25 15:09:16.478115
1128	bloomberg	bloomberg	17	2014-03-25 15:09:16.481484	2014-03-25 15:09:16.481484
1129	bill deblasio	billdeblasio	17	2014-03-25 15:09:16.484353	2014-03-25 15:09:16.484353
1130	deblasio	deblasio	17	2014-03-25 15:09:16.487547	2014-03-25 15:09:16.487547
1131	App store	appstore	2	2014-03-25 15:09:16.490527	2014-03-25 15:09:16.490527
1132	api	api	2	2014-03-25 15:09:16.493581	2014-03-25 15:09:16.493581
1133	startup	startup	2	2014-03-25 15:09:16.49666	2014-03-25 15:09:16.49666
1134	start up	startup	2	2014-03-25 15:09:16.499943	2014-03-25 15:09:16.499943
1135	start-up	start-up	2	2014-03-25 15:09:16.503464	2014-03-25 15:09:16.503464
1136	web developer	webdeveloper	2	2014-03-25 15:09:16.506968	2014-03-25 15:09:16.506968
1137	web development	webdevelopment	2	2014-03-25 15:09:16.510628	2014-03-25 15:09:16.510628
1138	dev	dev	2	2014-03-25 15:09:16.513863	2014-03-25 15:09:16.513863
1139	sysadmin	sysadmin	2	2014-03-25 15:09:16.51701	2014-03-25 15:09:16.51701
1140	raspberry pi	raspberrypi	2	2014-03-25 15:09:16.520168	2014-03-25 15:09:16.520168
1141	arduino	arduino	2	2014-03-25 15:09:16.523695	2014-03-25 15:09:16.523695
1142	d3	d3	2	2014-03-25 15:09:16.527147	2014-03-25 15:09:16.527147
1143	macbook	macbook	2	2014-03-25 15:09:16.530451	2014-03-25 15:09:16.530451
1144	app	app	2	2014-03-25 15:09:16.534055	2014-03-25 15:09:16.534055
1145	microsoft	microsoft	2	2014-03-25 15:09:16.536911	2014-03-25 15:09:16.536911
1146	netflix	netflix	2	2014-03-25 15:09:16.54055	2014-03-25 15:09:16.54055
1147	programming	programming	2	2014-03-25 15:09:16.543737	2014-03-25 15:09:16.543737
1148	ruby	ruby	2	2014-03-25 15:09:16.546787	2014-03-25 15:09:16.546787
1149	sublime text	sublimetext	2	2014-03-25 15:09:16.550223	2014-03-25 15:09:16.550223
1150	vim	vim	2	2014-03-25 15:09:16.553624	2014-03-25 15:09:16.553624
1151	facebook	facebook	2	2014-03-25 15:09:16.55687	2014-03-25 15:09:16.55687
1152	twitter	twitter	2	2014-03-25 15:09:16.560096	2014-03-25 15:09:16.560096
1153	tech	tech	2	2014-03-25 15:09:16.563611	2014-03-25 15:09:16.563611
1154	whatsapp	whatsapp	2	2014-03-25 15:09:16.566945	2014-03-25 15:09:16.566945
1155	whats app	whatsapp	2	2014-03-25 15:09:16.570454	2014-03-25 15:09:16.570454
1156	snapchat	snapchat	2	2014-03-25 15:09:16.575963	2014-03-25 15:09:16.575963
1157	technology	technology	2	2014-03-25 15:09:16.580775	2014-03-25 15:09:16.580775
1158	dev bootcamp	devbootcamp	2	2014-03-25 15:09:16.585243	2014-03-25 15:09:16.585243
1159	bill gates	billgates	2	2014-03-25 15:09:16.588629	2014-03-25 15:09:16.588629
1160	steve jobs	stevejobs	2	2014-03-25 15:09:16.591712	2014-03-25 15:09:16.591712
1161	google	google	2	2014-03-25 15:09:16.595053	2014-03-25 15:09:16.595053
1162	html	html	2	2014-03-25 15:09:16.598349	2014-03-25 15:09:16.598349
1163	css	css	2	2014-03-25 15:09:16.601536	2014-03-25 15:09:16.601536
1164	python	python	2	2014-03-25 15:09:16.604553	2014-03-25 15:09:16.604553
1165	java	java	2	2014-03-25 15:09:16.607691	2014-03-25 15:09:16.607691
1166	javascript	javascript	2	2014-03-25 15:09:16.610748	2014-03-25 15:09:16.610748
1167	c++	c++	2	2014-03-25 15:09:16.644004	2014-03-25 15:09:16.644004
1168	fortran	fortran	2	2014-03-25 15:09:16.647894	2014-03-25 15:09:16.647894
1169	sublime text 2	sublimetext2	2	2014-03-25 15:09:16.652686	2014-03-25 15:09:16.652686
1170	sublime text 3	sublimetext3	2	2014-03-25 15:09:16.699835	2014-03-25 15:09:16.699835
1171	rspec	rspec	2	2014-03-25 15:09:16.703221	2014-03-25 15:09:16.703221
1172	ajax	ajax	2	2014-03-25 15:09:16.706735	2014-03-25 15:09:16.706735
1173	jquery	jquery	2	2014-03-25 15:09:16.709955	2014-03-25 15:09:16.709955
1174	ux	ux	2	2014-03-25 15:09:16.713367	2014-03-25 15:09:16.713367
1175	ui	ui	2	2014-03-25 15:09:16.716365	2014-03-25 15:09:16.716365
1176	front end	frontend	2	2014-03-25 15:09:16.719764	2014-03-25 15:09:16.719764
1177	front-end	front-end	2	2014-03-25 15:09:16.722795	2014-03-25 15:09:16.722795
1178	back end	backend	2	2014-03-25 15:09:16.726139	2014-03-25 15:09:16.726139
1179	back-end	back-end	2	2014-03-25 15:09:16.729348	2014-03-25 15:09:16.729348
1180	computer science	computerscience	2	2014-03-25 15:09:16.734927	2014-03-25 15:09:16.734927
1181	computer	computer	2	2014-03-25 15:09:16.738035	2014-03-25 15:09:16.738035
1182	technological	technological	2	2014-03-25 15:09:16.741169	2014-03-25 15:09:16.741169
1183	technological advances	technologicaladvances	2	2014-03-25 15:09:16.744298	2014-03-25 15:09:16.744298
1184	technological innovation	technologicalinnovation	2	2014-03-25 15:09:16.74759	2014-03-25 15:09:16.74759
1185	fashion	fashion	19	2014-03-25 15:09:16.751203	2014-03-25 15:09:16.751203
1186	clothes	clothes	19	2014-03-25 15:09:16.754171	2014-03-25 15:09:16.754171
1187	clothing	clothing	19	2014-03-25 15:09:16.757289	2014-03-25 15:09:16.757289
1188	shopping	shopping	19	2014-03-25 15:09:16.760655	2014-03-25 15:09:16.760655
1189	hair	hair	19	2014-03-25 15:09:16.76357	2014-03-25 15:09:16.76357
1190	fashionista	fashionista	19	2014-03-25 15:09:16.766817	2014-03-25 15:09:16.766817
1191	apparel	apparel	19	2014-03-25 15:09:16.77056	2014-03-25 15:09:16.77056
1192	fashion plate	fashionplate	19	2014-03-25 15:09:16.773594	2014-03-25 15:09:16.773594
1193	nails	nails	19	2014-03-25 15:09:16.776874	2014-03-25 15:09:16.776874
1194	fingernails	fingernails	19	2014-03-25 15:09:16.780442	2014-03-25 15:09:16.780442
1195	blouse	blouse	19	2014-03-25 15:09:16.783432	2014-03-25 15:09:16.783432
1196	cardigan	cardigan	19	2014-03-25 15:09:16.786864	2014-03-25 15:09:16.786864
1197	sweater	sweater	19	2014-03-25 15:09:16.790143	2014-03-25 15:09:16.790143
1198	nail polish	nailpolish	19	2014-03-25 15:09:16.794425	2014-03-25 15:09:16.794425
1199	nail art	nailart	19	2014-03-25 15:09:16.799202	2014-03-25 15:09:16.799202
1200	beauty	beauty	19	2014-03-25 15:09:16.803825	2014-03-25 15:09:16.803825
1201	uggs	uggs	19	2014-03-25 15:09:16.807572	2014-03-25 15:09:16.807572
1202	notd	notd	19	2014-03-25 15:09:16.811226	2014-03-25 15:09:16.811226
1203	ootd	ootd	19	2014-03-25 15:09:16.814351	2014-03-25 15:09:16.814351
1204	outfit	outfit	19	2014-03-25 15:09:16.817514	2014-03-25 15:09:16.817514
1205	fashion freak	fashionfreak	19	2014-03-25 15:09:16.820764	2014-03-25 15:09:16.820764
1206	fashion tip	fashiontip	19	2014-03-25 15:09:16.824222	2014-03-25 15:09:16.824222
1207	fashion slave	fashionslave	19	2014-03-25 15:09:16.827735	2014-03-25 15:09:16.827735
1208	slave to fashion	slavetofashion	19	2014-03-25 15:09:16.830757	2014-03-25 15:09:16.830757
1209	style blog	styleblog	19	2014-03-25 15:09:16.833943	2014-03-25 15:09:16.833943
1210	my haul	myhaul	19	2014-03-25 15:09:16.837681	2014-03-25 15:09:16.837681
1211	makeup	makeup	19	2014-03-25 15:09:16.840825	2014-03-25 15:09:16.840825
1212	flawless	flawless	19	2014-03-25 15:09:16.84393	2014-03-25 15:09:16.84393
1213	gorgeous	gorgeous	19	2014-03-25 15:09:16.847003	2014-03-25 15:09:16.847003
1214	sephora	sephora	19	2014-03-25 15:09:16.850057	2014-03-25 15:09:16.850057
1215	sunnies	sunnies	19	2014-03-25 15:09:16.853137	2014-03-25 15:09:16.853137
1216	sunglasses	sunglasses	19	2014-03-25 15:09:16.856298	2014-03-25 15:09:16.856298
1217	accessories	accessories	19	2014-03-25 15:09:16.859362	2014-03-25 15:09:16.859362
1218	accessory	accessory	19	2014-03-25 15:09:16.862444	2014-03-25 15:09:16.862444
1219	purse	purse	19	2014-03-25 15:09:16.865541	2014-03-25 15:09:16.865541
1220	clutch	clutch	19	2014-03-25 15:09:16.868733	2014-03-25 15:09:16.868733
1221	scarf	scarf	19	2014-03-25 15:09:16.872117	2014-03-25 15:09:16.872117
1222	necklace	necklace	19	2014-03-25 15:09:16.875007	2014-03-25 15:09:16.875007
1223	earring	earring	19	2014-03-25 15:09:16.878778	2014-03-25 15:09:16.878778
1224	earrings	earrings	19	2014-03-25 15:09:16.881866	2014-03-25 15:09:16.881866
1225	jewelry	jewelry	19	2014-03-25 15:09:16.884935	2014-03-25 15:09:16.884935
1226	diamond ring	diamondring	19	2014-03-25 15:09:16.88809	2014-03-25 15:09:16.88809
1227	diamond	diamond	19	2014-03-25 15:09:16.891355	2014-03-25 15:09:16.891355
1228	sapphire	sapphire	19	2014-03-25 15:09:16.894348	2014-03-25 15:09:16.894348
1229	emerald	emerald	19	2014-03-25 15:09:16.897568	2014-03-25 15:09:16.897568
1230	jewels	jewels	19	2014-03-25 15:09:16.900851	2014-03-25 15:09:16.900851
1231	bangles	bangles	19	2014-03-25 15:09:16.904032	2014-03-25 15:09:16.904032
1232	necklaces	necklaces	19	2014-03-25 15:09:16.907302	2014-03-25 15:09:16.907302
1233	bracelet	bracelet	19	2014-03-25 15:09:16.910362	2014-03-25 15:09:16.910362
1234	bracelets	bracelets	19	2014-03-25 15:09:16.913327	2014-03-25 15:09:16.913327
1235	lipstick	lipstick	19	2014-03-25 15:09:16.916519	2014-03-25 15:09:16.916519
1236	lippy	lippy	19	2014-03-25 15:09:16.920139	2014-03-25 15:09:16.920139
1237	toner	toner	19	2014-03-25 15:09:16.924239	2014-03-25 15:09:16.924239
1238	primer	primer	19	2014-03-25 15:09:16.928537	2014-03-25 15:09:16.928537
1239	eyeshadow	eyeshadow	19	2014-03-25 15:09:16.933078	2014-03-25 15:09:16.933078
1240	blush	blush	19	2014-03-25 15:09:16.937762	2014-03-25 15:09:16.937762
1241	makeup primer	makeupprimer	19	2014-03-25 15:09:16.941165	2014-03-25 15:09:16.941165
1242	face primer	faceprimer	19	2014-03-25 15:09:16.944437	2014-03-25 15:09:16.944437
1243	eye primer	eyeprimer	19	2014-03-25 15:09:16.947827	2014-03-25 15:09:16.947827
1244	lotion	lotion	19	2014-03-25 15:09:16.951006	2014-03-25 15:09:16.951006
1245	body lotion	bodylotion	19	2014-03-25 15:09:16.954359	2014-03-25 15:09:16.954359
1246	face lotion	facelotion	19	2014-03-25 15:09:16.957707	2014-03-25 15:09:16.957707
1247	eyeliner	eyeliner	19	2014-03-25 15:09:16.961124	2014-03-25 15:09:16.961124
1248	smudge pot	smudgepot	19	2014-03-25 15:09:16.964678	2014-03-25 15:09:16.964678
1249	lip gloss	lipgloss	19	2014-03-25 15:09:16.968296	2014-03-25 15:09:16.968296
1250	lip liner	lipliner	19	2014-03-25 15:09:16.972043	2014-03-25 15:09:16.972043
1251	mascara	mascara	19	2014-03-25 15:09:16.975632	2014-03-25 15:09:16.975632
1252	ulta	ulta	19	2014-03-25 15:09:16.978715	2014-03-25 15:09:16.978715
1253	legging	legging	19	2014-03-25 15:09:16.982178	2014-03-25 15:09:16.982178
1254	leggings	leggings	19	2014-03-25 15:09:16.985304	2014-03-25 15:09:16.985304
1255	urban outfitters	urbanoutfitters	19	2014-03-25 15:09:16.988436	2014-03-25 15:09:16.988436
1256	anthropologie	anthropologie	19	2014-03-25 15:09:16.991642	2014-03-25 15:09:16.991642
1257	forever 21	forever21	19	2014-03-25 15:09:16.994603	2014-03-25 15:09:16.994603
1258	american apparel	americanapparel	19	2014-03-25 15:09:16.998089	2014-03-25 15:09:16.998089
1259	gucci	gucci	19	2014-03-25 15:09:17.001409	2014-03-25 15:09:17.001409
1260	prada	prada	19	2014-03-25 15:09:17.004649	2014-03-25 15:09:17.004649
1261	louis vuitton	louisvuitton	19	2014-03-25 15:09:17.007688	2014-03-25 15:09:17.007688
1262	chanel	chanel	19	2014-03-25 15:09:17.01088	2014-03-25 15:09:17.01088
1263	bcbg	bcbg	19	2014-03-25 15:09:17.01436	2014-03-25 15:09:17.01436
1264	fendi	fendi	19	2014-03-25 15:09:17.017413	2014-03-25 15:09:17.017413
1265	nordstrom	nordstrom	19	2014-03-25 15:09:17.020697	2014-03-25 15:09:17.020697
1266	bloomingdales	bloomingdales	19	2014-03-25 15:09:17.024164	2014-03-25 15:09:17.024164
1267	bloomies	bloomies	19	2014-03-25 15:09:17.027553	2014-03-25 15:09:17.027553
1268	saks	saks	19	2014-03-25 15:09:17.03097	2014-03-25 15:09:17.03097
1269	manolo blahnik	manoloblahnik	19	2014-03-25 15:09:17.034187	2014-03-25 15:09:17.034187
1270	salon	salon	19	2014-03-25 15:09:17.037267	2014-03-25 15:09:17.037267
1271	louboutins	louboutins	19	2014-03-25 15:09:17.040912	2014-03-25 15:09:17.040912
1272	louboutin	louboutin	19	2014-03-25 15:09:17.044416	2014-03-25 15:09:17.044416
1273	armani	armani	19	2014-03-25 15:09:17.047662	2014-03-25 15:09:17.047662
1274	burberry	burberry	19	2014-03-25 15:09:17.051315	2014-03-25 15:09:17.051315
1275	j-crew	j-crew	19	2014-03-25 15:09:17.054581	2014-03-25 15:09:17.054581
1276	j crew	jcrew	19	2014-03-25 15:09:17.057955	2014-03-25 15:09:17.057955
1277	banana republic	bananarepublic	19	2014-03-25 15:09:17.060956	2014-03-25 15:09:17.060956
1278	dress	dress	19	2014-03-25 15:09:17.064475	2014-03-25 15:09:17.064475
1279	rag and bone	ragandbone	19	2014-03-25 15:09:17.067462	2014-03-25 15:09:17.067462
1280	skirt	skirt	19	2014-03-25 15:09:17.070887	2014-03-25 15:09:17.070887
1281	shirt	shirt	19	2014-03-25 15:09:17.075285	2014-03-25 15:09:17.075285
1282	jacket	jacket	19	2014-03-25 15:09:17.079005	2014-03-25 15:09:17.079005
1283	leather jacket	leatherjacket	19	2014-03-25 15:09:17.082407	2014-03-25 15:09:17.082407
1284	cutest outfit	cutestoutfit	19	2014-03-25 15:09:17.088696	2014-03-25 15:09:17.088696
1285	cute outfit	cuteoutfit	19	2014-03-25 15:09:17.092184	2014-03-25 15:09:17.092184
1286	looking good	lookinggood	19	2014-03-25 15:09:17.095393	2014-03-25 15:09:17.095393
1287	cute dress	cutedress	19	2014-03-25 15:09:17.098579	2014-03-25 15:09:17.098579
1288	shoes	shoes	19	2014-03-25 15:09:17.101883	2014-03-25 15:09:17.101883
1289	cute shoes	cuteshoes	19	2014-03-25 15:09:17.105376	2014-03-25 15:09:17.105376
1290	hat	hat	19	2014-03-25 15:09:17.108672	2014-03-25 15:09:17.108672
1291	slouchy boots	slouchyboots	19	2014-03-25 15:09:17.111816	2014-03-25 15:09:17.111816
1292	boots	boots	19	2014-03-25 15:09:17.115057	2014-03-25 15:09:17.115057
1293	knee high boots	kneehighboots	19	2014-03-25 15:09:17.118634	2014-03-25 15:09:17.118634
1294	tights	tights	19	2014-03-25 15:09:17.121625	2014-03-25 15:09:17.121625
1295	fleece lined tights	fleecelinedtights	19	2014-03-25 15:09:17.124926	2014-03-25 15:09:17.124926
1296	fleece tights	fleecetights	19	2014-03-25 15:09:17.127995	2014-03-25 15:09:17.127995
1297	mz wallace	mzwallace	19	2014-03-25 15:09:17.131156	2014-03-25 15:09:17.131156
1298	kate spade	katespade	19	2014-03-25 15:09:17.134187	2014-03-25 15:09:17.134187
1299	michael kors	michaelkors	19	2014-03-25 15:09:17.137593	2014-03-25 15:09:17.137593
1300	project runway	projectrunway	19	2014-03-25 15:09:17.14096	2014-03-25 15:09:17.14096
1301	model	model	19	2014-03-25 15:09:17.144351	2014-03-25 15:09:17.144351
1302	supermodel	supermodel	19	2014-03-25 15:09:17.147524	2014-03-25 15:09:17.147524
1303	high fashion	highfashion	19	2014-03-25 15:09:17.151083	2014-03-25 15:09:17.151083
1518	walnut	walnut	1	2014-03-25 15:09:18.075507	2014-03-25 15:09:18.075507
1304	new york fashion week	newyorkfashionweek	19	2014-03-25 15:09:17.154066	2014-03-25 15:09:17.154066
1305	fashion week	fashionweek	19	2014-03-25 15:09:17.157398	2014-03-25 15:09:17.157398
1306	runway	runway	19	2014-03-25 15:09:17.160624	2014-03-25 15:09:17.160624
1307	runway show	runwayshow	19	2014-03-25 15:09:17.164133	2014-03-25 15:09:17.164133
1308	fashion model	fashionmodel	19	2014-03-25 15:09:17.167103	2014-03-25 15:09:17.167103
1309	haute couture	hautecouture	19	2014-03-25 15:09:17.1706	2014-03-25 15:09:17.1706
1310	couture	couture	19	2014-03-25 15:09:17.173666	2014-03-25 15:09:17.173666
1311	stylist	stylist	19	2014-03-25 15:09:17.205727	2014-03-25 15:09:17.205727
1312	celebrity stylist	celebritystylist	19	2014-03-25 15:09:17.21041	2014-03-25 15:09:17.21041
1313	rachel zoe	rachelzoe	19	2014-03-25 15:09:17.214103	2014-03-25 15:09:17.214103
1314	fashion consultant	fashionconsultant	19	2014-03-25 15:09:17.218458	2014-03-25 15:09:17.218458
1315	get my hair done	getmyhairdone	19	2014-03-25 15:09:17.222667	2014-03-25 15:09:17.222667
1316	get my hair cut	getmyhaircut	19	2014-03-25 15:09:17.226868	2014-03-25 15:09:17.226868
1317	hair cut	haircut	19	2014-03-25 15:09:17.231013	2014-03-25 15:09:17.231013
1318	hair dye	hairdye	19	2014-03-25 15:09:17.235122	2014-03-25 15:09:17.235122
1319	hair bow	hairbow	19	2014-03-25 15:09:17.239164	2014-03-25 15:09:17.239164
1320	ascot	ascot	19	2014-03-25 15:09:17.243356	2014-03-25 15:09:17.243356
1321	hair accessories	hairaccessories	19	2014-03-25 15:09:17.247699	2014-03-25 15:09:17.247699
1322	locket	locket	19	2014-03-25 15:09:17.252026	2014-03-25 15:09:17.252026
1323	brooch	brooch	19	2014-03-25 15:09:17.255873	2014-03-25 15:09:17.255873
1324	high heels	highheels	19	2014-03-25 15:09:17.260097	2014-03-25 15:09:17.260097
1325	heels	heels	19	2014-03-25 15:09:17.264227	2014-03-25 15:09:17.264227
1326	stilettos	stilettos	19	2014-03-25 15:09:17.268391	2014-03-25 15:09:17.268391
1327	high heeled	highheeled	19	2014-03-25 15:09:17.272663	2014-03-25 15:09:17.272663
1328	pumps	pumps	19	2014-03-25 15:09:17.277035	2014-03-25 15:09:17.277035
1329	high heeled shoes	highheeledshoes	19	2014-03-25 15:09:17.281224	2014-03-25 15:09:17.281224
1330	high heeled boots	highheeledboots	19	2014-03-25 15:09:17.285329	2014-03-25 15:09:17.285329
1331	three inch heels	threeinchheels	19	2014-03-25 15:09:17.289748	2014-03-25 15:09:17.289748
1332	four inch heels	fourinchheels	19	2014-03-25 15:09:17.294321	2014-03-25 15:09:17.294321
1333	two inch heels	twoinchheels	19	2014-03-25 15:09:17.298691	2014-03-25 15:09:17.298691
1334	3 inch heels	3inchheels	19	2014-03-25 15:09:17.303399	2014-03-25 15:09:17.303399
1335	4 inch heels	4inchheels	19	2014-03-25 15:09:17.351079	2014-03-25 15:09:17.351079
1336	2 inch heels	2inchheels	19	2014-03-25 15:09:17.354752	2014-03-25 15:09:17.354752
1337	mani pedi	manipedi	19	2014-03-25 15:09:17.358245	2014-03-25 15:09:17.358245
1338	mani	mani	19	2014-03-25 15:09:17.361298	2014-03-25 15:09:17.361298
1339	pedi	pedi	19	2014-03-25 15:09:17.364473	2014-03-25 15:09:17.364473
1340	manicure	manicure	19	2014-03-25 15:09:17.367931	2014-03-25 15:09:17.367931
1341	pedicure	pedicure	19	2014-03-25 15:09:17.371604	2014-03-25 15:09:17.371604
1342	brazilian blowout	brazilianblowout	19	2014-03-25 15:09:17.37463	2014-03-25 15:09:17.37463
1343	bikini wax	bikiniwax	19	2014-03-25 15:09:17.377973	2014-03-25 15:09:17.377973
1344	full face of slap	fullfaceofslap	19	2014-03-25 15:09:17.38153	2014-03-25 15:09:17.38153
1345	full face o slap	fullfaceoslap	19	2014-03-25 15:09:17.384732	2014-03-25 15:09:17.384732
1346	no makeup	nomakeup	19	2014-03-25 15:09:17.387944	2014-03-25 15:09:17.387944
1347	without makeup	withoutmakeup	19	2014-03-25 15:09:17.391394	2014-03-25 15:09:17.391394
1348	sans makeup	sansmakeup	19	2014-03-25 15:09:17.395434	2014-03-25 15:09:17.395434
1349	spanx	spanx	19	2014-03-25 15:09:17.399117	2014-03-25 15:09:17.399117
1350	kitten heels	kittenheels	19	2014-03-25 15:09:17.402739	2014-03-25 15:09:17.402739
1351	bronzer	bronzer	19	2014-03-25 15:09:17.406116	2014-03-25 15:09:17.406116
1352	moisturize	moisturize	19	2014-03-25 15:09:17.409716	2014-03-25 15:09:17.409716
1353	moisturizer	moisturizer	19	2014-03-25 15:09:17.413421	2014-03-25 15:09:17.413421
1354	daily moisturizer	dailymoisturizer	19	2014-03-25 15:09:17.417127	2014-03-25 15:09:17.417127
1355	facial moisturizer	facialmoisturizer	19	2014-03-25 15:09:17.420473	2014-03-25 15:09:17.420473
1356	body moisturizer	bodymoisturizer	19	2014-03-25 15:09:17.424427	2014-03-25 15:09:17.424427
1357	juicy couture	juicycouture	19	2014-03-25 15:09:17.428048	2014-03-25 15:09:17.428048
1358	heidi klum	heidiklum	19	2014-03-25 15:09:17.431687	2014-03-25 15:09:17.431687
1359	tim gunn	timgunn	19	2014-03-25 15:09:17.435236	2014-03-25 15:09:17.435236
1360	make it work	makeitwork	19	2014-03-25 15:09:17.438726	2014-03-25 15:09:17.438726
1361	cafeteria	cafeteria	1	2014-03-25 15:09:17.441942	2014-03-25 15:09:17.441942
1362	caf	caf	1	2014-03-25 15:09:17.445306	2014-03-25 15:09:17.445306
1363	dining	dining	1	2014-03-25 15:09:17.448778	2014-03-25 15:09:17.448778
1364	barista	barista	1	2014-03-25 15:09:17.452041	2014-03-25 15:09:17.452041
1365	favorite barista	favoritebarista	1	2014-03-25 15:09:17.45555	2014-03-25 15:09:17.45555
1366	favorite restaurant	favoriterestaurant	1	2014-03-25 15:09:17.458733	2014-03-25 15:09:17.458733
1367	favorite cafe	favoritecafe	1	2014-03-25 15:09:17.46217	2014-03-25 15:09:17.46217
1368	favorite food	favoritefood	1	2014-03-25 15:09:17.465481	2014-03-25 15:09:17.465481
1369	favorite drink	favoritedrink	1	2014-03-25 15:09:17.468878	2014-03-25 15:09:17.468878
1370	eat	eat	1	2014-03-25 15:09:17.472149	2014-03-25 15:09:17.472149
1371	eating	eating	1	2014-03-25 15:09:17.475359	2014-03-25 15:09:17.475359
1372	ate	ate	1	2014-03-25 15:09:17.478431	2014-03-25 15:09:17.478431
1373	over ate	overate	1	2014-03-25 15:09:17.481581	2014-03-25 15:09:17.481581
1374	over eating	overeating	1	2014-03-25 15:09:17.485005	2014-03-25 15:09:17.485005
1375	over eat	overeat	1	2014-03-25 15:09:17.488045	2014-03-25 15:09:17.488045
1376	dining hall	dininghall	1	2014-03-25 15:09:17.49154	2014-03-25 15:09:17.49154
1377	food	food	1	2014-03-25 15:09:17.494435	2014-03-25 15:09:17.494435
1378	donut	donut	1	2014-03-25 15:09:17.497871	2014-03-25 15:09:17.497871
1379	good food	goodfood	1	2014-03-25 15:09:17.501024	2014-03-25 15:09:17.501024
1380	muffin	muffin	1	2014-03-25 15:09:17.50445	2014-03-25 15:09:17.50445
1381	donuts	donuts	1	2014-03-25 15:09:17.507604	2014-03-25 15:09:17.507604
1382	muffins	muffins	1	2014-03-25 15:09:17.511207	2014-03-25 15:09:17.511207
1383	breakfast	breakfast	1	2014-03-25 15:09:17.515185	2014-03-25 15:09:17.515185
1384	lunch	lunch	1	2014-03-25 15:09:17.518304	2014-03-25 15:09:17.518304
1385	dinner	dinner	1	2014-03-25 15:09:17.521611	2014-03-25 15:09:17.521611
1386	brunch	brunch	1	2014-03-25 15:09:17.524735	2014-03-25 15:09:17.524735
1387	grub	grub	1	2014-03-25 15:09:17.528692	2014-03-25 15:09:17.528692
1388	grubhub	grubhub	1	2014-03-25 15:09:17.532418	2014-03-25 15:09:17.532418
1389	lemon	lemon	1	2014-03-25 15:09:17.535617	2014-03-25 15:09:17.535617
1390	lime	lime	1	2014-03-25 15:09:17.538883	2014-03-25 15:09:17.538883
1391	citrus	citrus	1	2014-03-25 15:09:17.541972	2014-03-25 15:09:17.541972
1392	green beans	greenbeans	1	2014-03-25 15:09:17.54565	2014-03-25 15:09:17.54565
1393	beans	beans	1	2014-03-25 15:09:17.548615	2014-03-25 15:09:17.548615
1394	black beans	blackbeans	1	2014-03-25 15:09:17.551927	2014-03-25 15:09:17.551927
1395	refried beans	refriedbeans	1	2014-03-25 15:09:17.5555	2014-03-25 15:09:17.5555
1396	cupcake	cupcake	1	2014-03-25 15:09:17.558522	2014-03-25 15:09:17.558522
1397	cupcakes	cupcakes	1	2014-03-25 15:09:17.561993	2014-03-25 15:09:17.561993
1398	almond	almond	1	2014-03-25 15:09:17.565006	2014-03-25 15:09:17.565006
1399	almonds	almonds	1	2014-03-25 15:09:17.568191	2014-03-25 15:09:17.568191
1400	nuts	nuts	1	2014-03-25 15:09:17.571539	2014-03-25 15:09:17.571539
1401	nut	nut	1	2014-03-25 15:09:17.575428	2014-03-25 15:09:17.575428
1402	cranberry	cranberry	1	2014-03-25 15:09:17.579263	2014-03-25 15:09:17.579263
1403	cranberries	cranberries	1	2014-03-25 15:09:17.582614	2014-03-25 15:09:17.582614
1404	berries	berries	1	2014-03-25 15:09:17.585847	2014-03-25 15:09:17.585847
1405	berry	berry	1	2014-03-25 15:09:17.589521	2014-03-25 15:09:17.589521
1406	fruit	fruit	1	2014-03-25 15:09:17.592568	2014-03-25 15:09:17.592568
1407	dried fruit	driedfruit	1	2014-03-25 15:09:17.595746	2014-03-25 15:09:17.595746
1408	foods	foods	1	2014-03-25 15:09:17.599972	2014-03-25 15:09:17.599972
1409	fatty foods	fattyfoods	1	2014-03-25 15:09:17.603527	2014-03-25 15:09:17.603527
1410	fried foods	friedfoods	1	2014-03-25 15:09:17.606686	2014-03-25 15:09:17.606686
1411	fatty food	fattyfood	1	2014-03-25 15:09:17.610316	2014-03-25 15:09:17.610316
1412	fried food	friedfood	1	2014-03-25 15:09:17.614246	2014-03-25 15:09:17.614246
1413	country cooking	countrycooking	1	2014-03-25 15:09:17.617755	2014-03-25 15:09:17.617755
1414	country cookin	countrycookin	1	2014-03-25 15:09:17.621106	2014-03-25 15:09:17.621106
1415	soul food	soulfood	1	2014-03-25 15:09:17.626032	2014-03-25 15:09:17.626032
1416	fried chicken	friedchicken	1	2014-03-25 15:09:17.629938	2014-03-25 15:09:17.629938
1417	collard greens	collardgreens	1	2014-03-25 15:09:17.633563	2014-03-25 15:09:17.633563
1418	greens	greens	1	2014-03-25 15:09:17.637389	2014-03-25 15:09:17.637389
1419	kale chips	kalechips	1	2014-03-25 15:09:17.641604	2014-03-25 15:09:17.641604
1420	kale chip	kalechip	1	2014-03-25 15:09:17.645058	2014-03-25 15:09:17.645058
1421	grape	grape	1	2014-03-25 15:09:17.648454	2014-03-25 15:09:17.648454
1422	grapes	grapes	1	2014-03-25 15:09:17.651648	2014-03-25 15:09:17.651648
1423	strawberry	strawberry	1	2014-03-25 15:09:17.654965	2014-03-25 15:09:17.654965
1424	strawberries	strawberries	1	2014-03-25 15:09:17.658549	2014-03-25 15:09:17.658549
1425	raspberry	raspberry	1	2014-03-25 15:09:17.661693	2014-03-25 15:09:17.661693
1426	raspberries	raspberries	1	2014-03-25 15:09:17.665049	2014-03-25 15:09:17.665049
1427	blueberry	blueberry	1	2014-03-25 15:09:17.668118	2014-03-25 15:09:17.668118
1428	blueberries	blueberries	1	2014-03-25 15:09:17.671719	2014-03-25 15:09:17.671719
1429	melon	melon	1	2014-03-25 15:09:17.675097	2014-03-25 15:09:17.675097
1430	melons	melons	1	2014-03-25 15:09:17.678459	2014-03-25 15:09:17.678459
1431	papaya	papaya	1	2014-03-25 15:09:17.681583	2014-03-25 15:09:17.681583
1432	milkshake	milkshake	1	2014-03-25 15:09:17.684571	2014-03-25 15:09:17.684571
1433	fast food	fastfood	1	2014-03-25 15:09:17.688143	2014-03-25 15:09:17.688143
1434	sit down restaurant	sitdownrestaurant	1	2014-03-25 15:09:17.691527	2014-03-25 15:09:17.691527
1435	fast food restaurant	fastfoodrestaurant	1	2014-03-25 15:09:17.694877	2014-03-25 15:09:17.694877
1436	jalapenos	jalapenos	1	2014-03-25 15:09:17.698347	2014-03-25 15:09:17.698347
1437	brown rice	brownrice	1	2014-03-25 15:09:17.701811	2014-03-25 15:09:17.701811
1438	tabasco	tabasco	1	2014-03-25 15:09:17.705453	2014-03-25 15:09:17.705453
1439	sriracha	sriracha	1	2014-03-25 15:09:17.708601	2014-03-25 15:09:17.708601
1440	hot sauce	hotsauce	1	2014-03-25 15:09:17.711909	2014-03-25 15:09:17.711909
1441	mustard	mustard	1	2014-03-25 15:09:17.715506	2014-03-25 15:09:17.715506
1442	ketchup	ketchup	1	2014-03-25 15:09:17.718571	2014-03-25 15:09:17.718571
1443	catsup	catsup	1	2014-03-25 15:09:17.722061	2014-03-25 15:09:17.722061
1444	pickles	pickles	1	2014-03-25 15:09:17.725633	2014-03-25 15:09:17.725633
1445	pickle	pickle	1	2014-03-25 15:09:17.729673	2014-03-25 15:09:17.729673
1446	peppers	peppers	1	2014-03-25 15:09:17.734171	2014-03-25 15:09:17.734171
1447	pepper	pepper	1	2014-03-25 15:09:17.737933	2014-03-25 15:09:17.737933
1448	hot peppers	hotpeppers	1	2014-03-25 15:09:17.741195	2014-03-25 15:09:17.741195
1449	meal plan	mealplan	1	2014-03-25 15:09:17.744564	2014-03-25 15:09:17.744564
1450	meal	meal	1	2014-03-25 15:09:17.74768	2014-03-25 15:09:17.74768
1451	vegan	vegan	1	2014-03-25 15:09:17.751194	2014-03-25 15:09:17.751194
1452	gluten free	glutenfree	1	2014-03-25 15:09:17.755775	2014-03-25 15:09:17.755775
1453	gf	gf	1	2014-03-25 15:09:17.759992	2014-03-25 15:09:17.759992
1454	veganism	veganism	1	2014-03-25 15:09:17.763398	2014-03-25 15:09:17.763398
1455	vegetarianism	vegetarianism	1	2014-03-25 15:09:17.766969	2014-03-25 15:09:17.766969
1456	vegetarian	vegetarian	1	2014-03-25 15:09:17.770565	2014-03-25 15:09:17.770565
1457	vegeterianism	vegeterianism	1	2014-03-25 15:09:17.77352	2014-03-25 15:09:17.77352
1458	vegeterian	vegeterian	1	2014-03-25 15:09:17.776853	2014-03-25 15:09:17.776853
1459	gluten	gluten	1	2014-03-25 15:09:17.779921	2014-03-25 15:09:17.779921
1460	coffee	coffee	1	2014-03-25 15:09:17.783211	2014-03-25 15:09:17.783211
1461	caffiene	caffiene	1	2014-03-25 15:09:17.786909	2014-03-25 15:09:17.786909
1462	caffeine	caffeine	1	2014-03-25 15:09:17.790503	2014-03-25 15:09:17.790503
1463	hamburger	hamburger	1	2014-03-25 15:09:17.793706	2014-03-25 15:09:17.793706
1464	burger	burger	1	2014-03-25 15:09:17.796848	2014-03-25 15:09:17.796848
1465	pizza	pizza	1	2014-03-25 15:09:17.800105	2014-03-25 15:09:17.800105
1466	burgers	burgers	1	2014-03-25 15:09:17.803495	2014-03-25 15:09:17.803495
1467	fries	fries	1	2014-03-25 15:09:17.806574	2014-03-25 15:09:17.806574
1468	eggs	eggs	1	2014-03-25 15:09:17.809957	2014-03-25 15:09:17.809957
1469	eggs benedict	eggsbenedict	1	2014-03-25 15:09:17.813518	2014-03-25 15:09:17.813518
1470	omelette	omelette	1	2014-03-25 15:09:17.816754	2014-03-25 15:09:17.816754
1471	pancakes	pancakes	1	2014-03-25 15:09:17.819927	2014-03-25 15:09:17.819927
1472	waffles	waffles	1	2014-03-25 15:09:17.8233	2014-03-25 15:09:17.8233
1473	oatmeal	oatmeal	1	2014-03-25 15:09:17.826854	2014-03-25 15:09:17.826854
1474	cereal	cereal	1	2014-03-25 15:09:17.829942	2014-03-25 15:09:17.829942
1475	bacon	bacon	1	2014-03-25 15:09:17.833106	2014-03-25 15:09:17.833106
1476	sausage	sausage	1	2014-03-25 15:09:17.864464	2014-03-25 15:09:17.864464
1477	bacon fat	baconfat	1	2014-03-25 15:09:17.868552	2014-03-25 15:09:17.868552
1478	bacon flavored	baconflavored	1	2014-03-25 15:09:17.872559	2014-03-25 15:09:17.872559
1479	bacon salt	baconsalt	1	2014-03-25 15:09:17.876184	2014-03-25 15:09:17.876184
1480	ham	ham	1	2014-03-25 15:09:17.880342	2014-03-25 15:09:17.880342
1481	ham steak	hamsteak	1	2014-03-25 15:09:17.884835	2014-03-25 15:09:17.884835
1482	smoothie	smoothie	1	2014-03-25 15:09:17.888625	2014-03-25 15:09:17.888625
1483	scrambled eggs	scrambledeggs	1	2014-03-25 15:09:17.892709	2014-03-25 15:09:17.892709
1484	sunny side up	sunnysideup	1	2014-03-25 15:09:17.896703	2014-03-25 15:09:17.896703
1485	over easy	overeasy	1	2014-03-25 15:09:17.901398	2014-03-25 15:09:17.901398
1486	eggs over easy	eggsovereasy	1	2014-03-25 15:09:17.907661	2014-03-25 15:09:17.907661
1487	hotcakes	hotcakes	1	2014-03-25 15:09:17.91286	2014-03-25 15:09:17.91286
1488	griddle cakes	griddlecakes	1	2014-03-25 15:09:17.917204	2014-03-25 15:09:17.917204
1489	sandwich	sandwich	1	2014-03-25 15:09:17.921137	2014-03-25 15:09:17.921137
1490	huevos rancheros	huevosrancheros	1	2014-03-25 15:09:17.925168	2014-03-25 15:09:17.925168
1491	breakfast sandwich	breakfastsandwich	1	2014-03-25 15:09:17.929321	2014-03-25 15:09:17.929321
1492	bagel	bagel	1	2014-03-25 15:09:17.933649	2014-03-25 15:09:17.933649
1493	breakfast bagel	breakfastbagel	1	2014-03-25 15:09:17.937329	2014-03-25 15:09:17.937329
1494	bagel sandwich	bagelsandwich	1	2014-03-25 15:09:17.941277	2014-03-25 15:09:17.941277
1495	baguette	baguette	1	2014-03-25 15:09:17.945563	2014-03-25 15:09:17.945563
1496	toast	toast	1	2014-03-25 15:09:17.949662	2014-03-25 15:09:17.949662
1497	club sandwich	clubsandwich	1	2014-03-25 15:09:17.95361	2014-03-25 15:09:17.95361
1498	reuben	reuben	1	2014-03-25 15:09:17.957068	2014-03-25 15:09:17.957068
1499	italian beef	italianbeef	1	2014-03-25 15:09:17.961163	2014-03-25 15:09:17.961163
1500	italian beef sandwich	italianbeefsandwich	1	2014-03-25 15:09:17.965231	2014-03-25 15:09:17.965231
1501	philly cheese steak	phillycheesesteak	1	2014-03-25 15:09:18.01105	2014-03-25 15:09:18.01105
1502	philly cheesesteak	phillycheesesteak	1	2014-03-25 15:09:18.014676	2014-03-25 15:09:18.014676
1503	cheesesteak	cheesesteak	1	2014-03-25 15:09:18.017896	2014-03-25 15:09:18.017896
1504	cheese steak	cheesesteak	1	2014-03-25 15:09:18.021414	2014-03-25 15:09:18.021414
1505	hot dog	hotdog	1	2014-03-25 15:09:18.024681	2014-03-25 15:09:18.024681
1506	bratwurst	bratwurst	1	2014-03-25 15:09:18.028096	2014-03-25 15:09:18.028096
1507	italian sausage	italiansausage	1	2014-03-25 15:09:18.03182	2014-03-25 15:09:18.03182
1508	beer and brats	beerandbrats	1	2014-03-25 15:09:18.035956	2014-03-25 15:09:18.035956
1509	cheddarwurst	cheddarwurst	1	2014-03-25 15:09:18.039955	2014-03-25 15:09:18.039955
1510	knockwurst	knockwurst	1	2014-03-25 15:09:18.043846	2014-03-25 15:09:18.043846
1511	schnitzel	schnitzel	1	2014-03-25 15:09:18.04696	2014-03-25 15:09:18.04696
1512	milk	milk	1	2014-03-25 15:09:18.050172	2014-03-25 15:09:18.050172
1513	peanut	peanut	1	2014-03-25 15:09:18.054696	2014-03-25 15:09:18.054696
1514	peanut butter	peanutbutter	1	2014-03-25 15:09:18.058214	2014-03-25 15:09:18.058214
1515	almond butter	almondbutter	1	2014-03-25 15:09:18.061674	2014-03-25 15:09:18.061674
1516	nutella	nutella	1	2014-03-25 15:09:18.065355	2014-03-25 15:09:18.065355
1517	hazelnut	hazelnut	1	2014-03-25 15:09:18.071474	2014-03-25 15:09:18.071474
1519	pecan	pecan	1	2014-03-25 15:09:18.078746	2014-03-25 15:09:18.078746
1520	pistachio	pistachio	1	2014-03-25 15:09:18.082207	2014-03-25 15:09:18.082207
1521	cake	cake	1	2014-03-25 15:09:18.085694	2014-03-25 15:09:18.085694
1522	pie	pie	1	2014-03-25 15:09:18.088995	2014-03-25 15:09:18.088995
1523	chocolate cake	chocolatecake	1	2014-03-25 15:09:18.092899	2014-03-25 15:09:18.092899
1524	cherry pie	cherrypie	1	2014-03-25 15:09:18.095912	2014-03-25 15:09:18.095912
1525	apple pie	applepie	1	2014-03-25 15:09:18.099096	2014-03-25 15:09:18.099096
1526	strawberry rhubarb pie	strawberryrhubarbpie	1	2014-03-25 15:09:18.101986	2014-03-25 15:09:18.101986
1527	pumpkin pie	pumpkinpie	1	2014-03-25 15:09:18.105156	2014-03-25 15:09:18.105156
1528	pecan pie	pecanpie	1	2014-03-25 15:09:18.108294	2014-03-25 15:09:18.108294
1529	ice cream	icecream	1	2014-03-25 15:09:18.111673	2014-03-25 15:09:18.111673
1530	frozen yogurt	frozenyogurt	1	2014-03-25 15:09:18.115307	2014-03-25 15:09:18.115307
1531	custard	custard	1	2014-03-25 15:09:18.118544	2014-03-25 15:09:18.118544
1532	ice cream sundae	icecreamsundae	1	2014-03-25 15:09:18.121837	2014-03-25 15:09:18.121837
1533	ice cream sandwich	icecreamsandwich	1	2014-03-25 15:09:18.125789	2014-03-25 15:09:18.125789
1534	sundae	sundae	1	2014-03-25 15:09:18.128829	2014-03-25 15:09:18.128829
1535	dessert	dessert	1	2014-03-25 15:09:18.132091	2014-03-25 15:09:18.132091
1536	sweets	sweets	1	2014-03-25 15:09:18.135252	2014-03-25 15:09:18.135252
1537	sugar	sugar	1	2014-03-25 15:09:18.138778	2014-03-25 15:09:18.138778
1538	tea	tea	1	2014-03-25 15:09:18.143066	2014-03-25 15:09:18.143066
1539	soda	soda	1	2014-03-25 15:09:18.146319	2014-03-25 15:09:18.146319
1540	pasta	pasta	1	2014-03-25 15:09:18.14991	2014-03-25 15:09:18.14991
1541	spaghetti	spaghetti	1	2014-03-25 15:09:18.153096	2014-03-25 15:09:18.153096
1542	gnocchi	gnocchi	1	2014-03-25 15:09:18.156406	2014-03-25 15:09:18.156406
1543	noodles	noodles	1	2014-03-25 15:09:18.160193	2014-03-25 15:09:18.160193
1544	thai food	thaifood	1	2014-03-25 15:09:18.163236	2014-03-25 15:09:18.163236
1545	thai restaurant	thairestaurant	1	2014-03-25 15:09:18.166593	2014-03-25 15:09:18.166593
1546	thai place	thaiplace	1	2014-03-25 15:09:18.169622	2014-03-25 15:09:18.169622
1547	chinese food	chinesefood	1	2014-03-25 15:09:18.172832	2014-03-25 15:09:18.172832
1548	chinese restaurant	chineserestaurant	1	2014-03-25 15:09:18.176476	2014-03-25 15:09:18.176476
1549	chinese place	chineseplace	1	2014-03-25 15:09:18.179819	2014-03-25 15:09:18.179819
1550	takeout	takeout	1	2014-03-25 15:09:18.183086	2014-03-25 15:09:18.183086
1551	chinese takeout	chinesetakeout	1	2014-03-25 15:09:18.186801	2014-03-25 15:09:18.186801
1552	korean food	koreanfood	1	2014-03-25 15:09:18.190483	2014-03-25 15:09:18.190483
1553	korean restaurant	koreanrestaurant	1	2014-03-25 15:09:18.194359	2014-03-25 15:09:18.194359
1554	korean place	koreanplace	1	2014-03-25 15:09:18.19798	2014-03-25 15:09:18.19798
1555	mexican food	mexicanfood	1	2014-03-25 15:09:18.201406	2014-03-25 15:09:18.201406
1556	mexican restaurant	mexicanrestaurant	1	2014-03-25 15:09:18.204655	2014-03-25 15:09:18.204655
1557	mexican place	mexicanplace	1	2014-03-25 15:09:18.207977	2014-03-25 15:09:18.207977
1558	kimchi	kimchi	1	2014-03-25 15:09:18.211191	2014-03-25 15:09:18.211191
1559	lo mein	lomein	1	2014-03-25 15:09:18.214499	2014-03-25 15:09:18.214499
1560	lomein	lomein	1	2014-03-25 15:09:18.218128	2014-03-25 15:09:18.218128
1561	chow mein	chowmein	1	2014-03-25 15:09:18.221058	2014-03-25 15:09:18.221058
1562	general tso's	generaltso's	1	2014-03-25 15:09:18.224488	2014-03-25 15:09:18.224488
1563	tofu	tofu	1	2014-03-25 15:09:18.228234	2014-03-25 15:09:18.228234
1564	chicken	chicken	1	2014-03-25 15:09:18.231308	2014-03-25 15:09:18.231308
1565	shrimp	shrimp	1	2014-03-25 15:09:18.234616	2014-03-25 15:09:18.234616
1566	lamb	lamb	1	2014-03-25 15:09:18.23777	2014-03-25 15:09:18.23777
1567	eggrolls	eggrolls	1	2014-03-25 15:09:18.241252	2014-03-25 15:09:18.241252
1568	pot stickers	potstickers	1	2014-03-25 15:09:18.244812	2014-03-25 15:09:18.244812
1569	pizza rolls	pizzarolls	1	2014-03-25 15:09:18.247919	2014-03-25 15:09:18.247919
1570	onion rings	onionrings	1	2014-03-25 15:09:18.251235	2014-03-25 15:09:18.251235
1571	curly fries	curlyfries	1	2014-03-25 15:09:18.254835	2014-03-25 15:09:18.254835
1572	bloomin onion	bloominonion	1	2014-03-25 15:09:18.258075	2014-03-25 15:09:18.258075
1573	steak	steak	1	2014-03-25 15:09:18.261702	2014-03-25 15:09:18.261702
1574	dumplings	dumplings	1	2014-03-25 15:09:18.2651	2014-03-25 15:09:18.2651
1575	fried dumplings	frieddumplings	1	2014-03-25 15:09:18.26838	2014-03-25 15:09:18.26838
1576	dim sum	dimsum	1	2014-03-25 15:09:18.271702	2014-03-25 15:09:18.271702
1577	sushi	sushi	1	2014-03-25 15:09:18.275124	2014-03-25 15:09:18.275124
1578	japanese food	japanesefood	1	2014-03-25 15:09:18.278547	2014-03-25 15:09:18.278547
1579	japanese restaurant	japaneserestaurant	1	2014-03-25 15:09:18.281883	2014-03-25 15:09:18.281883
1580	japanese place	japaneseplace	1	2014-03-25 15:09:18.285331	2014-03-25 15:09:18.285331
1581	curry	curry	1	2014-03-25 15:09:18.288743	2014-03-25 15:09:18.288743
1582	spicy	spicy	1	2014-03-25 15:09:18.291838	2014-03-25 15:09:18.291838
1583	rice	rice	1	2014-03-25 15:09:18.295357	2014-03-25 15:09:18.295357
1584	cashew butter	cashewbutter	1	2014-03-25 15:09:18.29885	2014-03-25 15:09:18.29885
1585	fudge	fudge	1	2014-03-25 15:09:18.30186	2014-03-25 15:09:18.30186
1586	maple	maple	1	2014-03-25 15:09:18.30505	2014-03-25 15:09:18.30505
1587	coconut	coconut	1	2014-03-25 15:09:18.308516	2014-03-25 15:09:18.308516
1588	orange	orange	1	2014-03-25 15:09:18.312011	2014-03-25 15:09:18.312011
1589	apple	apple	1	2014-03-25 15:09:18.315238	2014-03-25 15:09:18.315238
1590	peach	peach	1	2014-03-25 15:09:18.318542	2014-03-25 15:09:18.318542
1591	pear	pear	1	2014-03-25 15:09:18.322051	2014-03-25 15:09:18.322051
1592	plum	plum	1	2014-03-25 15:09:18.32529	2014-03-25 15:09:18.32529
1593	banana	banana	1	2014-03-25 15:09:18.328478	2014-03-25 15:09:18.328478
1594	nectarine	nectarine	1	2014-03-25 15:09:18.332625	2014-03-25 15:09:18.332625
1595	cherry	cherry	1	2014-03-25 15:09:18.335604	2014-03-25 15:09:18.335604
1596	cherries	cherries	1	2014-03-25 15:09:18.338961	2014-03-25 15:09:18.338961
1597	oranges	oranges	1	2014-03-25 15:09:18.342916	2014-03-25 15:09:18.342916
1598	coconuts	coconuts	1	2014-03-25 15:09:18.346202	2014-03-25 15:09:18.346202
1599	apples	apples	1	2014-03-25 15:09:18.349639	2014-03-25 15:09:18.349639
1600	peaches	peaches	1	2014-03-25 15:09:18.352873	2014-03-25 15:09:18.352873
1601	plums	plums	1	2014-03-25 15:09:18.356411	2014-03-25 15:09:18.356411
1602	pears	pears	1	2014-03-25 15:09:18.359403	2014-03-25 15:09:18.359403
1603	bananas	bananas	1	2014-03-25 15:09:18.36269	2014-03-25 15:09:18.36269
1604	fruits	fruits	1	2014-03-25 15:09:18.365947	2014-03-25 15:09:18.365947
1605	panang curry	panangcurry	1	2014-03-25 15:09:18.368969	2014-03-25 15:09:18.368969
1606	green curry	greencurry	1	2014-03-25 15:09:18.372096	2014-03-25 15:09:18.372096
1607	red curry	redcurry	1	2014-03-25 15:09:18.375384	2014-03-25 15:09:18.375384
1608	tom kha	tomkha	1	2014-03-25 15:09:18.378492	2014-03-25 15:09:18.378492
1609	soup	soup	1	2014-03-25 15:09:18.381952	2014-03-25 15:09:18.381952
1610	pad thai	padthai	1	2014-03-25 15:09:18.385216	2014-03-25 15:09:18.385216
1611	makimono	makimono	1	2014-03-25 15:09:18.388489	2014-03-25 15:09:18.388489
1612	nigiri	nigiri	1	2014-03-25 15:09:18.391913	2014-03-25 15:09:18.391913
1613	gyoza	gyoza	1	2014-03-25 15:09:18.395491	2014-03-25 15:09:18.395491
1614	bao	bao	1	2014-03-25 15:09:18.399421	2014-03-25 15:09:18.399421
1615	pork buns	porkbuns	1	2014-03-25 15:09:18.402922	2014-03-25 15:09:18.402922
1616	pork belly	porkbelly	1	2014-03-25 15:09:18.408586	2014-03-25 15:09:18.408586
1617	carmelized	carmelized	1	2014-03-25 15:09:18.416313	2014-03-25 15:09:18.416313
1618	onions	onions	1	2014-03-25 15:09:18.419604	2014-03-25 15:09:18.419604
1619	mango	mango	1	2014-03-25 15:09:18.422577	2014-03-25 15:09:18.422577
1620	ginger	ginger	1	2014-03-25 15:09:18.425538	2014-03-25 15:09:18.425538
1621	broccoli	broccoli	1	2014-03-25 15:09:18.429062	2014-03-25 15:09:18.429062
1622	peanut sauce	peanutsauce	1	2014-03-25 15:09:18.432486	2014-03-25 15:09:18.432486
1623	peanut chicken	peanutchicken	1	2014-03-25 15:09:18.435558	2014-03-25 15:09:18.435558
1624	teriyaki	teriyaki	1	2014-03-25 15:09:18.439025	2014-03-25 15:09:18.439025
1625	chipotle	chipotle	1	2014-03-25 15:09:18.442127	2014-03-25 15:09:18.442127
1626	garlic	garlic	1	2014-03-25 15:09:18.445079	2014-03-25 15:09:18.445079
1627	carmelized onions	carmelizedonions	1	2014-03-25 15:09:18.448436	2014-03-25 15:09:18.448436
1628	bahn mi	bahnmi	1	2014-03-25 15:09:18.451839	2014-03-25 15:09:18.451839
1629	pho	pho	1	2014-03-25 15:09:18.455783	2014-03-25 15:09:18.455783
1630	vietnamese food	vietnamesefood	1	2014-03-25 15:09:18.458912	2014-03-25 15:09:18.458912
1631	vietnamese restaurant	vietnameserestaurant	1	2014-03-25 15:09:18.462056	2014-03-25 15:09:18.462056
1632	vietnamese place	vietnameseplace	1	2014-03-25 15:09:18.465714	2014-03-25 15:09:18.465714
1633	italian restaurant	italianrestaurant	1	2014-03-25 15:09:18.468751	2014-03-25 15:09:18.468751
1634	italian food	italianfood	1	2014-03-25 15:09:18.47207	2014-03-25 15:09:18.47207
1635	italian place	italianplace	1	2014-03-25 15:09:18.475787	2014-03-25 15:09:18.475787
1636	russian food	russianfood	1	2014-03-25 15:09:18.47927	2014-03-25 15:09:18.47927
1637	russian restaurant	russianrestaurant	1	2014-03-25 15:09:18.482342	2014-03-25 15:09:18.482342
1638	persian food	persianfood	1	2014-03-25 15:09:18.485911	2014-03-25 15:09:18.485911
1639	persian restaurant	persianrestaurant	1	2014-03-25 15:09:18.488911	2014-03-25 15:09:18.488911
1640	ethnic food	ethnicfood	1	2014-03-25 15:09:18.4923	2014-03-25 15:09:18.4923
1641	burrito	burrito	1	2014-03-25 15:09:18.495366	2014-03-25 15:09:18.495366
1642	burritos	burritos	1	2014-03-25 15:09:18.529619	2014-03-25 15:09:18.529619
1643	chalupa	chalupa	1	2014-03-25 15:09:18.535167	2014-03-25 15:09:18.535167
1644	churro	churro	1	2014-03-25 15:09:18.539271	2014-03-25 15:09:18.539271
1645	tostada	tostada	1	2014-03-25 15:09:18.543013	2014-03-25 15:09:18.543013
1646	enchilada	enchilada	1	2014-03-25 15:09:18.547212	2014-03-25 15:09:18.547212
1647	enchiladas	enchiladas	1	2014-03-25 15:09:18.55148	2014-03-25 15:09:18.55148
1648	chili	chili	1	2014-03-25 15:09:18.556152	2014-03-25 15:09:18.556152
1649	chili con queso	chiliconqueso	1	2014-03-25 15:09:18.5608	2014-03-25 15:09:18.5608
1650	cheese	cheese	1	2014-03-25 15:09:18.565139	2014-03-25 15:09:18.565139
1651	cheese fries	cheesefries	1	2014-03-25 15:09:18.569384	2014-03-25 15:09:18.569384
1652	chili fries	chilifries	1	2014-03-25 15:09:18.574111	2014-03-25 15:09:18.574111
1653	chili cheese fries	chilicheesefries	1	2014-03-25 15:09:18.578308	2014-03-25 15:09:18.578308
1654	pray	pray	18	2014-03-25 15:09:18.582449	2014-03-25 15:09:18.582449
1655	jesus	jesus	18	2014-03-25 15:09:18.586368	2014-03-25 15:09:18.586368
1656	allah	allah	18	2014-03-25 15:09:18.591055	2014-03-25 15:09:18.591055
1657	buddha	buddha	18	2014-03-25 15:09:18.595802	2014-03-25 15:09:18.595802
1658	sermon	sermon	18	2014-03-25 15:09:18.600384	2014-03-25 15:09:18.600384
1659	worship	worship	18	2014-03-25 15:09:18.604835	2014-03-25 15:09:18.604835
1660	sunday mass	sundaymass	18	2014-03-25 15:09:18.609245	2014-03-25 15:09:18.609245
1661	saturday mass	saturdaymass	18	2014-03-25 15:09:18.613499	2014-03-25 15:09:18.613499
1662	god	god	18	2014-03-25 15:09:18.618094	2014-03-25 15:09:18.618094
1663	blessed	blessed	18	2014-03-25 15:09:18.624503	2014-03-25 15:09:18.624503
1664	hymn	hymn	18	2014-03-25 15:09:18.631278	2014-03-25 15:09:18.631278
1665	hymnal	hymnal	18	2014-03-25 15:09:18.635553	2014-03-25 15:09:18.635553
1666	bible	bible	18	2014-03-25 15:09:18.680184	2014-03-25 15:09:18.680184
1667	church	church	18	2014-03-25 15:09:18.684062	2014-03-25 15:09:18.684062
1668	religion	religion	18	2014-03-25 15:09:18.687488	2014-03-25 15:09:18.687488
1669	virtue	virtue	18	2014-03-25 15:09:18.691169	2014-03-25 15:09:18.691169
1670	meditation	meditation	18	2014-03-25 15:09:18.694703	2014-03-25 15:09:18.694703
1671	meditate	meditate	18	2014-03-25 15:09:18.698447	2014-03-25 15:09:18.698447
1672	belief	belief	18	2014-03-25 15:09:18.701598	2014-03-25 15:09:18.701598
1673	beliefs	beliefs	18	2014-03-25 15:09:18.704622	2014-03-25 15:09:18.704622
1674	chapel	chapel	18	2014-03-25 15:09:18.708076	2014-03-25 15:09:18.708076
1675	judaism	judaism	18	2014-03-25 15:09:18.711266	2014-03-25 15:09:18.711266
1676	temple	temple	18	2014-03-25 15:09:18.714611	2014-03-25 15:09:18.714611
1677	bible study	biblestudy	18	2014-03-25 15:09:18.717923	2014-03-25 15:09:18.717923
1678	bible group	biblegroup	18	2014-03-25 15:09:18.721241	2014-03-25 15:09:18.721241
1679	church service	churchservice	18	2014-03-25 15:09:18.724735	2014-03-25 15:09:18.724735
1680	pastor	pastor	18	2014-03-25 15:09:18.728034	2014-03-25 15:09:18.728034
1681	priest	priest	18	2014-03-25 15:09:18.731765	2014-03-25 15:09:18.731765
1682	rabbi	rabbi	18	2014-03-25 15:09:18.734821	2014-03-25 15:09:18.734821
1683	atheism	atheism	18	2014-03-25 15:09:18.737966	2014-03-25 15:09:18.737966
1684	atheist	atheist	18	2014-03-25 15:09:18.741415	2014-03-25 15:09:18.741415
1685	agnostic	agnostic	18	2014-03-25 15:09:18.744522	2014-03-25 15:09:18.744522
1686	agnosticism	agnosticism	18	2014-03-25 15:09:18.749038	2014-03-25 15:09:18.749038
1687	jewish	jewish	18	2014-03-25 15:09:18.753738	2014-03-25 15:09:18.753738
1688	christian	christian	18	2014-03-25 15:09:18.757341	2014-03-25 15:09:18.757341
1689	muslim	muslim	18	2014-03-25 15:09:18.760811	2014-03-25 15:09:18.760811
1690	islam	islam	18	2014-03-25 15:09:18.764687	2014-03-25 15:09:18.764687
1691	buddhist	buddhist	18	2014-03-25 15:09:18.768769	2014-03-25 15:09:18.768769
1692	spiritual	spiritual	18	2014-03-25 15:09:18.772832	2014-03-25 15:09:18.772832
1693	spiritualism	spiritualism	18	2014-03-25 15:09:18.776156	2014-03-25 15:09:18.776156
1694	catholic	catholic	18	2014-03-25 15:09:18.779938	2014-03-25 15:09:18.779938
1695	pope	pope	18	2014-03-25 15:09:18.78348	2014-03-25 15:09:18.78348
1696	bishop	bishop	18	2014-03-25 15:09:18.786789	2014-03-25 15:09:18.786789
1697	righteous	righteous	18	2014-03-25 15:09:18.79006	2014-03-25 15:09:18.79006
1698	cardinal	cardinal	18	2014-03-25 15:09:18.793503	2014-03-25 15:09:18.793503
1699	archbishop	archbishop	18	2014-03-25 15:09:18.796948	2014-03-25 15:09:18.796948
1700	arch bishop	archbishop	18	2014-03-25 15:09:18.800201	2014-03-25 15:09:18.800201
1701	sunday school	sundayschool	18	2014-03-25 15:09:18.804017	2014-03-25 15:09:18.804017
1702	art	art	4	2014-03-25 15:09:18.809901	2014-03-25 15:09:18.809901
1703	artist	artist	4	2014-03-25 15:09:18.813617	2014-03-25 15:09:18.813617
1704	exhibit	exhibit	4	2014-03-25 15:09:18.816899	2014-03-25 15:09:18.816899
1705	art museum	artmuseum	4	2014-03-25 15:09:18.820291	2014-03-25 15:09:18.820291
1706	art museums	artmuseums	4	2014-03-25 15:09:18.823627	2014-03-25 15:09:18.823627
1707	museums	museums	4	2014-03-25 15:09:18.826861	2014-03-25 15:09:18.826861
1708	museum	museum	4	2014-03-25 15:09:18.830365	2014-03-25 15:09:18.830365
1709	institute	institute	4	2014-03-25 15:09:18.833673	2014-03-25 15:09:18.833673
1710	art institute	artinstitute	4	2014-03-25 15:09:18.83697	2014-03-25 15:09:18.83697
1711	art gallery	artgallery	4	2014-03-25 15:09:18.840849	2014-03-25 15:09:18.840849
1712	art opening	artopening	4	2014-03-25 15:09:18.844466	2014-03-25 15:09:18.844466
1713	gallery opening	galleryopening	4	2014-03-25 15:09:18.848429	2014-03-25 15:09:18.848429
1714	gallery	gallery	4	2014-03-25 15:09:18.85217	2014-03-25 15:09:18.85217
1715	surrealist	surrealist	4	2014-03-25 15:09:18.855438	2014-03-25 15:09:18.855438
1716	impressionist	impressionist	4	2014-03-25 15:09:18.859014	2014-03-25 15:09:18.859014
1717	pottery	pottery	4	2014-03-25 15:09:18.862501	2014-03-25 15:09:18.862501
1718	watercolor	watercolor	4	2014-03-25 15:09:18.86557	2014-03-25 15:09:18.86557
1719	watercolors	watercolors	4	2014-03-25 15:09:18.868606	2014-03-25 15:09:18.868606
1720	masterpiece	masterpiece	4	2014-03-25 15:09:18.871826	2014-03-25 15:09:18.871826
1721	oil paint	oilpaint	4	2014-03-25 15:09:18.874972	2014-03-25 15:09:18.874972
1722	oil paints	oilpaints	4	2014-03-25 15:09:18.878829	2014-03-25 15:09:18.878829
1723	acrylic paint	acrylicpaint	4	2014-03-25 15:09:18.881958	2014-03-25 15:09:18.881958
1724	acrylic paints	acrylicpaints	4	2014-03-25 15:09:18.885654	2014-03-25 15:09:18.885654
1725	expressionist	expressionist	4	2014-03-25 15:09:18.889111	2014-03-25 15:09:18.889111
1726	picasso	picasso	4	2014-03-25 15:09:18.892039	2014-03-25 15:09:18.892039
1727	cubist	cubist	4	2014-03-25 15:09:18.895127	2014-03-25 15:09:18.895127
1728	cubism	cubism	4	2014-03-25 15:09:18.898406	2014-03-25 15:09:18.898406
1729	matisse	matisse	4	2014-03-25 15:09:18.90222	2014-03-25 15:09:18.90222
1730	magritte	magritte	4	2014-03-25 15:09:18.905339	2014-03-25 15:09:18.905339
1731	renoir	renoir	4	2014-03-25 15:09:18.908704	2014-03-25 15:09:18.908704
1732	degas	degas	4	2014-03-25 15:09:18.912275	2014-03-25 15:09:18.912275
1733	diy	diy	4	2014-03-25 15:09:18.915541	2014-03-25 15:09:18.915541
1734	do it yourself	doityourself	4	2014-03-25 15:09:18.918781	2014-03-25 15:09:18.918781
1735	crafty	crafty	4	2014-03-25 15:09:18.921786	2014-03-25 15:09:18.921786
1736	artsy	artsy	4	2014-03-25 15:09:18.925386	2014-03-25 15:09:18.925386
1737	crafts	crafts	4	2014-03-25 15:09:18.928487	2014-03-25 15:09:18.928487
1738	knitting	knitting	4	2014-03-25 15:09:18.931639	2014-03-25 15:09:18.931639
1739	sewing	sewing	4	2014-03-25 15:09:18.934774	2014-03-25 15:09:18.934774
1740	open mic	openmic	4	2014-03-25 15:09:18.93797	2014-03-25 15:09:18.93797
1741	poetry book	poetrybook	4	2014-03-25 15:09:18.941286	2014-03-25 15:09:18.941286
1742	book of poems	bookofpoems	4	2014-03-25 15:09:18.944843	2014-03-25 15:09:18.944843
1743	poet	poet	4	2014-03-25 15:09:18.948124	2014-03-25 15:09:18.948124
1744	poetry	poetry	4	2014-03-25 15:09:18.951837	2014-03-25 15:09:18.951837
1745	poetry slam	poetryslam	4	2014-03-25 15:09:18.955301	2014-03-25 15:09:18.955301
1746	paint	paint	4	2014-03-25 15:09:18.95859	2014-03-25 15:09:18.95859
1747	painting	painting	4	2014-03-25 15:09:18.961971	2014-03-25 15:09:18.961971
1748	sculpt	sculpt	4	2014-03-25 15:09:18.965327	2014-03-25 15:09:18.965327
1749	sculpture	sculpture	4	2014-03-25 15:09:18.968738	2014-03-25 15:09:18.968738
1750	draw	draw	4	2014-03-25 15:09:18.971999	2014-03-25 15:09:18.971999
1751	sculpting	sculpting	4	2014-03-25 15:09:18.97574	2014-03-25 15:09:18.97574
1752	drawing	drawing	4	2014-03-25 15:09:18.978974	2014-03-25 15:09:18.978974
1753	drew	drew	4	2014-03-25 15:09:18.982532	2014-03-25 15:09:18.982532
1754	sculpted	sculpted	4	2014-03-25 15:09:18.985802	2014-03-25 15:09:18.985802
1755	painted	painted	4	2014-03-25 15:09:18.989207	2014-03-25 15:09:18.989207
1756	exhibition	exhibition	4	2014-03-25 15:09:18.992869	2014-03-25 15:09:18.992869
1757	photography	photography	4	2014-03-25 15:09:18.995966	2014-03-25 15:09:18.995966
1758	visual art	visualart	4	2014-03-25 15:09:18.999494	2014-03-25 15:09:18.999494
1759	vis art	visart	4	2014-03-25 15:09:19.003284	2014-03-25 15:09:19.003284
1760	paintbrush	paintbrush	4	2014-03-25 15:09:19.006896	2014-03-25 15:09:19.006896
1761	gesso	gesso	4	2014-03-25 15:09:19.010141	2014-03-25 15:09:19.010141
1762	turpenoid	turpenoid	4	2014-03-25 15:09:19.014016	2014-03-25 15:09:19.014016
1763	paint stains	paintstains	4	2014-03-25 15:09:19.017361	2014-03-25 15:09:19.017361
1764	paint stained	paintstained	4	2014-03-25 15:09:19.020932	2014-03-25 15:09:19.020932
1765	art studio	artstudio	4	2014-03-25 15:09:19.024457	2014-03-25 15:09:19.024457
1766	art show	artshow	4	2014-03-25 15:09:19.028663	2014-03-25 15:09:19.028663
1767	art history	arthistory	4	2014-03-25 15:09:19.033387	2014-03-25 15:09:19.033387
1768	music	music	9	2014-03-25 15:09:19.285397	2014-03-25 15:09:19.285397
1769	band	band	9	2014-03-25 15:09:19.298735	2014-03-25 15:09:19.298735
1770	musician	musician	9	2014-03-25 15:09:19.303441	2014-03-25 15:09:19.303441
1771	rock band	rockband	9	2014-03-25 15:09:19.307271	2014-03-25 15:09:19.307271
1772	music video	musicvideo	9	2014-03-25 15:09:19.310586	2014-03-25 15:09:19.310586
1773	concert	concert	9	2014-03-25 15:09:19.313937	2014-03-25 15:09:19.313937
1774	jazz	jazz	9	2014-03-25 15:09:19.317551	2014-03-25 15:09:19.317551
1775	rock music	rockmusic	9	2014-03-25 15:09:19.320815	2014-03-25 15:09:19.320815
1776	experimental jazz	experimentaljazz	9	2014-03-25 15:09:19.324255	2014-03-25 15:09:19.324255
1777	show tunes	showtunes	9	2014-03-25 15:09:19.327768	2014-03-25 15:09:19.327768
1778	musical theater	musicaltheater	9	2014-03-25 15:09:19.331051	2014-03-25 15:09:19.331051
1779	musical theatre	musicaltheatre	9	2014-03-25 15:09:19.334127	2014-03-25 15:09:19.334127
1780	musical	musical	9	2014-03-25 15:09:19.337691	2014-03-25 15:09:19.337691
1781	free show	freeshow	9	2014-03-25 15:09:19.341358	2014-03-25 15:09:19.341358
1782	sxsw	sxsw	9	2014-03-25 15:09:19.344535	2014-03-25 15:09:19.344535
1783	south by southwest	southbysouthwest	9	2014-03-25 15:09:19.348026	2014-03-25 15:09:19.348026
1784	bonaroo	bonaroo	9	2014-03-25 15:09:19.351277	2014-03-25 15:09:19.351277
1785	bonnaroo	bonnaroo	9	2014-03-25 15:09:19.354473	2014-03-25 15:09:19.354473
1786	song	song	9	2014-03-25 15:09:19.357975	2014-03-25 15:09:19.357975
1787	sing	sing	9	2014-03-25 15:09:19.361117	2014-03-25 15:09:19.361117
1788	singing	singing	9	2014-03-25 15:09:19.364147	2014-03-25 15:09:19.364147
1789	stuck in my head	stuckinmyhead	9	2014-03-25 15:09:19.367388	2014-03-25 15:09:19.367388
1790	auto tune	autotune	9	2014-03-25 15:09:19.370512	2014-03-25 15:09:19.370512
1791	tone deaf	tonedeaf	9	2014-03-25 15:09:19.373569	2014-03-25 15:09:19.373569
1792	singing voice	singingvoice	9	2014-03-25 15:09:19.376778	2014-03-25 15:09:19.376778
1793	singer	singer	9	2014-03-25 15:09:19.37991	2014-03-25 15:09:19.37991
1794	really good singer	reallygoodsinger	9	2014-03-25 15:09:19.383491	2014-03-25 15:09:19.383491
1795	amazing singer	amazingsinger	9	2014-03-25 15:09:19.387759	2014-03-25 15:09:19.387759
1796	amazing voice	amazingvoice	9	2014-03-25 15:09:19.390928	2014-03-25 15:09:19.390928
1797	the voice	thevoice	9	2014-03-25 15:09:19.394169	2014-03-25 15:09:19.394169
1798	broadway	broadway	9	2014-03-25 15:09:19.397427	2014-03-25 15:09:19.397427
1799	music theory	musictheory	9	2014-03-25 15:09:19.40045	2014-03-25 15:09:19.40045
1800	instrument	instrument	9	2014-03-25 15:09:19.403843	2014-03-25 15:09:19.403843
1801	neo-soul	neo-soul	9	2014-03-25 15:09:19.407214	2014-03-25 15:09:19.407214
1802	r and b	randb	9	2014-03-25 15:09:19.41041	2014-03-25 15:09:19.41041
1803	r&b	r&b	9	2014-03-25 15:09:19.414005	2014-03-25 15:09:19.414005
1804	music festival	musicfestival	9	2014-03-25 15:09:19.41762	2014-03-25 15:09:19.41762
1805	amp	amp	9	2014-03-25 15:09:19.420671	2014-03-25 15:09:19.420671
1806	lollapalooza	lollapalooza	9	2014-03-25 15:09:19.424001	2014-03-25 15:09:19.424001
1807	coachella	coachella	9	2014-03-25 15:09:19.427789	2014-03-25 15:09:19.427789
1808	opening band	openingband	9	2014-03-25 15:09:19.431722	2014-03-25 15:09:19.431722
1809	opener	opener	9	2014-03-25 15:09:19.435177	2014-03-25 15:09:19.435177
1810	guitar	guitar	9	2014-03-25 15:09:19.43875	2014-03-25 15:09:19.43875
1811	bass	bass	9	2014-03-25 15:09:19.441944	2014-03-25 15:09:19.441944
1812	electric guitar	electricguitar	9	2014-03-25 15:09:19.445343	2014-03-25 15:09:19.445343
1813	fender	fender	9	2014-03-25 15:09:19.448887	2014-03-25 15:09:19.448887
1814	bpm	bpm	9	2014-03-25 15:09:19.452164	2014-03-25 15:09:19.452164
1815	clef	clef	9	2014-03-25 15:09:19.455348	2014-03-25 15:09:19.455348
1816	treble	treble	9	2014-03-25 15:09:19.459004	2014-03-25 15:09:19.459004
1817	soprano	soprano	9	2014-03-25 15:09:19.462606	2014-03-25 15:09:19.462606
1818	alto	alto	9	2014-03-25 15:09:19.466159	2014-03-25 15:09:19.466159
1819	tenor	tenor	9	2014-03-25 15:09:19.469802	2014-03-25 15:09:19.469802
1820	acapella	acapella	9	2014-03-25 15:09:19.473348	2014-03-25 15:09:19.473348
1821	acapella group	acapellagroup	9	2014-03-25 15:09:19.47636	2014-03-25 15:09:19.47636
1822	drum	drum	9	2014-03-25 15:09:19.479846	2014-03-25 15:09:19.479846
1823	synth	synth	9	2014-03-25 15:09:19.483262	2014-03-25 15:09:19.483262
1824	synthesizer	synthesizer	9	2014-03-25 15:09:19.486632	2014-03-25 15:09:19.486632
1825	violin	violin	9	2014-03-25 15:09:19.490038	2014-03-25 15:09:19.490038
1826	viola	viola	9	2014-03-25 15:09:19.493897	2014-03-25 15:09:19.493897
1827	strings	strings	9	2014-03-25 15:09:19.49751	2014-03-25 15:09:19.49751
1828	trumpet	trumpet	9	2014-03-25 15:09:19.501469	2014-03-25 15:09:19.501469
1829	clarinet	clarinet	9	2014-03-25 15:09:19.505187	2014-03-25 15:09:19.505187
1830	horn	horn	9	2014-03-25 15:09:19.509385	2014-03-25 15:09:19.509385
1831	flute	flute	9	2014-03-25 15:09:19.512848	2014-03-25 15:09:19.512848
1832	drums	drums	9	2014-03-25 15:09:19.516074	2014-03-25 15:09:19.516074
1833	percussion	percussion	9	2014-03-25 15:09:19.519392	2014-03-25 15:09:19.519392
1834	drummer	drummer	9	2014-03-25 15:09:19.522629	2014-03-25 15:09:19.522629
1835	guitarist	guitarist	9	2014-03-25 15:09:19.526226	2014-03-25 15:09:19.526226
1836	bassist	bassist	9	2014-03-25 15:09:19.52957	2014-03-25 15:09:19.52957
1837	keyboard	keyboard	9	2014-03-25 15:09:19.53297	2014-03-25 15:09:19.53297
1838	keytar	keytar	9	2014-03-25 15:09:19.536703	2014-03-25 15:09:19.536703
1839	guitar solo	guitarsolo	9	2014-03-25 15:09:19.539998	2014-03-25 15:09:19.539998
1840	bass solo	basssolo	9	2014-03-25 15:09:19.543512	2014-03-25 15:09:19.543512
1841	drum solo	drumsolo	9	2014-03-25 15:09:19.546925	2014-03-25 15:09:19.546925
1842	my jam	myjam	9	2014-03-25 15:09:19.550181	2014-03-25 15:09:19.550181
1843	piano	piano	9	2014-03-25 15:09:19.553838	2014-03-25 15:09:19.553838
1844	dj	dj	9	2014-03-25 15:09:19.557017	2014-03-25 15:09:19.557017
1845	remix	remix	9	2014-03-25 15:09:19.560523	2014-03-25 15:09:19.560523
1846	disc jockey	discjockey	9	2014-03-25 15:09:19.563822	2014-03-25 15:09:19.563822
1847	give me a beat	givemeabeat	9	2014-03-25 15:09:19.567398	2014-03-25 15:09:19.567398
1848	hip hop	hiphop	9	2014-03-25 15:09:19.571321	2014-03-25 15:09:19.571321
1849	rap	rap	9	2014-03-25 15:09:19.575641	2014-03-25 15:09:19.575641
1850	venue	venue	9	2014-03-25 15:09:19.579612	2014-03-25 15:09:19.579612
1851	hip hop artist	hiphopartist	9	2014-03-25 15:09:19.58302	2014-03-25 15:09:19.58302
1852	rapper	rapper	9	2014-03-25 15:09:19.586845	2014-03-25 15:09:19.586845
1853	rap artist	rapartist	9	2014-03-25 15:09:19.590146	2014-03-25 15:09:19.590146
1854	indie pop	indiepop	9	2014-03-25 15:09:19.594097	2014-03-25 15:09:19.594097
1855	indie rock	indierock	9	2014-03-25 15:09:19.597941	2014-03-25 15:09:19.597941
1856	pitchfork	pitchfork	9	2014-03-25 15:09:19.601373	2014-03-25 15:09:19.601373
1857	techno	techno	9	2014-03-25 15:09:19.64656	2014-03-25 15:09:19.64656
1858	skrillex	skrillex	9	2014-03-25 15:09:19.650466	2014-03-25 15:09:19.650466
1859	dubstep	dubstep	9	2014-03-25 15:09:19.653862	2014-03-25 15:09:19.653862
1860	metal	metal	9	2014-03-25 15:09:19.657052	2014-03-25 15:09:19.657052
1861	black metal	blackmetal	9	2014-03-25 15:09:19.66025	2014-03-25 15:09:19.66025
1862	heavy metal	heavymetal	9	2014-03-25 15:09:19.663833	2014-03-25 15:09:19.663833
1863	death metal	deathmetal	9	2014-03-25 15:09:19.666876	2014-03-25 15:09:19.666876
1864	blues	blues	9	2014-03-25 15:09:19.670492	2014-03-25 15:09:19.670492
1865	blues artist	bluesartist	9	2014-03-25 15:09:19.674636	2014-03-25 15:09:19.674636
1866	metal band	metalband	9	2014-03-25 15:09:19.678207	2014-03-25 15:09:19.678207
1867	death metal band	deathmetalband	9	2014-03-25 15:09:19.682072	2014-03-25 15:09:19.682072
1868	heavy metal band	heavymetalband	9	2014-03-25 15:09:19.685981	2014-03-25 15:09:19.685981
1869	jazz band	jazzband	9	2014-03-25 15:09:19.690803	2014-03-25 15:09:19.690803
1870	jazz standards	jazzstandards	9	2014-03-25 15:09:19.694162	2014-03-25 15:09:19.694162
1871	jazz standard	jazzstandard	9	2014-03-25 15:09:19.698385	2014-03-25 15:09:19.698385
1872	classical music	classicalmusic	9	2014-03-25 15:09:19.701863	2014-03-25 15:09:19.701863
1873	friend	friend	12	2014-03-25 15:09:19.705399	2014-03-25 15:09:19.705399
1874	friends	friends	12	2014-03-25 15:09:19.708753	2014-03-25 15:09:19.708753
1875	best friend	bestfriend	12	2014-03-25 15:09:19.712408	2014-03-25 15:09:19.712408
1876	best friends	bestfriends	12	2014-03-25 15:09:19.716351	2014-03-25 15:09:19.716351
1877	bestie	bestie	12	2014-03-25 15:09:19.72018	2014-03-25 15:09:19.72018
1878	besties	besties	12	2014-03-25 15:09:19.723427	2014-03-25 15:09:19.723427
1879	bff	bff	12	2014-03-25 15:09:19.726641	2014-03-25 15:09:19.726641
1880	bffs	bffs	12	2014-03-25 15:09:19.729915	2014-03-25 15:09:19.729915
1881	girl party	girlparty	12	2014-03-25 15:09:19.733871	2014-03-25 15:09:19.733871
1882	celebration	celebration	12	2014-03-25 15:09:19.737101	2014-03-25 15:09:19.737101
1883	celebrate	celebrate	12	2014-03-25 15:09:19.740858	2014-03-25 15:09:19.740858
1884	slumber party	slumberparty	12	2014-03-25 15:09:19.744091	2014-03-25 15:09:19.744091
1885	campfire	campfire	12	2014-03-25 15:09:19.747678	2014-03-25 15:09:19.747678
1886	camping	camping	12	2014-03-25 15:09:19.75123	2014-03-25 15:09:19.75123
1887	weekend at the cabin	weekendatthecabin	12	2014-03-25 15:09:19.755183	2014-03-25 15:09:19.755183
1888	road trip	roadtrip	12	2014-03-25 15:09:19.758236	2014-03-25 15:09:19.758236
1889	favorite person	favoriteperson	12	2014-03-25 15:09:19.76163	2014-03-25 15:09:19.76163
1890	fav person	favperson	12	2014-03-25 15:09:19.765112	2014-03-25 15:09:19.765112
1891	favorite girl	favoritegirl	12	2014-03-25 15:09:19.768445	2014-03-25 15:09:19.768445
1892	favorite boy	favoriteboy	12	2014-03-25 15:09:19.771951	2014-03-25 15:09:19.771951
1893	weekend up north	weekendupnorth	12	2014-03-25 15:09:19.775668	2014-03-25 15:09:19.775668
1894	cabin weekend	cabinweekend	12	2014-03-25 15:09:19.779213	2014-03-25 15:09:19.779213
1895	camping trip	campingtrip	12	2014-03-25 15:09:19.782683	2014-03-25 15:09:19.782683
1896	go camping	gocamping	12	2014-03-25 15:09:19.785728	2014-03-25 15:09:19.785728
1897	going camping	goingcamping	12	2014-03-25 15:09:19.788999	2014-03-25 15:09:19.788999
1898	sleepover	sleepover	12	2014-03-25 15:09:19.792644	2014-03-25 15:09:19.792644
1899	event	event	12	2014-03-25 15:09:19.796029	2014-03-25 15:09:19.796029
1900	events	events	12	2014-03-25 15:09:19.799115	2014-03-25 15:09:19.799115
1901	fun night	funnight	12	2014-03-25 15:09:19.802622	2014-03-25 15:09:19.802622
1902	good times	goodtimes	12	2014-03-25 15:09:19.806032	2014-03-25 15:09:19.806032
1903	bromance	bromance	12	2014-03-25 15:09:19.809639	2014-03-25 15:09:19.809639
1904	hug	hug	12	2014-03-25 15:09:19.812861	2014-03-25 15:09:19.812861
1905	fraternity	fraternity	12	2014-03-25 15:09:19.816254	2014-03-25 15:09:19.816254
1906	fam	fam	12	2014-03-25 15:09:19.819425	2014-03-25 15:09:19.819425
1907	family	family	12	2014-03-25 15:09:19.822552	2014-03-25 15:09:19.822552
1908	mom	mom	12	2014-03-25 15:09:19.826457	2014-03-25 15:09:19.826457
1909	dad	dad	12	2014-03-25 15:09:19.829674	2014-03-25 15:09:19.829674
1910	mother	mother	12	2014-03-25 15:09:19.833152	2014-03-25 15:09:19.833152
1911	father	father	12	2014-03-25 15:09:19.836535	2014-03-25 15:09:19.836535
1912	sorority	sorority	12	2014-03-25 15:09:19.839909	2014-03-25 15:09:19.839909
1913	sorority sisters	sororitysisters	12	2014-03-25 15:09:19.843764	2014-03-25 15:09:19.843764
1914	frat brothers	fratbrothers	12	2014-03-25 15:09:19.84737	2014-03-25 15:09:19.84737
1915	sorority sister	sororitysister	12	2014-03-25 15:09:19.851003	2014-03-25 15:09:19.851003
1916	happy birthday	happybirthday	12	2014-03-25 15:09:19.8543	2014-03-25 15:09:19.8543
1917	birthday	birthday	12	2014-03-25 15:09:19.857811	2014-03-25 15:09:19.857811
1918	girls night	girlsnight	12	2014-03-25 15:09:19.861013	2014-03-25 15:09:19.861013
1919	ladies night	ladiesnight	12	2014-03-25 15:09:19.864413	2014-03-25 15:09:19.864413
1920	bro out	broout	12	2014-03-25 15:09:19.867954	2014-03-25 15:09:19.867954
1921	with the guys	withtheguys	12	2014-03-25 15:09:19.871189	2014-03-25 15:09:19.871189
1922	man cave	mancave	12	2014-03-25 15:09:19.87461	2014-03-25 15:09:19.87461
1923	cookout	cookout	12	2014-03-25 15:09:19.878182	2014-03-25 15:09:19.878182
1924	grill out	grillout	12	2014-03-25 15:09:19.881452	2014-03-25 15:09:19.881452
1925	grilling out	grillingout	12	2014-03-25 15:09:19.884931	2014-03-25 15:09:19.884931
1926	cooking out	cookingout	12	2014-03-25 15:09:19.888164	2014-03-25 15:09:19.888164
1927	frisbee	frisbee	12	2014-03-25 15:09:19.891893	2014-03-25 15:09:19.891893
1928	coffee shop	coffeeshop	12	2014-03-25 15:09:19.895104	2014-03-25 15:09:19.895104
1929	coffee house	coffeehouse	12	2014-03-25 15:09:19.901307	2014-03-25 15:09:19.901307
1930	go get coffee	gogetcoffee	12	2014-03-25 15:09:19.906171	2014-03-25 15:09:19.906171
1931	hang out	hangout	12	2014-03-25 15:09:19.909866	2014-03-25 15:09:19.909866
1932	hanging out	hangingout	12	2014-03-25 15:09:19.913199	2014-03-25 15:09:19.913199
1933	hung out	hungout	12	2014-03-25 15:09:19.916832	2014-03-25 15:09:19.916832
1934	chill	chill	12	2014-03-25 15:09:19.920131	2014-03-25 15:09:19.920131
1935	chilled	chilled	12	2014-03-25 15:09:19.923669	2014-03-25 15:09:19.923669
1936	chillin'	chillin'	12	2014-03-25 15:09:19.926899	2014-03-25 15:09:19.926899
1937	chillin	chillin	12	2014-03-25 15:09:19.930337	2014-03-25 15:09:19.930337
1938	chilling	chilling	12	2014-03-25 15:09:19.933551	2014-03-25 15:09:19.933551
1939	hangin out	hanginout	12	2014-03-25 15:09:19.937049	2014-03-25 15:09:19.937049
1940	hangin' out	hangin'out	12	2014-03-25 15:09:19.941175	2014-03-25 15:09:19.941175
1941	broing out	broingout	12	2014-03-25 15:09:19.944744	2014-03-25 15:09:19.944744
1942	social	social	12	2014-03-25 15:09:19.949134	2014-03-25 15:09:19.949134
1943	social life	sociallife	12	2014-03-25 15:09:19.952717	2014-03-25 15:09:19.952717
1944	my social life	mysociallife	12	2014-03-25 15:09:19.956314	2014-03-25 15:09:19.956314
1945	bowling	bowling	12	2014-03-25 15:09:19.960111	2014-03-25 15:09:19.960111
1946	roomie	roomie	12	2014-03-25 15:09:19.964121	2014-03-25 15:09:19.964121
1947	roommate	roommate	12	2014-03-25 15:09:19.967254	2014-03-25 15:09:19.967254
1948	my roommate	myroommate	12	2014-03-25 15:09:19.970861	2014-03-25 15:09:19.970861
1949	my roommates	myroommates	12	2014-03-25 15:09:19.974091	2014-03-25 15:09:19.974091
1950	roommates	roommates	12	2014-03-25 15:09:19.977518	2014-03-25 15:09:19.977518
1951	roomies	roomies	12	2014-03-25 15:09:19.980533	2014-03-25 15:09:19.980533
1952	old roommate	oldroommate	12	2014-03-25 15:09:19.984148	2014-03-25 15:09:19.984148
1953	new roommate	newroommate	12	2014-03-25 15:09:19.987272	2014-03-25 15:09:19.987272
1954	old roommates	oldroommates	12	2014-03-25 15:09:19.990814	2014-03-25 15:09:19.990814
1955	new roommates	newroommates	12	2014-03-25 15:09:19.994347	2014-03-25 15:09:19.994347
1956	out with friends	outwithfriends	12	2014-03-25 15:09:19.997624	2014-03-25 15:09:19.997624
1957	with my friends	withmyfriends	12	2014-03-25 15:09:20.001228	2014-03-25 15:09:20.001228
1958	i love you guys	iloveyouguys	12	2014-03-25 15:09:20.00472	2014-03-25 15:09:20.00472
1959	besties forever	bestiesforever	12	2014-03-25 15:09:20.008198	2014-03-25 15:09:20.008198
1960	most amazing friend	mostamazingfriend	12	2014-03-25 15:09:20.012574	2014-03-25 15:09:20.012574
1961	love my friends	lovemyfriends	12	2014-03-25 15:09:20.017445	2014-03-25 15:09:20.017445
1962	awesome friend	awesomefriend	12	2014-03-25 15:09:20.021082	2014-03-25 15:09:20.021082
1963	awesome friends	awesomefriends	12	2014-03-25 15:09:20.025027	2014-03-25 15:09:20.025027
1964	sisters	sisters	12	2014-03-25 15:09:20.028291	2014-03-25 15:09:20.028291
1965	soul sisters	soulsisters	12	2014-03-25 15:09:20.031939	2014-03-25 15:09:20.031939
1966	blood brothers	bloodbrothers	12	2014-03-25 15:09:20.03532	2014-03-25 15:09:20.03532
1967	blood brother	bloodbrother	12	2014-03-25 15:09:20.038571	2014-03-25 15:09:20.038571
1968	soul sister	soulsister	12	2014-03-25 15:09:20.041867	2014-03-25 15:09:20.041867
1969	soul sistas	soulsistas	12	2014-03-25 15:09:20.045335	2014-03-25 15:09:20.045335
1970	soul sista	soulsista	12	2014-03-25 15:09:20.048632	2014-03-25 15:09:20.048632
1971	brother from another mother	brotherfromanothermother	12	2014-03-25 15:09:20.052248	2014-03-25 15:09:20.052248
1972	brotha from another mother	brothafromanothermother	12	2014-03-25 15:09:20.055874	2014-03-25 15:09:20.055874
1973	sister from another mister	sisterfromanothermister	12	2014-03-25 15:09:20.060159	2014-03-25 15:09:20.060159
1974	sista from another mista	sistafromanothermista	12	2014-03-25 15:09:20.063531	2014-03-25 15:09:20.063531
1975	brotha	brotha	12	2014-03-25 15:09:20.066971	2014-03-25 15:09:20.066971
1976	sista	sista	12	2014-03-25 15:09:20.070284	2014-03-25 15:09:20.070284
1977	sistas	sistas	12	2014-03-25 15:09:20.074951	2014-03-25 15:09:20.074951
1978	brothas	brothas	12	2014-03-25 15:09:20.078475	2014-03-25 15:09:20.078475
1979	brothers	brothers	12	2014-03-25 15:09:20.082099	2014-03-25 15:09:20.082099
1980	brother	brother	12	2014-03-25 15:09:20.085427	2014-03-25 15:09:20.085427
1981	the bros	thebros	12	2014-03-25 15:09:20.088584	2014-03-25 15:09:20.088584
1982	my bros	mybros	12	2014-03-25 15:09:20.09276	2014-03-25 15:09:20.09276
1983	bros	bros	12	2014-03-25 15:09:20.096239	2014-03-25 15:09:20.096239
1984	best bros	bestbros	12	2014-03-25 15:09:20.099582	2014-03-25 15:09:20.099582
1985	my guy friends	myguyfriends	12	2014-03-25 15:09:20.103318	2014-03-25 15:09:20.103318
1986	my girl friends	mygirlfriends	12	2014-03-25 15:09:20.106692	2014-03-25 15:09:20.106692
1987	trivia night	trivianight	12	2014-03-25 15:09:20.110306	2014-03-25 15:09:20.110306
1988	neighbor	neighbor	12	2014-03-25 15:09:20.11383	2014-03-25 15:09:20.11383
1989	neighbors	neighbors	12	2014-03-25 15:09:20.11701	2014-03-25 15:09:20.11701
1990	best buds	bestbuds	12	2014-03-25 15:09:20.121263	2014-03-25 15:09:20.121263
1991	buddy	buddy	12	2014-03-25 15:09:20.125862	2014-03-25 15:09:20.125862
1992	buddies	buddies	12	2014-03-25 15:09:20.129789	2014-03-25 15:09:20.129789
1993	friends from home	friendsfromhome	12	2014-03-25 15:09:20.133513	2014-03-25 15:09:20.133513
1994	friends from school	friendsfromschool	12	2014-03-25 15:09:20.137033	2014-03-25 15:09:20.137033
1995	fun	fun	12	2014-03-25 15:09:20.140407	2014-03-25 15:09:20.140407
1996	best day	bestday	12	2014-03-25 15:09:20.143961	2014-03-25 15:09:20.143961
1997	fun day	funday	12	2014-03-25 15:09:20.148577	2014-03-25 15:09:20.148577
1998	outing	outing	12	2014-03-25 15:09:20.181516	2014-03-25 15:09:20.181516
1999	trip	trip	12	2014-03-25 15:09:20.186575	2014-03-25 15:09:20.186575
2000	vacation	vacation	12	2014-03-25 15:09:20.190702	2014-03-25 15:09:20.190702
2001	day trip	daytrip	12	2014-03-25 15:09:20.195085	2014-03-25 15:09:20.195085
2002	sports	sports	5	2014-03-25 15:09:20.199435	2014-03-25 15:09:20.199435
2003	championship	championship	5	2014-03-25 15:09:20.20412	2014-03-25 15:09:20.20412
2004	championship title	championshiptitle	5	2014-03-25 15:09:20.208821	2014-03-25 15:09:20.208821
2005	bases loaded	basesloaded	5	2014-03-25 15:09:20.213383	2014-03-25 15:09:20.213383
2006	50 yard line	50yardline	5	2014-03-25 15:09:20.217514	2014-03-25 15:09:20.217514
2007	jock strap	jockstrap	5	2014-03-25 15:09:20.22173	2014-03-25 15:09:20.22173
2008	cleats	cleats	5	2014-03-25 15:09:20.226005	2014-03-25 15:09:20.226005
2009	soccer ball	soccerball	5	2014-03-25 15:09:20.230356	2014-03-25 15:09:20.230356
2010	golf	golf	5	2014-03-25 15:09:20.23467	2014-03-25 15:09:20.23467
2011	golfer	golfer	5	2014-03-25 15:09:20.239151	2014-03-25 15:09:20.239151
2012	tennis	tennis	5	2014-03-25 15:09:20.243459	2014-03-25 15:09:20.243459
2013	tennis ball	tennisball	5	2014-03-25 15:09:20.247929	2014-03-25 15:09:20.247929
2014	tennis court	tenniscourt	5	2014-03-25 15:09:20.252242	2014-03-25 15:09:20.252242
2015	grand slam	grandslam	5	2014-03-25 15:09:20.256473	2014-03-25 15:09:20.256473
2016	slam dunk	slamdunk	5	2014-03-25 15:09:20.260771	2014-03-25 15:09:20.260771
2017	quarterback	quarterback	5	2014-03-25 15:09:20.264714	2014-03-25 15:09:20.264714
2018	lineman	lineman	5	2014-03-25 15:09:20.268308	2014-03-25 15:09:20.268308
2019	offensive lineman	offensivelineman	5	2014-03-25 15:09:20.272266	2014-03-25 15:09:20.272266
2020	defensive lineman	defensivelineman	5	2014-03-25 15:09:20.276527	2014-03-25 15:09:20.276527
2021	offense	offense	5	2014-03-25 15:09:20.280733	2014-03-25 15:09:20.280733
2022	defense	defense	5	2014-03-25 15:09:20.285203	2014-03-25 15:09:20.285203
2023	penalty	penalty	5	2014-03-25 15:09:20.331027	2014-03-25 15:09:20.331027
2024	penalty shot	penaltyshot	5	2014-03-25 15:09:20.334691	2014-03-25 15:09:20.334691
2025	goalie	goalie	5	2014-03-25 15:09:20.33805	2014-03-25 15:09:20.33805
2026	juke	juke	5	2014-03-25 15:09:20.341152	2014-03-25 15:09:20.341152
2027	field goal	fieldgoal	5	2014-03-25 15:09:20.344615	2014-03-25 15:09:20.344615
2028	3 pointer	3pointer	5	2014-03-25 15:09:20.348139	2014-03-25 15:09:20.348139
2029	2 pointer	2pointer	5	2014-03-25 15:09:20.351593	2014-03-25 15:09:20.351593
2030	three pointer	threepointer	5	2014-03-25 15:09:20.354933	2014-03-25 15:09:20.354933
2031	two pointer	twopointer	5	2014-03-25 15:09:20.358584	2014-03-25 15:09:20.358584
2032	free throw	freethrow	5	2014-03-25 15:09:20.362483	2014-03-25 15:09:20.362483
2033	punt	punt	5	2014-03-25 15:09:20.366047	2014-03-25 15:09:20.366047
2034	bracket	bracket	5	2014-03-25 15:09:20.36911	2014-03-25 15:09:20.36911
2035	march madness	marchmadness	5	2014-03-25 15:09:20.372612	2014-03-25 15:09:20.372612
2036	basketball	basketball	5	2014-03-25 15:09:20.375768	2014-03-25 15:09:20.375768
2037	football	football	5	2014-03-25 15:09:20.378977	2014-03-25 15:09:20.378977
2038	nfl	nfl	5	2014-03-25 15:09:20.38199	2014-03-25 15:09:20.38199
2039	nba	nba	5	2014-03-25 15:09:20.385757	2014-03-25 15:09:20.385757
2040	wba	wba	5	2014-03-25 15:09:20.38909	2014-03-25 15:09:20.38909
2041	hockey	hockey	5	2014-03-25 15:09:20.392338	2014-03-25 15:09:20.392338
2042	aaron rodgers	aaronrodgers	5	2014-03-25 15:09:20.396125	2014-03-25 15:09:20.396125
2043	brett favre	brettfavre	5	2014-03-25 15:09:20.400028	2014-03-25 15:09:20.400028
2044	fantasy football	fantasyfootball	5	2014-03-25 15:09:20.403135	2014-03-25 15:09:20.403135
2045	fantasy football league	fantasyfootballleague	5	2014-03-25 15:09:20.40673	2014-03-25 15:09:20.40673
2046	football league	footballleague	5	2014-03-25 15:09:20.410171	2014-03-25 15:09:20.410171
2047	football game	footballgame	5	2014-03-25 15:09:20.413728	2014-03-25 15:09:20.413728
2048	basketball game	basketballgame	5	2014-03-25 15:09:20.417396	2014-03-25 15:09:20.417396
2049	baseball	baseball	5	2014-03-25 15:09:20.420476	2014-03-25 15:09:20.420476
2050	baseball game	baseballgame	5	2014-03-25 15:09:20.424101	2014-03-25 15:09:20.424101
2051	touchdown	touchdown	5	2014-03-25 15:09:20.42784	2014-03-25 15:09:20.42784
2052	foul	foul	5	2014-03-25 15:09:20.4311	2014-03-25 15:09:20.4311
2053	referee	referee	5	2014-03-25 15:09:20.434492	2014-03-25 15:09:20.434492
2054	ref	ref	5	2014-03-25 15:09:20.437665	2014-03-25 15:09:20.437665
2055	superbowl	superbowl	5	2014-03-25 15:09:20.440915	2014-03-25 15:09:20.440915
2056	playoffs	playoffs	5	2014-03-25 15:09:20.444049	2014-03-25 15:09:20.444049
2057	championship playoffs	championshipplayoffs	5	2014-03-25 15:09:20.44784	2014-03-25 15:09:20.44784
2058	rose bowl	rosebowl	5	2014-03-25 15:09:20.450969	2014-03-25 15:09:20.450969
2059	espn	espn	5	2014-03-25 15:09:20.454147	2014-03-25 15:09:20.454147
2060	sport	sport	5	2014-03-25 15:09:20.458227	2014-03-25 15:09:20.458227
2061	sports team	sportsteam	5	2014-03-25 15:09:20.461958	2014-03-25 15:09:20.461958
2062	football team	footballteam	5	2014-03-25 15:09:20.46539	2014-03-25 15:09:20.46539
2063	basketball team	basketballteam	5	2014-03-25 15:09:20.468935	2014-03-25 15:09:20.468935
2064	baseball team	baseballteam	5	2014-03-25 15:09:20.472292	2014-03-25 15:09:20.472292
2065	hockey team	hockeyteam	5	2014-03-25 15:09:20.475862	2014-03-25 15:09:20.475862
2066	hockey game	hockeygame	5	2014-03-25 15:09:20.479341	2014-03-25 15:09:20.479341
2067	stanley cup	stanleycup	5	2014-03-25 15:09:20.48252	2014-03-25 15:09:20.48252
2068	halftime	halftime	5	2014-03-25 15:09:20.485966	2014-03-25 15:09:20.485966
2069	half time	halftime	5	2014-03-25 15:09:20.489828	2014-03-25 15:09:20.489828
2070	cheerleader	cheerleader	5	2014-03-25 15:09:20.493544	2014-03-25 15:09:20.493544
2071	cheerleaders	cheerleaders	5	2014-03-25 15:09:20.496623	2014-03-25 15:09:20.496623
2072	inning	inning	5	2014-03-25 15:09:20.499864	2014-03-25 15:09:20.499864
2073	ninth inning	ninthinning	5	2014-03-25 15:09:20.50335	2014-03-25 15:09:20.50335
2074	9th inning	9thinning	5	2014-03-25 15:09:20.506842	2014-03-25 15:09:20.506842
2075	bottom of the ninth	bottomoftheninth	5	2014-03-25 15:09:20.510116	2014-03-25 15:09:20.510116
2076	wimbledon	wimbledon	5	2014-03-25 15:09:20.515135	2014-03-25 15:09:20.515135
2077	rowing	rowing	5	2014-03-25 15:09:20.518527	2014-03-25 15:09:20.518527
2078	lacrosse	lacrosse	5	2014-03-25 15:09:20.52204	2014-03-25 15:09:20.52204
2079	rugby	rugby	5	2014-03-25 15:09:20.525355	2014-03-25 15:09:20.525355
2080	baseball bat	baseballbat	5	2014-03-25 15:09:20.528897	2014-03-25 15:09:20.528897
2081	chicago bears	chicagobears	5	2014-03-25 15:09:20.53233	2014-03-25 15:09:20.53233
2082	packers	packers	5	2014-03-25 15:09:20.535798	2014-03-25 15:09:20.535798
2083	green bay	greenbay	5	2014-03-25 15:09:20.539301	2014-03-25 15:09:20.539301
2084	green bay packers	greenbaypackers	5	2014-03-25 15:09:20.543615	2014-03-25 15:09:20.543615
2085	longhorn	longhorn	5	2014-03-25 15:09:20.547351	2014-03-25 15:09:20.547351
2086	da bears	dabears	5	2014-03-25 15:09:20.550524	2014-03-25 15:09:20.550524
2087	cubs	cubs	5	2014-03-25 15:09:20.553724	2014-03-25 15:09:20.553724
2088	chicago cubs	chicagocubs	5	2014-03-25 15:09:20.557126	2014-03-25 15:09:20.557126
2089	white sox	whitesox	5	2014-03-25 15:09:20.560327	2014-03-25 15:09:20.560327
2090	red sox	redsox	5	2014-03-25 15:09:20.563823	2014-03-25 15:09:20.563823
2091	sox	sox	5	2014-03-25 15:09:20.5671	2014-03-25 15:09:20.5671
2092	ball game	ballgame	5	2014-03-25 15:09:20.570925	2014-03-25 15:09:20.570925
2093	forty niners	fortyniners	5	2014-03-25 15:09:20.575164	2014-03-25 15:09:20.575164
2094	forty-niners	forty-niners	5	2014-03-25 15:09:20.579017	2014-03-25 15:09:20.579017
2095	giants	giants	5	2014-03-25 15:09:20.582412	2014-03-25 15:09:20.582412
2096	new york giants	newyorkgiants	5	2014-03-25 15:09:20.586062	2014-03-25 15:09:20.586062
2097	dallas cowboys	dallascowboys	5	2014-03-25 15:09:20.589464	2014-03-25 15:09:20.589464
2098	houston texans	houstontexans	5	2014-03-25 15:09:20.593094	2014-03-25 15:09:20.593094
2099	texas rangers	texasrangers	5	2014-03-25 15:09:20.596958	2014-03-25 15:09:20.596958
2100	rangers	rangers	5	2014-03-25 15:09:20.600797	2014-03-25 15:09:20.600797
2101	houston astros	houstonastros	5	2014-03-25 15:09:20.604703	2014-03-25 15:09:20.604703
2102	dallas stars	dallasstars	5	2014-03-25 15:09:20.60791	2014-03-25 15:09:20.60791
2103	houston dynamo	houstondynamo	5	2014-03-25 15:09:20.611413	2014-03-25 15:09:20.611413
2104	houston rockets	houstonrockets	5	2014-03-25 15:09:20.614938	2014-03-25 15:09:20.614938
2105	longhorns	longhorns	5	2014-03-25 15:09:20.618589	2014-03-25 15:09:20.618589
2106	aggies	aggies	5	2014-03-25 15:09:20.621883	2014-03-25 15:09:20.621883
2107	wolverines	wolverines	5	2014-03-25 15:09:20.626715	2014-03-25 15:09:20.626715
2108	spartans	spartans	5	2014-03-25 15:09:20.630543	2014-03-25 15:09:20.630543
2109	detroit tigers	detroittigers	5	2014-03-25 15:09:20.634425	2014-03-25 15:09:20.634425
2110	detroit lions	detroitlions	5	2014-03-25 15:09:20.638435	2014-03-25 15:09:20.638435
2111	detroit redwings	detroitredwings	5	2014-03-25 15:09:20.642247	2014-03-25 15:09:20.642247
2112	lions	lions	5	2014-03-25 15:09:20.646355	2014-03-25 15:09:20.646355
2113	tigers	tigers	5	2014-03-25 15:09:20.649868	2014-03-25 15:09:20.649868
2114	redwings	redwings	5	2014-03-25 15:09:20.653369	2014-03-25 15:09:20.653369
2115	pistons	pistons	5	2014-03-25 15:09:20.657044	2014-03-25 15:09:20.657044
2116	sun devils	sundevils	5	2014-03-25 15:09:20.660127	2014-03-25 15:09:20.660127
2117	sundevils	sundevils	5	2014-03-25 15:09:20.663474	2014-03-25 15:09:20.663474
2118	cardinals	cardinals	5	2014-03-25 15:09:20.666709	2014-03-25 15:09:20.666709
2119	mascot	mascot	5	2014-03-25 15:09:20.670231	2014-03-25 15:09:20.670231
2120	phoenix suns	phoenixsuns	5	2014-03-25 15:09:20.673721	2014-03-25 15:09:20.673721
2121	world series	worldseries	5	2014-03-25 15:09:20.677541	2014-03-25 15:09:20.677541
2122	soccer	soccer	5	2014-03-25 15:09:20.681287	2014-03-25 15:09:20.681287
2123	futbol	futbol	5	2014-03-25 15:09:20.684781	2014-03-25 15:09:20.684781
2124	world cup	worldcup	5	2014-03-25 15:09:20.68803	2014-03-25 15:09:20.68803
2125	sugar bowl	sugarbowl	5	2014-03-25 15:09:20.69177	2014-03-25 15:09:20.69177
2126	orange bowl	orangebowl	5	2014-03-25 15:09:20.69529	2014-03-25 15:09:20.69529
2127	championship playoff game	championshipplayoffgame	5	2014-03-25 15:09:20.698841	2014-03-25 15:09:20.698841
2128	playoff game	playoffgame	5	2014-03-25 15:09:20.702095	2014-03-25 15:09:20.702095
2129	division series	divisionseries	5	2014-03-25 15:09:20.705504	2014-03-25 15:09:20.705504
2130	championship series	championshipseries	5	2014-03-25 15:09:20.709336	2014-03-25 15:09:20.709336
2131	college basketball	collegebasketball	5	2014-03-25 15:09:20.712692	2014-03-25 15:09:20.712692
2132	college football	collegefootball	5	2014-03-25 15:09:20.716174	2014-03-25 15:09:20.716174
2133	nba finals	nbafinals	5	2014-03-25 15:09:20.719326	2014-03-25 15:09:20.719326
2134	nhl	nhl	5	2014-03-25 15:09:20.722731	2014-03-25 15:09:20.722731
2135	mls	mls	5	2014-03-25 15:09:20.726013	2014-03-25 15:09:20.726013
2136	mlb	mlb	5	2014-03-25 15:09:20.729525	2014-03-25 15:09:20.729525
2137	frozen four	frozenfour	5	2014-03-25 15:09:20.732809	2014-03-25 15:09:20.732809
2138	sports news	sportsnews	5	2014-03-25 15:09:20.736424	2014-03-25 15:09:20.736424
2139	lebron james	lebronjames	5	2014-03-25 15:09:20.739769	2014-03-25 15:09:20.739769
2140	michael jordan	michaeljordan	5	2014-03-25 15:09:20.743039	2014-03-25 15:09:20.743039
2141	james harden	jamesharden	5	2014-03-25 15:09:20.746481	2014-03-25 15:09:20.746481
2142	the beard	thebeard	5	2014-03-25 15:09:20.749909	2014-03-25 15:09:20.749909
2143	kevin durant	kevindurant	5	2014-03-25 15:09:20.75328	2014-03-25 15:09:20.75328
2144	chicago bulls	chicagobulls	5	2014-03-25 15:09:20.756992	2014-03-25 15:09:20.756992
2145	bulls	bulls	5	2014-03-25 15:09:20.760694	2014-03-25 15:09:20.760694
2146	anthony davis	anthonydavis	5	2014-03-25 15:09:20.764583	2014-03-25 15:09:20.764583
2147	puck	puck	5	2014-03-25 15:09:20.768267	2014-03-25 15:09:20.768267
2148	andrew wiggins	andrewwiggins	5	2014-03-25 15:09:20.771669	2014-03-25 15:09:20.771669
\.


--
-- Name: reference_words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('reference_words_id_seq', 2148, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY schema_migrations (version) FROM stdin;
20140320182508
20140320183710
20140320183811
20140320183929
20140320184415
20140320184518
20140320184634
20140320221446
\.


--
-- Data for Name: school_word_counts; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY school_word_counts (id, school_id, reference_word_id, word_count, positive_word_count, negative_word_count, neutral_word_count, mixed_word_count, created_at, updated_at) FROM stdin;
89	1	1377	15	11	4	0	0	2014-03-25 15:17:37.553728	2014-03-25 15:18:22.984314
83	1	1662	10	10	0	0	0	2014-03-25 15:17:37.490241	2014-03-25 15:18:22.808964
6	1	1244	1	0	1	0	0	2014-03-25 15:17:36.518462	2014-03-25 15:17:36.51985
7	1	623	1	0	1	0	0	2014-03-25 15:17:36.524418	2014-03-25 15:17:36.526434
75	1	336	10	7	3	0	0	2014-03-25 15:17:37.253066	2014-03-25 15:18:22.234808
10	1	616	1	0	1	0	0	2014-03-25 15:17:36.548747	2014-03-25 15:17:36.550305
48	1	262	13	13	0	0	0	2014-03-25 15:17:36.919862	2014-03-25 15:17:44.169728
19	1	1282	3	2	1	0	0	2014-03-25 15:17:36.646445	2014-03-25 15:17:44.260719
64	1	1718	3	3	0	0	0	2014-03-25 15:17:37.143006	2014-03-25 15:17:49.016704
67	1	641	3	3	0	0	0	2014-03-25 15:17:37.173461	2014-03-25 15:18:23.071511
76	1	1964	8	8	0	0	0	2014-03-25 15:17:37.278257	2014-03-25 15:18:23.156553
70	1	1346	2	2	0	0	0	2014-03-25 15:17:37.205505	2014-03-25 15:17:49.482494
25	1	1538	32	32	0	0	0	2014-03-25 15:17:36.704646	2014-03-25 15:17:52.27555
4	1	1383	37	37	0	0	0	2014-03-25 15:17:36.505965	2014-03-25 15:18:22.333231
18	1	1146	1	1	0	0	0	2014-03-25 15:17:36.623934	2014-03-25 15:17:36.625543
63	1	1460	10	9	1	0	0	2014-03-25 15:17:37.128849	2014-03-25 15:17:52.086053
16	1	539	11	5	6	0	0	2014-03-25 15:17:36.610336	2014-03-25 15:18:22.671452
66	1	1092	33	31	1	1	0	2014-03-25 15:17:37.166728	2014-03-25 15:17:53.286819
32	1	516	24	24	0	0	0	2014-03-25 15:17:36.771511	2014-03-25 15:17:49.930183
17	1	1473	2	1	1	0	0	2014-03-25 15:17:36.617272	2014-03-25 15:17:38.83708
29	1	870	31	30	1	0	0	2014-03-25 15:17:36.745083	2014-03-25 15:18:22.457276
14	1	1934	6	5	1	0	0	2014-03-25 15:17:36.587201	2014-03-25 15:18:22.409047
73	1	1536	8	8	0	0	0	2014-03-25 15:17:37.239838	2014-03-25 15:17:53.221909
61	1	1757	4	4	0	0	0	2014-03-25 15:17:37.115349	2014-03-25 15:17:52.072244
96	1	473	3	3	0	0	0	2014-03-25 15:17:37.930476	2014-03-25 15:17:52.100265
65	1	1048	19	6	13	0	0	2014-03-25 15:17:37.160885	2014-03-25 15:17:53.301109
33	1	544	26	24	2	0	0	2014-03-25 15:17:36.777216	2014-03-25 15:17:49.936953
71	1	1907	11	8	3	0	0	2014-03-25 15:17:37.222835	2014-03-25 15:18:22.666459
11	1	991	11	1	10	0	0	2014-03-25 15:17:36.556498	2014-03-25 15:18:21.575968
15	1	1564	30	30	0	0	0	2014-03-25 15:17:36.596737	2014-03-25 15:17:52.56163
56	1	1702	19	19	0	0	0	2014-03-25 15:17:37.054858	2014-03-25 15:18:21.980682
91	1	502	24	13	11	0	0	2014-03-25 15:17:37.601456	2014-03-25 15:18:22.882772
59	1	1541	2	0	2	0	0	2014-03-25 15:17:37.088817	2014-03-25 15:17:52.047478
94	1	1625	3	2	1	0	0	2014-03-25 15:17:37.889949	2014-03-25 15:17:50.9846
5	1	1385	25	23	2	0	0	2014-03-25 15:17:36.512662	2014-03-25 15:17:53.066187
30	1	873	28	28	0	0	0	2014-03-25 15:17:36.754009	2014-03-25 15:17:51.329545
50	1	1521	5	5	0	0	0	2014-03-25 15:17:36.989219	2014-03-25 15:18:22.740584
81	1	2035	5	5	0	0	0	2014-03-25 15:17:37.464807	2014-03-25 15:17:51.352664
28	1	614	29	0	29	0	0	2014-03-25 15:17:36.739233	2014-03-25 15:17:52.09177
43	1	780	22	0	22	0	0	2014-03-25 15:17:36.868315	2014-03-25 15:17:49.004069
31	1	1	26	26	0	0	0	2014-03-25 15:17:36.761808	2014-03-25 15:17:50.865301
34	1	556	25	25	0	0	0	2014-03-25 15:17:36.784919	2014-03-25 15:17:49.943458
77	1	1505	1	1	0	0	0	2014-03-25 15:17:37.286913	2014-03-25 15:17:37.288384
38	1	613	28	1	27	0	0	2014-03-25 15:17:36.819718	2014-03-25 15:18:22.428689
90	1	1156	7	3	4	0	0	2014-03-25 15:17:37.58938	2014-03-25 15:18:22.995994
51	1	1450	1	1	0	0	0	2014-03-25 15:17:36.996727	2014-03-25 15:17:36.998117
21	1	1947	6	2	4	0	0	2014-03-25 15:17:36.662784	2014-03-25 15:17:49.132832
37	1	548	49	0	49	0	0	2014-03-25 15:17:36.811089	2014-03-25 15:18:22.901226
36	1	410	24	1	23	0	0	2014-03-25 15:17:36.803925	2014-03-25 15:17:49.682511
84	1	950	3	3	0	0	0	2014-03-25 15:17:37.496922	2014-03-25 15:17:46.626934
55	1	564	1	1	0	0	0	2014-03-25 15:17:37.046452	2014-03-25 15:17:37.04802
40	1	1270	22	22	0	0	0	2014-03-25 15:17:36.838621	2014-03-25 15:17:48.906618
22	1	376	36	34	2	0	0	2014-03-25 15:17:36.675304	2014-03-25 15:17:53.012573
93	1	1384	12	12	0	0	0	2014-03-25 15:17:37.844403	2014-03-25 15:17:52.657278
12	1	831	98	94	4	0	0	2014-03-25 15:17:36.568867	2014-03-25 15:18:23.148951
58	1	1768	11	7	4	0	0	2014-03-25 15:17:37.082987	2014-03-25 15:18:21.943609
60	1	634	2	2	0	0	0	2014-03-25 15:17:37.101024	2014-03-25 15:17:52.057398
85	1	555	9	6	3	0	0	2014-03-25 15:17:37.512364	2014-03-25 15:18:22.778247
42	1	730	42	6	36	0	0	2014-03-25 15:17:36.859312	2014-03-25 15:18:23.094887
82	1	1875	23	20	3	0	0	2014-03-25 15:17:37.471356	2014-03-25 15:18:23.044619
54	1	1773	4	3	1	0	0	2014-03-25 15:17:37.037257	2014-03-25 15:17:45.635861
45	1	1200	29	29	0	0	0	2014-03-25 15:17:36.886778	2014-03-25 15:18:23.110807
101	1	1021	5	5	0	0	0	2014-03-25 15:17:38.007324	2014-03-25 15:18:23.019944
1	1	1144	2	2	0	0	0	2014-03-25 15:17:36.482661	2014-03-25 15:17:44.656418
9	1	432	19	15	4	0	0	2014-03-25 15:17:36.54177	2014-03-25 15:18:22.853807
49	1	729	20	16	3	0	1	2014-03-25 15:17:36.92841	2014-03-25 15:18:22.88842
3	1	1805	25	18	7	0	0	2014-03-25 15:17:36.499041	2014-03-25 15:18:22.434287
80	1	1186	2	0	2	0	0	2014-03-25 15:17:37.452843	2014-03-25 15:18:21.913616
78	1	1475	1	1	0	0	0	2014-03-25 15:17:37.292251	2014-03-25 15:17:37.437542
98	1	1908	17	11	6	0	0	2014-03-25 15:17:37.962643	2014-03-25 15:18:21.844509
2	1	1995	34	30	4	0	0	2014-03-25 15:17:36.492411	2014-03-25 15:18:23.163736
46	1	635	17	0	17	0	0	2014-03-25 15:17:36.893406	2014-03-25 15:17:46.175074
20	1	261	6	5	1	0	0	2014-03-25 15:17:36.654998	2014-03-25 15:17:52.396552
87	1	1188	2	2	0	0	0	2014-03-25 15:17:37.534774	2014-03-25 15:17:40.128784
62	1	966	13	10	3	0	0	2014-03-25 15:17:37.121736	2014-03-25 15:17:53.273902
47	1	413	19	18	1	0	0	2014-03-25 15:17:36.908017	2014-03-25 15:17:52.937622
86	1	236	1	0	1	0	0	2014-03-25 15:17:37.524668	2014-03-25 15:17:37.526102
88	1	1489	1	1	0	0	0	2014-03-25 15:17:37.543139	2014-03-25 15:17:37.54487
35	1	501	72	36	36	0	0	2014-03-25 15:17:36.792988	2014-03-25 15:18:22.968106
57	1	1989	2	1	1	0	0	2014-03-25 15:17:37.061201	2014-03-25 15:17:48.025014
39	1	1311	22	22	0	0	0	2014-03-25 15:17:36.833221	2014-03-25 15:17:48.902565
79	1	1650	3	3	0	0	0	2014-03-25 15:17:37.444375	2014-03-25 15:17:43.584569
13	1	1874	66	61	5	0	0	2014-03-25 15:17:36.577385	2014-03-25 15:18:23.123497
41	1	1189	32	31	1	0	0	2014-03-25 15:17:36.845716	2014-03-25 15:18:22.875006
92	1	1746	1	1	0	0	0	2014-03-25 15:17:37.64208	2014-03-25 15:17:37.643454
74	1	337	14	12	2	0	0	2014-03-25 15:17:37.24773	2014-03-25 15:18:22.097494
69	1	840	13	13	0	0	0	2014-03-25 15:17:37.19732	2014-03-25 15:18:22.868125
68	1	853	7	7	0	0	0	2014-03-25 15:17:37.190561	2014-03-25 15:17:51.523106
95	1	43	1	0	1	0	0	2014-03-25 15:17:37.916217	2014-03-25 15:17:37.918687
52	1	145	2	2	0	0	0	2014-03-25 15:17:37.017079	2014-03-25 15:17:48.574967
72	1	793	6	5	1	0	0	2014-03-25 15:17:37.228976	2014-03-25 15:17:51.036712
97	1	498	1	1	0	0	0	2014-03-25 15:17:37.944369	2014-03-25 15:17:37.945998
53	1	1937	2	2	0	0	0	2014-03-25 15:17:37.028487	2014-03-25 15:17:47.309601
27	1	842	32	32	0	0	0	2014-03-25 15:17:36.733879	2014-03-25 15:17:52.036812
100	1	855	7	7	0	0	0	2014-03-25 15:17:37.99632	2014-03-25 15:17:50.999175
99	1	1514	1	1	0	0	0	2014-03-25 15:17:37.989377	2014-03-25 15:17:37.990905
8	1	2034	10	2	8	0	0	2014-03-25 15:17:36.533158	2014-03-25 15:17:52.105686
26	1	1911	33	1	32	0	0	2014-03-25 15:17:36.712293	2014-03-25 15:17:52.60246
44	1	373	89	31	58	0	0	2014-03-25 15:17:36.878316	2014-03-25 15:18:23.003903
24	1	1529	33	32	1	0	0	2014-03-25 15:17:36.695539	2014-03-25 15:18:22.727327
23	1	845	36	36	0	0	0	2014-03-25 15:17:36.683413	2014-03-25 15:17:52.983678
152	1	907	4	0	4	0	0	2014-03-25 15:17:40.120905	2014-03-25 15:17:42.205788
184	1	1151	4	4	0	0	0	2014-03-25 15:17:41.095065	2014-03-25 15:18:22.23021
105	1	823	1	0	1	0	0	2014-03-25 15:17:38.312906	2014-03-25 15:17:38.314571
192	1	1437	7	5	2	0	0	2014-03-25 15:17:41.347381	2014-03-25 15:18:22.442935
131	1	844	2	2	0	0	0	2014-03-25 15:17:39.030141	2014-03-25 15:17:47.756172
146	1	250	1	1	0	0	0	2014-03-25 15:17:39.879332	2014-03-25 15:17:39.881748
126	1	1997	2	2	0	0	0	2014-03-25 15:17:38.949381	2014-03-25 15:17:39.895623
110	1	627	1	0	1	0	0	2014-03-25 15:17:38.570199	2014-03-25 15:17:38.572485
129	1	1152	11	8	3	0	0	2014-03-25 15:17:39.011115	2014-03-25 15:17:53.250513
112	1	606	1	0	1	0	0	2014-03-25 15:17:38.606671	2014-03-25 15:17:38.609013
150	1	1211	4	4	0	0	0	2014-03-25 15:17:40.018091	2014-03-25 15:17:47.055333
114	1	1537	1	0	1	0	0	2014-03-25 15:17:38.623751	2014-03-25 15:17:38.625254
115	1	1471	1	1	0	0	0	2014-03-25 15:17:38.630024	2014-03-25 15:17:38.631452
117	1	892	1	0	1	0	0	2014-03-25 15:17:38.822573	2014-03-25 15:17:38.824304
161	1	377	4	4	0	0	0	2014-03-25 15:17:40.469468	2014-03-25 15:18:22.686364
138	1	1465	4	3	1	0	0	2014-03-25 15:17:39.321036	2014-03-25 15:18:22.450193
167	1	878	1	1	0	0	0	2014-03-25 15:17:40.72345	2014-03-25 15:17:40.72515
194	1	1446	2	2	0	0	0	2014-03-25 15:17:41.359702	2014-03-25 15:17:43.502932
134	1	1376	2	2	0	0	0	2014-03-25 15:17:39.063706	2014-03-25 15:18:21.676052
102	1	732	10	8	2	0	0	2014-03-25 15:17:38.021752	2014-03-25 15:18:23.064883
123	1	3	1	1	0	0	0	2014-03-25 15:17:38.904834	2014-03-25 15:17:38.907039
125	1	1555	1	1	0	0	0	2014-03-25 15:17:38.940146	2014-03-25 15:17:38.941995
127	1	1680	1	1	0	0	0	2014-03-25 15:17:38.962253	2014-03-25 15:17:38.963902
172	1	1418	2	2	0	0	0	2014-03-25 15:17:40.798718	2014-03-25 15:17:52.308252
168	1	1876	17	17	0	0	0	2014-03-25 15:17:40.738484	2014-03-25 15:18:23.212008
177	1	1577	3	3	0	0	0	2014-03-25 15:17:40.904499	2014-03-25 15:17:51.951172
176	1	1203	4	4	0	0	0	2014-03-25 15:17:40.87948	2014-03-25 15:17:51.931127
178	1	1918	3	3	0	0	0	2014-03-25 15:17:40.912954	2014-03-25 15:17:51.956599
133	1	1278	3	2	1	0	0	2014-03-25 15:17:39.045594	2014-03-25 15:17:50.371567
120	1	1878	4	4	0	0	0	2014-03-25 15:17:38.869956	2014-03-25 15:18:22.676441
190	1	1389	2	2	0	0	0	2014-03-25 15:17:41.323717	2014-03-25 15:17:48.534241
166	1	1480	2	2	0	0	0	2014-03-25 15:17:40.702156	2014-03-25 15:18:22.326096
162	1	542	2	1	1	0	0	2014-03-25 15:17:40.477852	2014-03-25 15:18:22.950091
140	1	2116	11	11	0	0	0	2014-03-25 15:17:39.353328	2014-03-25 15:17:52.94372
180	1	1044	2	0	2	0	0	2014-03-25 15:17:40.980466	2014-03-25 15:17:52.026342
130	1	982	3	2	1	0	0	2014-03-25 15:17:39.022634	2014-03-25 15:17:50.363911
148	1	1883	2	2	0	0	0	2014-03-25 15:17:39.983563	2014-03-25 15:17:52.698527
169	1	1525	1	0	1	0	0	2014-03-25 15:17:40.761858	2014-03-25 15:17:40.763621
141	1	580	2	2	0	0	0	2014-03-25 15:17:39.383418	2014-03-25 15:17:39.388988
183	1	1786	6	3	3	0	0	2014-03-25 15:17:41.077947	2014-03-25 15:18:22.28695
111	1	1909	3	3	0	0	0	2014-03-25 15:17:38.587988	2014-03-25 15:18:22.937723
155	1	276	4	4	0	0	0	2014-03-25 15:17:40.354957	2014-03-25 15:17:45.624005
174	1	264	2	2	0	0	0	2014-03-25 15:17:40.855412	2014-03-25 15:17:51.907416
137	1	1902	6	5	1	0	0	2014-03-25 15:17:39.28266	2014-03-25 15:17:49.009529
145	1	1856	1	1	0	0	0	2014-03-25 15:17:39.867318	2014-03-25 15:17:39.86943
116	1	1515	6	6	0	0	0	2014-03-25 15:17:38.812833	2014-03-25 15:17:52.731286
149	1	1864	1	1	0	0	0	2014-03-25 15:17:39.989492	2014-03-25 15:17:39.990939
136	1	897	2	2	0	0	0	2014-03-25 15:17:39.274542	2014-03-25 15:17:43.076498
188	1	1593	2	2	0	0	0	2014-03-25 15:17:41.309169	2014-03-25 15:17:42.438841
151	1	578	1	0	1	0	0	2014-03-25 15:17:40.10766	2014-03-25 15:17:40.109409
118	1	1474	3	1	2	0	0	2014-03-25 15:17:38.830348	2014-03-25 15:18:22.30454
154	1	2047	1	0	1	0	0	2014-03-25 15:17:40.159581	2014-03-25 15:17:40.161224
156	1	1800	1	1	0	0	0	2014-03-25 15:17:40.388077	2014-03-25 15:17:40.389568
143	1	726	4	3	1	0	0	2014-03-25 15:17:39.638574	2014-03-25 15:18:22.260925
160	1	1610	1	1	0	0	0	2014-03-25 15:17:40.463349	2014-03-25 15:17:40.465176
165	1	1199	3	3	0	0	0	2014-03-25 15:17:40.549919	2014-03-25 15:17:50.329545
122	1	647	2	1	1	0	0	2014-03-25 15:17:38.894566	2014-03-25 15:18:22.958583
142	1	512	6	5	1	0	0	2014-03-25 15:17:39.631154	2014-03-25 15:17:51.0618
163	1	1604	1	1	0	0	0	2014-03-25 15:17:40.534806	2014-03-25 15:17:40.536247
158	1	1621	3	3	0	0	0	2014-03-25 15:17:40.411371	2014-03-25 15:17:53.059872
186	1	899	3	3	0	0	0	2014-03-25 15:17:41.279586	2014-03-25 15:17:50.63975
109	1	1917	8	8	0	0	0	2014-03-25 15:17:38.519119	2014-03-25 15:18:22.347882
171	1	299	2	2	0	0	0	2014-03-25 15:17:40.783221	2014-03-25 15:17:52.294546
157	1	1281	6	3	3	0	0	2014-03-25 15:17:40.394401	2014-03-25 15:17:52.301296
113	1	841	7	6	1	0	0	2014-03-25 15:17:38.614266	2014-03-25 15:17:51.242398
173	1	728	2	2	0	0	0	2014-03-25 15:17:40.808559	2014-03-25 15:17:52.314138
106	1	838	3	1	2	0	0	2014-03-25 15:17:38.320005	2014-03-25 15:17:52.383708
128	1	857	10	8	2	0	0	2014-03-25 15:17:38.99984	2014-03-25 15:18:21.630451
175	1	1464	4	4	0	0	0	2014-03-25 15:17:40.873029	2014-03-25 15:17:51.923633
159	1	964	2	1	1	0	0	2014-03-25 15:17:40.418093	2014-03-25 15:17:50.883004
119	1	1916	30	29	1	0	0	2014-03-25 15:17:38.85023	2014-03-25 15:18:22.841137
170	1	305	2	2	0	0	0	2014-03-25 15:17:40.777912	2014-03-25 15:17:52.2891
201	1	380	3	0	3	0	0	2014-03-25 15:17:41.598304	2014-03-25 15:17:52.948307
147	1	1879	7	5	2	0	0	2014-03-25 15:17:39.915298	2014-03-25 15:18:22.799869
144	1	752	2	2	0	0	0	2014-03-25 15:17:39.852214	2014-03-25 15:17:48.422427
124	1	1573	2	2	0	0	0	2014-03-25 15:17:38.920716	2014-03-25 15:17:41.038886
153	1	2060	2	1	1	0	0	2014-03-25 15:17:40.143147	2014-03-25 15:17:41.567047
182	1	1040	1	0	1	0	0	2014-03-25 15:17:41.058562	2014-03-25 15:17:41.060312
108	1	1980	3	3	0	0	0	2014-03-25 15:17:38.352773	2014-03-25 15:17:45.587681
189	1	1620	2	2	0	0	0	2014-03-25 15:17:41.316626	2014-03-25 15:17:50.965685
107	1	1258	2	2	0	0	0	2014-03-25 15:17:38.328066	2014-03-25 15:17:47.749435
181	1	978	11	7	4	0	0	2014-03-25 15:17:40.988617	2014-03-25 15:18:22.061771
132	1	2002	4	3	1	0	0	2014-03-25 15:17:39.039516	2014-03-25 15:18:21.668008
139	1	1873	12	6	6	0	0	2014-03-25 15:17:39.337792	2014-03-25 15:18:23.183974
187	1	1619	2	2	0	0	0	2014-03-25 15:17:41.301989	2014-03-25 15:17:50.952153
193	1	1438	1	0	1	0	0	2014-03-25 15:17:41.353617	2014-03-25 15:17:41.355292
179	1	1204	3	3	0	0	0	2014-03-25 15:17:40.946316	2014-03-25 15:17:51.993604
135	1	1404	3	2	1	0	0	2014-03-25 15:17:39.267638	2014-03-25 15:17:48.983021
195	1	1747	1	1	0	0	0	2014-03-25 15:17:41.421707	2014-03-25 15:17:41.424128
185	1	1288	3	2	1	0	0	2014-03-25 15:17:41.107131	2014-03-25 15:17:47.743304
196	1	121	1	1	0	0	0	2014-03-25 15:17:41.455318	2014-03-25 15:17:41.457118
197	1	621	1	0	1	0	0	2014-03-25 15:17:41.487764	2014-03-25 15:17:41.489967
198	1	547	1	0	1	0	0	2014-03-25 15:17:41.535534	2014-03-25 15:17:41.537608
104	1	1950	2	2	0	0	0	2014-03-25 15:17:38.093046	2014-03-25 15:17:41.54422
199	1	387	1	0	1	0	0	2014-03-25 15:17:41.573474	2014-03-25 15:17:41.575859
191	1	1392	2	2	0	0	0	2014-03-25 15:17:41.341664	2014-03-25 15:18:21.816684
200	1	577	3	1	2	0	0	2014-03-25 15:17:41.589862	2014-03-25 15:17:51.078127
103	1	500	5	0	5	0	0	2014-03-25 15:17:38.070361	2014-03-25 15:18:21.949537
121	1	1185	8	8	0	0	0	2014-03-25 15:17:38.876815	2014-03-25 15:18:22.20194
202	1	1848	1	1	0	0	0	2014-03-25 15:17:41.984836	2014-03-25 15:17:41.987121
164	1	1193	13	13	0	0	0	2014-03-25 15:17:40.540668	2014-03-25 15:18:23.106708
246	1	151	1	1	0	0	0	2014-03-25 15:17:44.157088	2014-03-25 15:17:44.159446
232	1	1599	2	1	1	0	0	2014-03-25 15:17:43.468649	2014-03-25 15:18:21.73983
204	1	1744	3	3	0	0	0	2014-03-25 15:17:41.999828	2014-03-25 15:17:42.066973
222	1	566	2	2	0	0	0	2014-03-25 15:17:43.034259	2014-03-25 15:17:51.59479
207	1	1396	1	1	0	0	0	2014-03-25 15:17:42.103533	2014-03-25 15:17:42.106036
266	1	1440	1	1	0	0	0	2014-03-25 15:17:45.667847	2014-03-25 15:17:45.670119
210	1	1317	1	1	0	0	0	2014-03-25 15:17:42.40068	2014-03-25 15:17:42.402701
250	1	442	2	2	0	0	0	2014-03-25 15:17:44.606593	2014-03-25 15:17:47.460315
267	1	1292	2	2	0	0	0	2014-03-25 15:17:45.706264	2014-03-25 15:17:50.945112
281	1	1054	1	1	0	0	0	2014-03-25 15:17:46.836988	2014-03-25 15:17:46.838561
216	1	1290	1	1	0	0	0	2014-03-25 15:17:42.582792	2014-03-25 15:17:42.584302
217	1	383	1	1	0	0	0	2014-03-25 15:17:42.591972	2014-03-25 15:17:42.59353
206	1	1379	3	3	0	0	0	2014-03-25 15:17:42.087936	2014-03-25 15:17:51.508758
203	1	1588	3	3	0	0	0	2014-03-25 15:17:41.992347	2014-03-25 15:18:23.115923
296	1	1946	4	4	0	0	0	2014-03-25 15:17:47.920511	2014-03-25 15:18:23.035844
220	1	1190	1	1	0	0	0	2014-03-25 15:17:42.998534	2014-03-25 15:17:43.000743
236	1	1752	3	3	0	0	0	2014-03-25 15:17:43.567387	2014-03-25 15:18:22.894513
275	1	353	2	2	0	0	0	2014-03-25 15:17:46.5532	2014-03-25 15:17:46.586748
261	1	1667	2	2	0	0	0	2014-03-25 15:17:45.568866	2014-03-25 15:18:22.759301
225	1	1543	1	1	0	0	0	2014-03-25 15:17:43.101876	2014-03-25 15:17:43.103837
208	1	1889	2	2	0	0	0	2014-03-25 15:17:42.156343	2014-03-25 15:17:43.16249
241	1	1093	13	13	0	0	0	2014-03-25 15:17:43.708414	2014-03-25 15:17:53.26603
227	1	110	1	0	1	0	0	2014-03-25 15:17:43.189757	2014-03-25 15:17:43.191295
254	1	1844	3	3	0	0	0	2014-03-25 15:17:45.091567	2014-03-25 15:17:46.590942
249	1	381	4	4	0	0	0	2014-03-25 15:17:44.551416	2014-03-25 15:17:51.253012
230	1	1109	1	1	0	0	0	2014-03-25 15:17:43.227033	2014-03-25 15:17:43.229167
231	1	46	1	1	0	0	0	2014-03-25 15:17:43.239753	2014-03-25 15:17:43.242112
209	1	992	3	2	1	0	0	2014-03-25 15:17:42.195668	2014-03-25 15:18:21.746548
233	1	1535	1	1	0	0	0	2014-03-25 15:17:43.480164	2014-03-25 15:17:43.481942
234	1	1439	1	1	0	0	0	2014-03-25 15:17:43.494446	2014-03-25 15:17:43.495996
235	1	979	1	1	0	0	0	2014-03-25 15:17:43.535929	2014-03-25 15:17:43.537479
259	1	1891	2	2	0	0	0	2014-03-25 15:17:45.248043	2014-03-25 15:17:50.204258
292	1	314	2	1	1	0	0	2014-03-25 15:17:47.761823	2014-03-25 15:17:49.989397
237	1	644	3	3	0	0	0	2014-03-25 15:17:43.609354	2014-03-25 15:17:43.625852
276	1	1991	1	1	0	0	0	2014-03-25 15:17:46.652231	2014-03-25 15:17:46.653974
239	1	931	1	0	1	0	0	2014-03-25 15:17:43.656023	2014-03-25 15:17:43.657437
224	1	1235	2	2	0	0	0	2014-03-25 15:17:43.048249	2014-03-25 15:17:47.049763
242	1	2036	1	0	1	0	0	2014-03-25 15:17:43.729415	2014-03-25 15:17:43.731344
244	1	1979	1	1	0	0	0	2014-03-25 15:17:44.108768	2014-03-25 15:17:44.11109
248	1	1609	2	0	2	0	0	2014-03-25 15:17:44.284109	2014-03-25 15:17:50.887936
205	1	1999	7	4	3	0	0	2014-03-25 15:17:42.042494	2014-03-25 15:18:22.832385
251	1	414	1	0	1	0	0	2014-03-25 15:17:44.624844	2014-03-25 15:17:44.626213
228	1	1091	28	17	11	0	0	2014-03-25 15:17:43.204117	2014-03-25 15:17:53.235637
211	1	602	2	1	1	0	0	2014-03-25 15:17:42.432352	2014-03-25 15:17:45.762234
272	1	586	2	2	0	0	0	2014-03-25 15:17:46.209102	2014-03-25 15:18:21.786106
247	1	1597	2	1	1	0	0	2014-03-25 15:17:44.239966	2014-03-25 15:18:21.726122
252	1	648	3	1	2	0	0	2014-03-25 15:17:44.631269	2014-03-25 15:18:22.74682
282	1	1339	1	1	0	0	0	2014-03-25 15:17:47.246511	2014-03-25 15:17:47.248884
238	1	1365	3	3	0	0	0	2014-03-25 15:17:43.647332	2014-03-25 15:17:45.114856
255	1	31	2	2	0	0	0	2014-03-25 15:17:45.136928	2014-03-25 15:17:45.15578
256	1	1888	1	1	0	0	0	2014-03-25 15:17:45.177402	2014-03-25 15:17:45.17917
277	1	506	1	0	1	0	0	2014-03-25 15:17:46.674583	2014-03-25 15:17:46.676177
245	1	263	3	1	2	0	0	2014-03-25 15:17:44.120266	2014-03-25 15:17:53.225949
253	1	423	2	2	0	0	0	2014-03-25 15:17:45.071814	2014-03-25 15:18:22.681925
283	1	187	2	2	0	0	0	2014-03-25 15:17:47.261074	2014-03-25 15:17:49.49053
260	1	1714	1	1	0	0	0	2014-03-25 15:17:45.550517	2014-03-25 15:17:45.552445
226	1	1078	4	4	0	0	0	2014-03-25 15:17:43.181072	2014-03-25 15:18:22.794057
262	1	880	1	1	0	0	0	2014-03-25 15:17:45.574233	2014-03-25 15:17:45.575721
263	1	1990	1	1	0	0	0	2014-03-25 15:17:45.592271	2014-03-25 15:17:45.593763
221	1	1882	2	2	0	0	0	2014-03-25 15:17:43.028509	2014-03-25 15:17:47.381463
223	1	591	5	3	2	0	0	2014-03-25 15:17:43.039302	2014-03-25 15:17:53.30567
265	1	1441	1	1	0	0	0	2014-03-25 15:17:45.653302	2014-03-25 15:17:45.654746
268	1	2014	1	0	1	0	0	2014-03-25 15:17:45.778508	2014-03-25 15:17:45.780008
269	1	2070	1	1	0	0	0	2014-03-25 15:17:46.153601	2014-03-25 15:17:46.155998
270	1	1837	1	1	0	0	0	2014-03-25 15:17:46.196634	2014-03-25 15:17:46.198423
271	1	1843	1	1	0	0	0	2014-03-25 15:17:46.202836	2014-03-25 15:17:46.20427
295	1	1216	2	2	0	0	0	2014-03-25 15:17:47.912358	2014-03-25 15:18:21.935378
273	1	794	1	1	0	0	0	2014-03-25 15:17:46.224783	2014-03-25 15:17:46.226398
294	1	1899	3	3	0	0	0	2014-03-25 15:17:47.826953	2014-03-25 15:17:53.091369
289	1	805	1	1	0	0	0	2014-03-25 15:17:47.517509	2014-03-25 15:17:47.519427
278	1	915	1	1	0	0	0	2014-03-25 15:17:46.69337	2014-03-25 15:17:46.694803
274	1	1910	3	3	0	0	0	2014-03-25 15:17:46.282165	2014-03-25 15:17:52.586667
243	1	379	4	3	1	0	0	2014-03-25 15:17:43.736215	2014-03-25 15:17:51.539355
279	1	1089	1	0	1	0	0	2014-03-25 15:17:46.739303	2014-03-25 15:17:46.741636
280	1	1124	1	0	1	0	0	2014-03-25 15:17:46.802864	2014-03-25 15:17:46.804374
284	1	181	1	1	0	0	0	2014-03-25 15:17:47.267514	2014-03-25 15:17:47.26895
285	1	366	1	1	0	0	0	2014-03-25 15:17:47.278396	2014-03-25 15:17:47.279756
257	1	1447	3	3	0	0	0	2014-03-25 15:17:45.198483	2014-03-25 15:17:47.283464
286	1	1153	1	1	0	0	0	2014-03-25 15:17:47.300001	2014-03-25 15:17:47.302252
258	1	1225	3	3	0	0	0	2014-03-25 15:17:45.23868	2014-03-25 15:17:52.641008
287	1	1603	1	1	0	0	0	2014-03-25 15:17:47.41446	2014-03-25 15:17:47.416486
212	1	1586	2	2	0	0	0	2014-03-25 15:17:42.442842	2014-03-25 15:17:47.421224
229	1	1047	4	3	1	0	0	2014-03-25 15:17:43.216874	2014-03-25 15:17:49.082445
290	1	2022	1	1	0	0	0	2014-03-25 15:17:47.536377	2014-03-25 15:17:47.538081
218	1	965	2	0	2	0	0	2014-03-25 15:17:42.600159	2014-03-25 15:17:50.004211
293	1	312	1	1	0	0	0	2014-03-25 15:17:47.78792	2014-03-25 15:17:47.790079
264	1	611	2	2	0	0	0	2014-03-25 15:17:45.645115	2014-03-25 15:17:50.397313
291	1	448	2	2	0	0	0	2014-03-25 15:17:47.543671	2014-03-25 15:17:47.845427
303	1	472	2	2	0	0	0	2014-03-25 15:17:48.506192	2014-03-25 15:18:22.312874
288	1	1583	3	0	3	0	0	2014-03-25 15:17:47.426336	2014-03-25 15:18:22.822501
215	1	1928	4	4	0	0	0	2014-03-25 15:17:42.508473	2014-03-25 15:17:50.161628
297	1	1641	1	0	1	0	0	2014-03-25 15:17:48.041661	2014-03-25 15:17:48.044427
214	1	2049	3	3	0	0	0	2014-03-25 15:17:42.491883	2014-03-25 15:17:48.96934
299	1	738	1	0	1	0	0	2014-03-25 15:17:48.059415	2014-03-25 15:17:48.060701
298	1	1157	3	3	0	0	0	2014-03-25 15:17:48.053268	2014-03-25 15:17:53.141036
300	1	1798	1	1	0	0	0	2014-03-25 15:17:48.401854	2014-03-25 15:17:48.403916
301	1	1780	2	2	0	0	0	2014-03-25 15:17:48.428761	2014-03-25 15:17:48.437292
302	1	1673	1	1	0	0	0	2014-03-25 15:17:48.444642	2014-03-25 15:17:48.446621
213	1	2000	8	7	1	0	0	2014-03-25 15:17:42.466639	2014-03-25 15:18:22.927576
219	1	1906	5	4	1	0	0	2014-03-25 15:17:42.611974	2014-03-25 15:18:22.860453
240	1	930	9	5	4	0	0	2014-03-25 15:17:43.66112	2014-03-25 15:17:52.362283
305	1	515	1	0	1	0	0	2014-03-25 15:17:48.620653	2014-03-25 15:17:48.622428
306	1	669	1	0	1	0	0	2014-03-25 15:17:48.631018	2014-03-25 15:17:48.633513
307	1	374	1	1	0	0	0	2014-03-25 15:17:48.668187	2014-03-25 15:17:48.66957
308	1	493	1	0	1	0	0	2014-03-25 15:17:48.673556	2014-03-25 15:17:48.674942
309	1	2143	1	1	0	0	0	2014-03-25 15:17:48.67904	2014-03-25 15:17:48.680558
310	1	422	1	1	0	0	0	2014-03-25 15:17:48.688298	2014-03-25 15:17:48.690239
311	1	1042	1	0	1	0	0	2014-03-25 15:17:48.716834	2014-03-25 15:17:48.718911
312	1	769	1	1	0	0	0	2014-03-25 15:17:48.839165	2014-03-25 15:17:48.841196
313	1	588	1	1	0	0	0	2014-03-25 15:17:48.881512	2014-03-25 15:17:48.883218
317	1	935	1	0	1	0	0	2014-03-25 15:17:49.06316	2014-03-25 15:17:49.065658
318	1	375	1	1	0	0	0	2014-03-25 15:17:49.092369	2014-03-25 15:17:49.093874
319	1	295	1	0	1	0	0	2014-03-25 15:17:49.109032	2014-03-25 15:17:49.110776
315	1	962	2	0	2	0	0	2014-03-25 15:17:49.035353	2014-03-25 15:17:49.158733
349	1	1444	1	0	1	0	0	2014-03-25 15:17:51.20733	2014-03-25 15:17:51.208936
321	1	378	1	1	0	0	0	2014-03-25 15:17:49.631922	2014-03-25 15:17:49.633467
322	1	678	1	0	1	0	0	2014-03-25 15:17:49.699391	2014-03-25 15:17:49.701022
371	1	280	1	1	0	0	0	2014-03-25 15:17:52.609305	2014-03-25 15:17:52.611374
324	1	339	1	0	1	0	0	2014-03-25 15:17:49.73523	2014-03-25 15:17:49.736609
325	1	1512	1	0	1	0	0	2014-03-25 15:17:49.741536	2014-03-25 15:17:49.743009
326	1	443	1	1	0	0	0	2014-03-25 15:17:49.766523	2014-03-25 15:17:49.769137
327	1	436	1	0	1	0	0	2014-03-25 15:17:49.781576	2014-03-25 15:17:49.783174
328	1	1983	1	1	0	0	0	2014-03-25 15:17:49.78825	2014-03-25 15:17:49.789816
329	1	545	1	1	0	0	0	2014-03-25 15:17:49.865482	2014-03-25 15:17:49.867054
330	1	1565	1	1	0	0	0	2014-03-25 15:17:49.914702	2014-03-25 15:17:49.916311
350	1	2012	2	0	2	0	0	2014-03-25 15:17:51.218393	2014-03-25 15:17:51.226335
332	1	1756	1	1	0	0	0	2014-03-25 15:17:50.012448	2014-03-25 15:17:50.013846
304	1	513	5	1	4	0	0	2014-03-25 15:17:48.593409	2014-03-25 15:17:51.262151
334	1	1531	1	1	0	0	0	2014-03-25 15:17:50.054672	2014-03-25 15:17:50.056508
335	1	1877	1	1	0	0	0	2014-03-25 15:17:50.097465	2014-03-25 15:17:50.100386
314	1	1399	3	2	1	0	0	2014-03-25 15:17:48.975723	2014-03-25 15:18:22.172519
337	1	1467	1	1	0	0	0	2014-03-25 15:17:50.184113	2014-03-25 15:17:50.186573
372	1	1191	1	1	0	0	0	2014-03-25 15:17:52.63559	2014-03-25 15:17:52.637177
336	1	597	2	2	0	0	0	2014-03-25 15:17:50.131994	2014-03-25 15:18:21.803289
316	1	1655	3	2	1	0	0	2014-03-25 15:17:49.054077	2014-03-25 15:18:23.195608
340	1	1492	1	1	0	0	0	2014-03-25 15:17:50.338984	2014-03-25 15:17:50.340962
341	1	789	1	1	0	0	0	2014-03-25 15:17:50.379245	2014-03-25 15:17:50.381114
320	1	1708	2	2	0	0	0	2014-03-25 15:17:49.615367	2014-03-25 15:17:50.386859
343	1	905	1	1	0	0	0	2014-03-25 15:17:50.41209	2014-03-25 15:17:50.413626
331	1	402	2	1	1	0	0	2014-03-25 15:17:49.996138	2014-03-25 15:17:50.422198
344	1	1041	1	1	0	0	0	2014-03-25 15:17:50.694148	2014-03-25 15:17:50.695683
345	1	425	1	1	0	0	0	2014-03-25 15:17:50.774318	2014-03-25 15:17:50.775724
333	1	1590	2	2	0	0	0	2014-03-25 15:17:50.046118	2014-03-25 15:17:50.89331
346	1	1951	1	1	0	0	0	2014-03-25 15:17:50.91053	2014-03-25 15:17:50.912232
342	1	739	2	1	1	0	0	2014-03-25 15:17:50.390718	2014-03-25 15:17:50.97141
347	1	1622	1	1	0	0	0	2014-03-25 15:17:50.976217	2014-03-25 15:17:50.978055
348	1	774	1	1	0	0	0	2014-03-25 15:17:51.137458	2014-03-25 15:17:51.139395
351	1	1584	1	1	0	0	0	2014-03-25 15:17:51.360634	2014-03-25 15:17:51.362919
339	1	1705	2	2	0	0	0	2014-03-25 15:17:50.30245	2014-03-25 15:18:22.356125
352	1	612	1	0	1	0	0	2014-03-25 15:17:51.395054	2014-03-25 15:17:51.396451
388	2	1465	4	4	0	0	0	2014-03-25 15:17:53.356718	2014-03-25 15:18:24.845704
354	1	1581	1	1	0	0	0	2014-03-25 15:17:51.479091	2014-03-25 15:17:51.480534
355	1	1220	1	1	0	0	0	2014-03-25 15:17:51.490216	2014-03-25 15:17:51.492274
356	1	1663	1	1	0	0	0	2014-03-25 15:17:51.513355	2014-03-25 15:17:51.515064
357	1	1301	1	0	0	0	1	2014-03-25 15:17:51.564543	2014-03-25 15:17:51.566294
358	1	1806	1	1	0	0	0	2014-03-25 15:17:51.573643	2014-03-25 15:17:51.5753
359	1	2122	1	1	0	0	0	2014-03-25 15:17:51.58047	2014-03-25 15:17:51.581843
360	1	2121	1	1	0	0	0	2014-03-25 15:17:51.605412	2014-03-25 15:17:51.607809
361	1	405	1	0	1	0	0	2014-03-25 15:17:51.614085	2014-03-25 15:17:51.615625
362	1	681	1	0	1	0	0	2014-03-25 15:17:51.777594	2014-03-25 15:17:51.787768
363	1	355	1	0	1	0	0	2014-03-25 15:17:51.818748	2014-03-25 15:17:51.820152
364	1	933	1	0	1	0	0	2014-03-25 15:17:51.829398	2014-03-25 15:17:51.831005
373	1	1217	1	1	0	0	0	2014-03-25 15:17:52.645412	2014-03-25 15:17:52.647849
365	1	1390	1	1	0	0	0	2014-03-25 15:17:52.193159	2014-03-25 15:17:52.194591
366	1	1721	1	1	0	0	0	2014-03-25 15:17:52.242159	2014-03-25 15:17:52.244447
367	1	1720	1	1	0	0	0	2014-03-25 15:17:52.265279	2014-03-25 15:17:52.266897
323	1	429	4	0	4	0	0	2014-03-25 15:17:49.71863	2014-03-25 15:17:52.356549
368	1	1052	1	1	0	0	0	2014-03-25 15:17:52.417602	2014-03-25 15:17:52.419206
369	1	1903	1	1	0	0	0	2014-03-25 15:17:52.53294	2014-03-25 15:17:52.534561
370	1	1704	1	1	0	0	0	2014-03-25 15:17:52.550624	2014-03-25 15:17:52.552088
374	1	748	1	0	1	0	0	2014-03-25 15:17:52.716113	2014-03-25 15:17:52.718283
375	1	1591	1	1	0	0	0	2014-03-25 15:17:52.736271	2014-03-25 15:17:52.737689
376	1	1470	1	0	1	0	0	2014-03-25 15:17:52.902172	2014-03-25 15:17:52.912489
377	1	440	1	1	0	0	0	2014-03-25 15:17:52.92708	2014-03-25 15:17:52.929088
378	1	760	2	2	0	0	0	2014-03-25 15:17:52.955056	2014-03-25 15:17:52.961167
379	1	271	1	0	1	0	0	2014-03-25 15:17:52.969473	2014-03-25 15:17:52.971422
353	1	1659	2	1	1	0	0	2014-03-25 15:17:51.409251	2014-03-25 15:17:53.024061
380	1	1397	1	1	0	0	0	2014-03-25 15:17:53.02931	2014-03-25 15:17:53.031602
401	2	1874	21	16	5	0	0	2014-03-25 15:17:53.474688	2014-03-25 15:18:25.157351
381	1	1690	1	0	1	0	0	2014-03-25 15:17:53.150349	2014-03-25 15:17:53.151753
392	2	380	2	0	2	0	0	2014-03-25 15:17:53.38554	2014-03-25 15:17:58.267957
402	2	1189	8	4	4	0	0	2014-03-25 15:17:53.481547	2014-03-25 15:17:59.163344
387	2	838	1	0	1	0	0	2014-03-25 15:17:53.350191	2014-03-25 15:17:53.35226
399	2	1193	2	0	2	0	0	2014-03-25 15:17:53.454817	2014-03-25 15:17:54.326555
390	2	1908	14	7	7	0	0	2014-03-25 15:17:53.369693	2014-03-25 15:18:24.625604
404	2	506	3	2	1	0	0	2014-03-25 15:17:53.500324	2014-03-25 15:17:55.642129
397	2	1625	5	2	3	0	0	2014-03-25 15:17:53.43042	2014-03-25 15:17:58.372259
396	2	1950	2	2	0	0	0	2014-03-25 15:17:53.421597	2014-03-25 15:18:23.36689
395	2	1662	10	7	3	0	0	2014-03-25 15:17:53.414215	2014-03-25 15:18:24.864879
391	2	447	3	2	1	0	0	2014-03-25 15:17:53.379583	2014-03-25 15:17:57.624871
394	2	1768	8	7	1	0	0	2014-03-25 15:17:53.403325	2014-03-25 15:18:24.929089
383	2	502	11	3	8	0	0	2014-03-25 15:17:53.321414	2014-03-25 15:18:24.507093
398	2	500	1	1	0	0	0	2014-03-25 15:17:53.441888	2014-03-25 15:17:53.443867
385	2	1805	13	11	2	0	0	2014-03-25 15:17:53.335655	2014-03-25 15:18:24.805615
384	2	930	3	2	1	0	0	2014-03-25 15:17:53.32905	2014-03-25 15:18:23.971554
400	2	446	1	1	0	0	0	2014-03-25 15:17:53.461166	2014-03-25 15:17:53.462558
403	2	337	10	8	2	0	0	2014-03-25 15:17:53.493209	2014-03-25 15:18:24.877796
389	2	373	6	2	4	0	0	2014-03-25 15:17:53.362173	2014-03-25 15:18:24.771144
386	2	443	2	1	1	0	0	2014-03-25 15:17:53.34157	2014-03-25 15:17:55.392663
338	1	365	2	2	0	0	0	2014-03-25 15:17:50.234117	2014-03-25 15:18:21.562688
393	2	1475	2	1	1	0	0	2014-03-25 15:17:53.393553	2014-03-25 15:18:23.355127
382	2	437	2	0	2	0	0	2014-03-25 15:17:53.312061	2014-03-25 15:17:53.533893
405	2	820	1	0	1	0	0	2014-03-25 15:17:53.509604	2014-03-25 15:17:53.511897
406	2	1163	1	1	0	0	0	2014-03-25 15:17:53.518938	2014-03-25 15:17:53.520588
407	2	1162	1	1	0	0	0	2014-03-25 15:17:53.52425	2014-03-25 15:17:53.527473
419	2	1917	6	5	1	0	0	2014-03-25 15:17:53.667296	2014-03-25 15:18:25.242334
418	2	501	17	5	12	0	0	2014-03-25 15:17:53.655578	2014-03-25 15:18:25.206809
448	2	739	3	1	2	0	0	2014-03-25 15:17:54.135001	2014-03-25 15:18:24.883115
498	2	1564	4	4	0	0	0	2014-03-25 15:17:54.983052	2014-03-25 15:18:24.738563
430	2	991	4	0	4	0	0	2014-03-25 15:17:53.791027	2014-03-25 15:18:23.237055
414	2	962	1	0	1	0	0	2014-03-25 15:17:53.625986	2014-03-25 15:17:53.627314
417	2	1845	1	0	1	0	0	2014-03-25 15:17:53.64545	2014-03-25 15:17:53.647095
450	2	571	1	0	1	0	0	2014-03-25 15:17:54.156681	2014-03-25 15:17:54.158783
451	2	730	13	4	9	0	0	2014-03-25 15:17:54.165057	2014-03-25 15:18:24.572203
472	2	641	3	2	1	0	0	2014-03-25 15:17:54.600416	2014-03-25 15:17:55.559869
408	2	261	2	1	1	0	0	2014-03-25 15:17:53.545308	2014-03-25 15:18:24.90723
421	2	740	1	0	1	0	0	2014-03-25 15:17:53.708635	2014-03-25 15:17:53.710295
410	2	563	2	2	0	0	0	2014-03-25 15:17:53.574913	2014-03-25 15:17:54.173104
424	2	1928	1	0	1	0	0	2014-03-25 15:17:53.729186	2014-03-25 15:17:53.730469
415	2	577	3	0	3	0	0	2014-03-25 15:17:53.633234	2014-03-25 15:18:24.416856
469	2	1200	8	7	1	0	0	2014-03-25 15:17:54.488946	2014-03-25 15:18:25.256517
427	2	554	1	1	0	0	0	2014-03-25 15:17:53.766586	2014-03-25 15:17:53.769248
496	2	2037	2	1	1	0	0	2014-03-25 15:17:54.951476	2014-03-25 15:17:57.704025
494	2	1702	5	5	0	0	0	2014-03-25 15:17:54.925364	2014-03-25 15:18:24.609027
461	2	548	7	4	3	0	0	2014-03-25 15:17:54.319131	2014-03-25 15:18:23.312734
431	2	1889	1	1	0	0	0	2014-03-25 15:17:53.800241	2014-03-25 15:17:53.802204
433	2	557	1	0	1	0	0	2014-03-25 15:17:53.817176	2014-03-25 15:17:53.818622
434	2	1004	1	1	0	0	0	2014-03-25 15:17:53.823482	2014-03-25 15:17:53.825059
435	2	998	1	1	0	0	0	2014-03-25 15:17:53.829498	2014-03-25 15:17:53.831013
484	2	623	1	0	1	0	0	2014-03-25 15:17:54.78414	2014-03-25 15:17:54.785646
438	2	870	1	1	0	0	0	2014-03-25 15:17:53.850997	2014-03-25 15:17:53.853136
488	2	726	7	7	0	0	0	2014-03-25 15:17:54.823143	2014-03-25 15:17:57.971293
467	2	964	1	0	1	0	0	2014-03-25 15:17:54.443043	2014-03-25 15:17:54.444551
476	2	1703	1	1	0	0	0	2014-03-25 15:17:54.669652	2014-03-25 15:17:54.671158
452	2	1151	4	3	1	0	0	2014-03-25 15:17:54.180324	2014-03-25 15:17:58.838917
443	2	1051	1	0	1	0	0	2014-03-25 15:17:54.074196	2014-03-25 15:17:54.076159
444	2	1772	1	1	0	0	0	2014-03-25 15:17:54.08309	2014-03-25 15:17:54.085317
468	2	556	1	1	0	0	0	2014-03-25 15:17:54.466973	2014-03-25 15:17:54.468519
446	2	621	1	0	1	0	0	2014-03-25 15:17:54.109541	2014-03-25 15:17:54.112203
447	2	1006	1	0	1	0	0	2014-03-25 15:17:54.127693	2014-03-25 15:17:54.129146
409	2	865	2	2	0	0	0	2014-03-25 15:17:53.554244	2014-03-25 15:18:24.615638
492	2	816	1	1	0	0	0	2014-03-25 15:17:54.902396	2014-03-25 15:17:54.903908
454	2	950	6	2	4	0	0	2014-03-25 15:17:54.205508	2014-03-25 15:17:57.902468
477	2	109	1	0	1	0	0	2014-03-25 15:17:54.679345	2014-03-25 15:17:54.680814
439	2	728	2	2	0	0	0	2014-03-25 15:17:53.860499	2014-03-25 15:17:56.370789
411	2	831	23	23	0	0	0	2014-03-25 15:17:53.583048	2014-03-25 15:18:25.217016
455	2	2032	1	0	1	0	0	2014-03-25 15:17:54.236709	2014-03-25 15:17:54.238616
456	2	1552	1	1	0	0	0	2014-03-25 15:17:54.243283	2014-03-25 15:17:54.244791
499	2	1873	5	3	2	0	0	2014-03-25 15:17:55.186934	2014-03-25 15:18:24.530888
457	2	1910	2	2	0	0	0	2014-03-25 15:17:54.25114	2014-03-25 15:17:54.260086
458	2	1482	1	1	0	0	0	2014-03-25 15:17:54.266777	2014-03-25 15:17:54.268356
491	2	1450	2	1	1	0	0	2014-03-25 15:17:54.853345	2014-03-25 15:17:59.512122
485	2	564	1	1	0	0	0	2014-03-25 15:17:54.799779	2014-03-25 15:17:54.802013
429	2	1934	2	2	0	0	0	2014-03-25 15:17:53.783893	2014-03-25 15:17:59.353992
441	2	1152	6	6	0	0	0	2014-03-25 15:17:54.045132	2014-03-25 15:18:23.708737
426	2	1909	8	8	0	0	0	2014-03-25 15:17:53.747505	2014-03-25 15:18:23.562766
473	2	1146	2	1	1	0	0	2014-03-25 15:17:54.61433	2014-03-25 15:17:57.459929
449	2	516	5	4	1	0	0	2014-03-25 15:17:54.142497	2014-03-25 15:17:58.955699
504	2	602	3	2	1	0	0	2014-03-25 15:17:55.295795	2014-03-25 15:18:24.797695
463	2	1904	1	0	1	0	0	2014-03-25 15:17:54.358917	2014-03-25 15:17:54.360365
420	2	1806	2	2	0	0	0	2014-03-25 15:17:53.701299	2014-03-25 15:17:54.36783
490	2	595	2	2	0	0	0	2014-03-25 15:17:54.845022	2014-03-25 15:18:23.567954
465	2	2054	1	0	1	0	0	2014-03-25 15:17:54.384092	2014-03-25 15:17:54.385586
482	2	2036	7	4	3	0	0	2014-03-25 15:17:54.764577	2014-03-25 15:17:59.187139
462	2	729	6	6	0	0	0	2014-03-25 15:17:54.332452	2014-03-25 15:17:59.403281
436	2	978	4	4	0	0	0	2014-03-25 15:17:53.835041	2014-03-25 15:17:58.412942
422	2	591	90	9	81	0	0	2014-03-25 15:17:53.717661	2014-03-25 15:18:24.220027
459	2	2034	22	5	17	0	0	2014-03-25 15:17:54.279244	2014-03-25 15:17:55.87259
474	2	868	9	0	9	0	0	2014-03-25 15:17:54.624754	2014-03-25 15:17:59.832464
497	2	1907	23	18	5	0	0	2014-03-25 15:17:54.9612	2014-03-25 15:18:25.193024
470	2	949	1	0	1	0	0	2014-03-25 15:17:54.572814	2014-03-25 15:17:54.574716
486	2	1843	1	0	1	0	0	2014-03-25 15:17:54.808248	2014-03-25 15:17:54.810123
440	2	1786	4	3	1	0	0	2014-03-25 15:17:54.038834	2014-03-25 15:18:24.014798
413	2	1468	3	3	0	0	0	2014-03-25 15:17:53.619723	2014-03-25 15:17:59.454228
453	2	992	4	2	2	0	0	2014-03-25 15:17:54.188224	2014-03-25 15:17:59.905035
475	2	844	2	1	1	0	0	2014-03-25 15:17:54.654943	2014-03-25 15:17:57.053425
466	2	547	2	0	2	0	0	2014-03-25 15:17:54.390043	2014-03-25 15:17:56.309022
483	2	2122	1	1	0	0	0	2014-03-25 15:17:54.775122	2014-03-25 15:17:54.777315
487	2	1382	1	1	0	0	0	2014-03-25 15:17:54.816597	2014-03-25 15:17:54.818149
423	2	1460	13	11	2	0	0	2014-03-25 15:17:53.723589	2014-03-25 15:18:25.282144
489	2	311	1	1	0	0	0	2014-03-25 15:17:54.839288	2014-03-25 15:17:54.840851
428	2	555	8	7	1	0	0	2014-03-25 15:17:53.775025	2014-03-25 15:18:23.755082
481	2	362	2	2	0	0	0	2014-03-25 15:17:54.759165	2014-03-25 15:17:56.135953
412	2	442	3	3	0	0	0	2014-03-25 15:17:53.596755	2014-03-25 15:18:24.702201
416	2	539	5	2	3	0	0	2014-03-25 15:17:53.639051	2014-03-25 15:17:56.878004
493	2	815	1	0	1	0	0	2014-03-25 15:17:54.918271	2014-03-25 15:17:54.919901
495	2	299	1	0	1	0	0	2014-03-25 15:17:54.933021	2014-03-25 15:17:54.935295
425	2	1124	2	0	2	0	0	2014-03-25 15:17:53.738262	2014-03-25 15:18:24.411644
460	2	1278	2	0	2	0	0	2014-03-25 15:17:54.309953	2014-03-25 15:18:23.525635
437	2	1916	23	23	0	0	0	2014-03-25 15:17:53.843353	2014-03-25 15:18:24.565198
478	2	613	2	0	2	0	0	2014-03-25 15:17:54.69492	2014-03-25 15:17:54.991782
432	2	2035	20	17	3	0	0	2014-03-25 15:17:53.808586	2014-03-25 15:17:59.589081
480	2	1947	4	1	3	0	0	2014-03-25 15:17:54.738288	2014-03-25 15:17:58.212165
500	2	396	1	0	1	0	0	2014-03-25 15:17:55.217387	2014-03-25 15:17:55.219461
442	2	1288	4	3	1	0	0	2014-03-25 15:17:54.06578	2014-03-25 15:18:24.890381
501	2	982	1	0	1	0	0	2014-03-25 15:17:55.230201	2014-03-25 15:17:55.232872
502	2	387	1	0	1	0	0	2014-03-25 15:17:55.251361	2014-03-25 15:17:55.252859
505	2	1489	2	1	1	0	0	2014-03-25 15:17:55.312122	2014-03-25 15:18:24.942819
503	2	403	1	1	0	0	0	2014-03-25 15:17:55.27313	2014-03-25 15:17:55.274923
445	2	544	5	1	4	0	0	2014-03-25 15:17:54.099597	2014-03-25 15:18:24.898911
479	2	1462	3	1	2	0	0	2014-03-25 15:17:54.702627	2014-03-25 15:18:25.276288
471	2	1995	11	10	1	0	0	2014-03-25 15:17:54.588914	2014-03-25 15:18:25.186781
464	2	1999	3	3	0	0	0	2014-03-25 15:17:54.373558	2014-03-25 15:17:59.780705
506	2	1021	1	1	0	0	0	2014-03-25 15:17:55.320302	2014-03-25 15:17:55.3222
553	2	1201	1	0	1	0	0	2014-03-25 15:17:56.324053	2014-03-25 15:17:56.326173
507	2	1514	2	2	0	0	0	2014-03-25 15:17:55.376456	2014-03-25 15:17:55.388024
517	2	1386	2	2	0	0	0	2014-03-25 15:17:55.570074	2014-03-25 15:18:25.289993
591	2	2068	1	0	1	0	0	2014-03-25 15:17:57.282802	2014-03-25 15:17:57.285288
586	2	1317	3	1	2	0	0	2014-03-25 15:17:57.156041	2014-03-25 15:18:24.287299
561	2	1593	2	2	0	0	0	2014-03-25 15:17:56.469085	2014-03-25 15:18:23.62711
514	2	735	1	1	0	0	0	2014-03-25 15:17:55.514233	2014-03-25 15:17:55.51687
573	2	1882	2	2	0	0	0	2014-03-25 15:17:56.728723	2014-03-25 15:18:24.647123
516	2	1251	1	0	1	0	0	2014-03-25 15:17:55.552093	2014-03-25 15:17:55.553752
599	2	1536	2	1	1	0	0	2014-03-25 15:17:57.655203	2014-03-25 15:18:24.826548
583	2	1650	4	3	1	0	0	2014-03-25 15:17:57.100546	2014-03-25 15:18:24.696503
520	2	648	1	1	0	0	0	2014-03-25 15:17:55.634759	2014-03-25 15:17:55.636619
521	2	608	1	1	0	0	0	2014-03-25 15:17:55.654728	2014-03-25 15:17:55.656235
522	2	876	1	0	1	0	0	2014-03-25 15:17:55.6949	2014-03-25 15:17:55.697111
590	2	263	3	2	1	0	0	2014-03-25 15:17:57.229611	2014-03-25 15:17:58.293369
524	2	1937	1	1	0	0	0	2014-03-25 15:17:55.722995	2014-03-25 15:17:55.724754
548	2	669	5	0	5	0	0	2014-03-25 15:17:56.074761	2014-03-25 15:17:58.436099
526	2	601	1	1	0	0	0	2014-03-25 15:17:55.757358	2014-03-25 15:17:55.758922
527	2	110	1	1	0	0	0	2014-03-25 15:17:55.762383	2014-03-25 15:17:55.763726
600	2	589	2	1	1	0	0	2014-03-25 15:17:57.666057	2014-03-25 15:18:23.27414
581	2	1710	1	1	0	0	0	2014-03-25 15:17:57.074747	2014-03-25 15:17:57.07629
566	2	432	5	5	0	0	0	2014-03-25 15:17:56.557205	2014-03-25 15:18:25.222464
554	2	412	1	0	1	0	0	2014-03-25 15:17:56.334557	2014-03-25 15:17:56.336125
531	2	1039	2	0	2	0	0	2014-03-25 15:17:55.79323	2014-03-25 15:17:55.7998
538	2	1875	10	10	0	0	0	2014-03-25 15:17:55.910345	2014-03-25 15:17:59.473593
533	2	2131	1	0	1	0	0	2014-03-25 15:17:55.822028	2014-03-25 15:17:55.82365
534	2	1259	1	0	1	0	0	2014-03-25 15:17:55.841566	2014-03-25 15:17:55.84353
535	2	525	1	1	0	0	0	2014-03-25 15:17:55.854076	2014-03-25 15:17:55.855774
536	2	2003	1	1	0	0	0	2014-03-25 15:17:55.865772	2014-03-25 15:17:55.867337
559	2	1377	6	6	0	0	0	2014-03-25 15:17:56.429664	2014-03-25 15:18:24.721676
539	2	1991	1	0	1	0	0	2014-03-25 15:17:55.918937	2014-03-25 15:17:55.920672
540	2	848	1	1	0	0	0	2014-03-25 15:17:55.930595	2014-03-25 15:17:55.932192
525	2	979	3	1	2	0	0	2014-03-25 15:17:55.749504	2014-03-25 15:17:59.526279
542	2	1156	1	1	0	0	0	2014-03-25 15:17:55.957151	2014-03-25 15:17:55.958602
543	2	381	1	0	1	0	0	2014-03-25 15:17:55.980093	2014-03-25 15:17:55.982837
574	2	738	1	0	1	0	0	2014-03-25 15:17:56.742805	2014-03-25 15:17:56.745168
575	2	855	2	2	0	0	0	2014-03-25 15:17:56.845378	2014-03-25 15:18:23.762679
546	2	881	1	1	0	0	0	2014-03-25 15:17:56.047445	2014-03-25 15:17:56.049098
550	2	1131	1	1	0	0	0	2014-03-25 15:17:56.118128	2014-03-25 15:17:56.11945
551	2	377	1	0	1	0	0	2014-03-25 15:17:56.123867	2014-03-25 15:17:56.1253
552	2	360	1	1	0	0	0	2014-03-25 15:17:56.142765	2014-03-25 15:17:56.144746
595	2	1757	1	1	0	0	0	2014-03-25 15:17:57.592019	2014-03-25 15:17:57.593869
556	2	760	1	1	0	0	0	2014-03-25 15:17:56.362709	2014-03-25 15:17:56.364161
512	2	1376	2	2	0	0	0	2014-03-25 15:17:55.464744	2014-03-25 15:17:59.17244
558	2	2107	1	1	0	0	0	2014-03-25 15:17:56.420745	2014-03-25 15:17:56.423191
532	2	1773	2	2	0	0	0	2014-03-25 15:17:55.81335	2014-03-25 15:17:59.427672
530	2	512	4	2	2	0	0	2014-03-25 15:17:55.785975	2014-03-25 15:18:24.009538
568	2	1204	2	2	0	0	0	2014-03-25 15:17:56.591584	2014-03-25 15:18:23.666216
557	2	1876	4	4	0	0	0	2014-03-25 15:17:56.405977	2014-03-25 15:18:23.298247
563	2	583	1	1	0	0	0	2014-03-25 15:17:56.511603	2014-03-25 15:17:56.513097
565	2	1844	1	1	0	0	0	2014-03-25 15:17:56.551755	2014-03-25 15:17:56.553259
567	2	1191	1	1	0	0	0	2014-03-25 15:17:56.566176	2014-03-25 15:17:56.568908
588	2	845	4	3	1	0	0	2014-03-25 15:17:57.209905	2014-03-25 15:18:24.871377
584	2	1756	1	1	0	0	0	2014-03-25 15:17:57.115342	2014-03-25 15:17:57.117779
549	2	511	6	5	1	0	0	2014-03-25 15:17:56.088314	2014-03-25 15:17:58.696697
569	2	1980	1	1	0	0	0	2014-03-25 15:17:56.654894	2014-03-25 15:17:56.657198
570	2	1512	1	1	0	0	0	2014-03-25 15:17:56.665841	2014-03-25 15:17:56.667343
571	2	401	1	1	0	0	0	2014-03-25 15:17:56.672649	2014-03-25 15:17:56.674214
510	2	1521	3	2	1	0	0	2014-03-25 15:17:55.42322	2014-03-25 15:18:23.730676
529	2	1535	6	6	0	0	0	2014-03-25 15:17:55.77938	2014-03-25 15:18:24.594354
508	2	857	3	2	1	0	0	2014-03-25 15:17:55.397928	2014-03-25 15:18:24.911796
547	2	1539	6	6	0	0	0	2014-03-25 15:17:56.067794	2014-03-25 15:17:59.152616
555	2	1383	5	5	0	0	0	2014-03-25 15:17:56.343325	2014-03-25 15:18:24.350729
545	2	766	2	2	0	0	0	2014-03-25 15:17:56.006099	2014-03-25 15:17:58.792212
576	2	1990	1	1	0	0	0	2014-03-25 15:17:56.997254	2014-03-25 15:17:56.999197
585	2	1366	1	1	0	0	0	2014-03-25 15:17:57.1307	2014-03-25 15:17:57.132693
541	2	1769	2	1	1	0	0	2014-03-25 15:17:55.942456	2014-03-25 15:17:59.503846
560	2	966	4	3	1	0	0	2014-03-25 15:17:56.443096	2014-03-25 15:18:25.249364
562	2	853	3	3	0	0	0	2014-03-25 15:17:56.476869	2014-03-25 15:17:58.06725
579	2	276	1	1	0	0	0	2014-03-25 15:17:57.040557	2014-03-25 15:17:57.041989
603	2	1467	2	2	0	0	0	2014-03-25 15:17:58.023398	2014-03-25 15:17:59.896891
544	2	647	6	1	5	0	0	2014-03-25 15:17:55.991101	2014-03-25 15:18:25.166676
589	2	1598	1	1	0	0	0	2014-03-25 15:17:57.223347	2014-03-25 15:17:57.224804
564	2	1899	4	4	0	0	0	2014-03-25 15:17:56.525598	2014-03-25 15:17:58.080484
587	2	1888	1	1	0	0	0	2014-03-25 15:17:57.171062	2014-03-25 15:17:57.173298
580	2	336	3	2	1	0	0	2014-03-25 15:17:57.065522	2014-03-25 15:17:58.865917
596	2	596	2	2	0	0	0	2014-03-25 15:17:57.610619	2014-03-25 15:17:58.235201
515	2	793	2	1	1	0	0	2014-03-25 15:17:55.542365	2014-03-25 15:18:24.641041
509	2	609	2	1	1	0	0	2014-03-25 15:17:55.416075	2014-03-25 15:17:57.252798
578	2	413	7	7	0	0	0	2014-03-25 15:17:57.026368	2014-03-25 15:18:24.709132
537	2	1384	15	15	0	0	0	2014-03-25 15:17:55.892611	2014-03-25 15:18:24.439028
592	2	2121	1	1	0	0	0	2014-03-25 15:17:57.497788	2014-03-25 15:17:57.499252
594	2	843	1	1	0	0	0	2014-03-25 15:17:57.572413	2014-03-25 15:17:57.574134
523	2	1964	2	2	0	0	0	2014-03-25 15:17:55.710833	2014-03-25 15:17:58.254346
597	2	1529	1	1	0	0	0	2014-03-25 15:17:57.618939	2014-03-25 15:17:57.62041
582	2	1451	3	3	0	0	0	2014-03-25 15:17:57.087723	2014-03-25 15:18:25.23551
572	2	1385	11	11	0	0	0	2014-03-25 15:17:56.69531	2014-03-25 15:18:24.850751
518	2	732	2	1	1	0	0	2014-03-25 15:17:55.578376	2014-03-25 15:17:57.661554
519	2	586	3	1	2	0	0	2014-03-25 15:17:55.624503	2014-03-25 15:18:23.280503
577	2	1112	3	3	0	0	0	2014-03-25 15:17:57.007749	2014-03-25 15:17:58.085544
601	2	965	1	1	0	0	0	2014-03-25 15:17:57.995484	2014-03-25 15:17:57.997119
513	2	264	5	4	1	0	0	2014-03-25 15:17:55.486427	2014-03-25 15:17:58.943418
602	2	1543	1	1	0	0	0	2014-03-25 15:17:58.009508	2014-03-25 15:17:58.011243
528	2	605	2	1	1	0	0	2014-03-25 15:17:55.770749	2014-03-25 15:18:23.266477
604	2	1464	1	1	0	0	0	2014-03-25 15:17:58.030146	2014-03-25 15:17:58.031548
598	2	1346	3	3	0	0	0	2014-03-25 15:17:57.638548	2014-03-25 15:17:59.090793
605	2	2000	1	1	0	0	0	2014-03-25 15:17:58.121502	2014-03-25 15:17:58.123268
593	2	2087	2	2	0	0	0	2014-03-25 15:17:57.503393	2014-03-25 15:17:58.127751
606	2	1975	1	1	0	0	0	2014-03-25 15:17:58.1416	2014-03-25 15:17:58.1436
511	2	365	2	2	0	0	0	2014-03-25 15:17:55.437101	2014-03-25 15:17:58.891161
607	2	1260	1	1	0	0	0	2014-03-25 15:17:58.179725	2014-03-25 15:17:58.181263
608	2	407	1	1	0	0	0	2014-03-25 15:17:58.225664	2014-03-25 15:17:58.227425
609	2	249	1	1	0	0	0	2014-03-25 15:17:58.275828	2014-03-25 15:17:58.278138
611	2	1654	1	0	1	0	0	2014-03-25 15:17:58.315679	2014-03-25 15:17:58.317135
612	2	278	1	1	0	0	0	2014-03-25 15:17:58.337253	2014-03-25 15:17:58.339557
704	3	1467	4	4	0	0	0	2014-03-25 15:18:00.290544	2014-03-25 15:18:11.074139
614	2	1453	1	1	0	0	0	2014-03-25 15:17:58.388753	2014-03-25 15:17:58.390835
634	2	1290	4	2	2	0	0	2014-03-25 15:17:58.950017	2014-03-25 15:18:24.812419
617	2	1397	1	1	0	0	0	2014-03-25 15:17:58.450937	2014-03-25 15:17:58.453152
618	2	314	1	1	0	0	0	2014-03-25 15:17:58.458787	2014-03-25 15:17:58.460504
619	2	332	1	1	0	0	0	2014-03-25 15:17:58.467968	2014-03-25 15:17:58.469631
620	2	1190	1	1	0	0	0	2014-03-25 15:17:58.659868	2014-03-25 15:17:58.661302
616	2	1185	6	5	1	0	0	2014-03-25 15:17:58.427265	2014-03-25 15:18:23.488024
651	2	1951	1	1	0	0	0	2014-03-25 15:17:59.286491	2014-03-25 15:17:59.287947
622	2	1206	1	1	0	0	0	2014-03-25 15:17:58.679326	2014-03-25 15:17:58.680704
652	2	366	1	1	0	0	0	2014-03-25 15:17:59.313597	2014-03-25 15:17:59.315968
624	2	379	3	3	0	0	0	2014-03-25 15:17:58.721476	2014-03-25 15:18:23.445073
653	2	14	1	1	0	0	0	2014-03-25 15:17:59.332183	2014-03-25 15:17:59.334571
623	2	269	2	2	0	0	0	2014-03-25 15:17:58.715917	2014-03-25 15:17:58.752096
662	2	1186	2	1	1	0	0	2014-03-25 15:17:59.842696	2014-03-25 15:18:23.617088
625	2	265	2	2	0	0	0	2014-03-25 15:17:58.728965	2014-03-25 15:17:58.759484
626	2	266	2	2	0	0	0	2014-03-25 15:17:58.736269	2014-03-25 15:17:58.764695
627	2	268	2	2	0	0	0	2014-03-25 15:17:58.743095	2014-03-25 15:17:58.769086
628	2	929	1	1	0	0	0	2014-03-25 15:17:58.773463	2014-03-25 15:17:58.774792
629	2	1222	1	1	0	0	0	2014-03-25 15:17:58.78204	2014-03-25 15:17:58.784953
654	2	1338	1	1	0	0	0	2014-03-25 15:17:59.340251	2014-03-25 15:17:59.342038
630	2	1977	2	2	0	0	0	2014-03-25 15:17:58.799858	2014-03-25 15:17:58.807862
631	2	1	1	1	0	0	0	2014-03-25 15:17:58.832253	2014-03-25 15:17:58.833789
632	2	746	1	1	0	0	0	2014-03-25 15:17:58.871593	2014-03-25 15:17:58.87309
633	2	611	1	1	0	0	0	2014-03-25 15:17:58.876942	2014-03-25 15:17:58.878562
621	2	1310	2	2	0	0	0	2014-03-25 15:17:58.665238	2014-03-25 15:18:23.481425
635	2	503	1	1	0	0	0	2014-03-25 15:17:58.969071	2014-03-25 15:17:58.971326
636	2	1537	1	1	0	0	0	2014-03-25 15:17:58.978317	2014-03-25 15:17:58.980329
637	2	1619	1	1	0	0	0	2014-03-25 15:17:58.998095	2014-03-25 15:17:58.999827
638	2	1708	1	1	0	0	0	2014-03-25 15:17:59.010391	2014-03-25 15:17:59.011996
639	2	846	1	1	0	0	0	2014-03-25 15:17:59.022942	2014-03-25 15:17:59.025129
640	2	1919	1	1	0	0	0	2014-03-25 15:17:59.032612	2014-03-25 15:17:59.034112
641	2	1946	1	0	1	0	0	2014-03-25 15:17:59.046387	2014-03-25 15:17:59.047855
642	2	644	1	1	0	0	0	2014-03-25 15:17:59.055298	2014-03-25 15:17:59.057323
643	2	1126	1	1	0	0	0	2014-03-25 15:17:59.083393	2014-03-25 15:17:59.084856
644	2	2124	1	1	0	0	0	2014-03-25 15:17:59.111567	2014-03-25 15:17:59.113736
646	2	642	1	0	1	0	0	2014-03-25 15:17:59.157477	2014-03-25 15:17:59.159107
647	2	840	1	0	1	0	0	2014-03-25 15:17:59.191398	2014-03-25 15:17:59.192733
648	2	1282	1	1	0	0	0	2014-03-25 15:17:59.221119	2014-03-25 15:17:59.22332
687	3	1702	24	23	1	0	0	2014-03-25 15:18:00.118749	2014-03-25 15:18:14.880839
645	2	722	2	1	1	0	0	2014-03-25 15:17:59.138401	2014-03-25 15:17:59.263417
656	2	1255	2	1	1	0	0	2014-03-25 15:17:59.381566	2014-03-25 15:18:25.161634
655	2	1540	1	1	0	0	0	2014-03-25 15:17:59.375956	2014-03-25 15:17:59.377418
613	2	1577	5	5	0	0	0	2014-03-25 15:17:58.357555	2014-03-25 15:18:25.172443
650	2	1573	2	2	0	0	0	2014-03-25 15:17:59.279792	2014-03-25 15:18:23.418226
658	2	1203	1	1	0	0	0	2014-03-25 15:17:59.439707	2014-03-25 15:17:59.441448
659	2	914	1	1	0	0	0	2014-03-25 15:17:59.460878	2014-03-25 15:17:59.462692
660	2	1879	1	1	0	0	0	2014-03-25 15:17:59.490841	2014-03-25 15:17:59.492293
661	2	1254	1	0	1	0	0	2014-03-25 15:17:59.519603	2014-03-25 15:17:59.521723
610	2	473	2	1	1	0	0	2014-03-25 15:17:58.285317	2014-03-25 15:18:23.652307
663	2	674	1	1	0	0	0	2014-03-25 15:17:59.853865	2014-03-25 15:17:59.855556
615	2	819	2	2	0	0	0	2014-03-25 15:17:58.397442	2014-03-25 15:17:59.864495
649	2	666	2	1	1	0	0	2014-03-25 15:17:59.255275	2014-03-25 15:17:59.876748
695	3	502	17	12	5	0	0	2014-03-25 15:18:00.202078	2014-03-25 15:18:14.570392
667	3	1271	2	2	0	0	0	2014-03-25 15:17:59.939188	2014-03-25 15:18:00.704415
674	3	432	49	22	27	0	0	2014-03-25 15:17:59.998965	2014-03-25 15:18:14.655859
699	3	1423	4	4	0	0	0	2014-03-25 15:18:00.24293	2014-03-25 15:18:12.43498
694	3	589	6	1	5	0	0	2014-03-25 15:18:00.1915	2014-03-25 15:18:11.225175
669	3	831	59	58	1	0	0	2014-03-25 15:17:59.955267	2014-03-25 15:18:14.86175
689	3	501	8	4	4	0	0	2014-03-25 15:18:00.135539	2014-03-25 15:18:10.843079
657	2	1221	2	2	0	0	0	2014-03-25 15:17:59.390915	2014-03-25 15:18:23.318501
700	3	855	7	6	1	0	0	2014-03-25 15:18:00.252121	2014-03-25 15:18:11.646742
698	3	1768	13	13	0	0	0	2014-03-25 15:18:00.233063	2014-03-25 15:18:13.019861
691	3	1962	3	3	0	0	0	2014-03-25 15:18:00.158161	2014-03-25 15:18:04.970362
676	3	979	29	26	3	0	0	2014-03-25 15:18:00.017192	2014-03-25 15:18:11.925729
670	3	567	23	23	0	0	0	2014-03-25 15:17:59.967717	2014-03-25 15:18:08.970746
688	3	544	3	1	2	0	0	2014-03-25 15:18:00.128422	2014-03-25 15:18:10.028002
668	3	1325	3	1	2	0	0	2014-03-25 15:17:59.94503	2014-03-25 15:18:08.50879
682	3	853	17	17	0	0	0	2014-03-25 15:18:00.067902	2014-03-25 15:18:14.120179
673	3	1874	66	65	1	0	0	2014-03-25 15:17:59.989388	2014-03-25 15:18:14.730262
706	3	591	13	11	2	0	0	2014-03-25 15:18:00.322514	2014-03-25 15:18:14.458607
678	3	2085	21	21	0	0	0	2014-03-25 15:18:00.033064	2014-03-25 15:18:09.609205
679	3	314	17	17	0	0	0	2014-03-25 15:18:00.042244	2014-03-25 15:18:09.029016
683	3	1873	20	19	1	0	0	2014-03-25 15:18:00.076236	2014-03-25 15:18:14.595204
686	3	228	3	0	3	0	0	2014-03-25 15:18:00.11093	2014-03-25 15:18:04.681038
675	3	1995	92	88	4	0	0	2014-03-25 15:18:00.009432	2014-03-25 15:18:14.84188
701	3	1916	42	40	2	0	0	2014-03-25 15:18:00.265126	2014-03-25 15:18:14.645478
690	3	548	8	2	6	0	0	2014-03-25 15:18:00.141862	2014-03-25 15:18:13.38644
665	3	1805	20	17	3	0	0	2014-03-25 15:17:59.922158	2014-03-25 15:18:14.431109
696	3	1782	33	28	5	0	0	2014-03-25 15:18:00.215674	2014-03-25 15:18:12.323379
664	3	1397	13	5	8	0	0	2014-03-25 15:17:59.916442	2014-03-25 15:18:09.07151
666	3	236	6	5	1	0	0	2014-03-25 15:17:59.929991	2014-03-25 15:18:14.790578
697	3	647	2	0	2	0	0	2014-03-25 15:18:00.225469	2014-03-25 15:18:01.099512
677	3	1476	23	23	0	0	0	2014-03-25 15:18:00.024063	2014-03-25 15:18:09.016233
684	3	1384	25	24	1	0	0	2014-03-25 15:18:00.084894	2014-03-25 15:18:13.639348
685	3	605	9	0	9	0	0	2014-03-25 15:18:00.102795	2014-03-25 15:18:09.075799
672	3	263	27	27	0	0	0	2014-03-25 15:17:59.980567	2014-03-25 15:18:13.33959
702	3	1475	2	2	0	0	0	2014-03-25 15:18:00.276528	2014-03-25 15:18:01.13668
703	3	1436	2	2	0	0	0	2014-03-25 15:18:00.284375	2014-03-25 15:18:01.141949
680	3	1088	11	0	11	0	0	2014-03-25 15:18:00.051105	2014-03-25 15:18:09.036562
705	3	1133	2	2	0	0	0	2014-03-25 15:18:00.299284	2014-03-25 15:18:01.152641
681	3	1655	21	18	3	0	0	2014-03-25 15:18:00.060383	2014-03-25 15:18:13.37244
693	3	555	6	5	1	0	0	2014-03-25 15:18:00.179419	2014-03-25 15:18:14.814027
692	3	1917	15	15	0	0	0	2014-03-25 15:18:00.167215	2014-03-25 15:18:14.697679
707	3	300	1	1	0	0	0	2014-03-25 15:18:00.332068	2014-03-25 15:18:00.33472
671	3	570	23	23	0	0	0	2014-03-25 15:17:59.973882	2014-03-25 15:18:08.974374
754	3	794	2	2	0	0	0	2014-03-25 15:18:01.854455	2014-03-25 15:18:14.003481
711	3	121	1	1	0	0	0	2014-03-25 15:18:00.509396	2014-03-25 15:18:00.511016
753	3	597	1	1	0	0	0	2014-03-25 15:18:01.843343	2014-03-25 15:18:01.84486
713	3	894	1	0	1	0	0	2014-03-25 15:18:00.584011	2014-03-25 15:18:00.586269
724	3	539	20	14	6	0	0	2014-03-25 15:18:01.185241	2014-03-25 15:18:14.042749
729	3	845	3	2	1	0	0	2014-03-25 15:18:01.233958	2014-03-25 15:18:08.472882
718	3	1535	4	3	1	0	0	2014-03-25 15:18:00.633001	2014-03-25 15:18:09.945495
773	3	503	1	1	0	0	0	2014-03-25 15:18:02.406905	2014-03-25 15:18:02.408424
717	3	512	3	3	0	0	0	2014-03-25 15:18:00.624877	2014-03-25 15:18:11.159324
720	3	1964	5	4	1	0	0	2014-03-25 15:18:00.664725	2014-03-25 15:18:13.272949
779	3	1883	5	5	0	0	0	2014-03-25 15:18:02.551069	2014-03-25 15:18:12.975179
762	3	442	3	3	0	0	0	2014-03-25 15:18:01.94016	2014-03-25 15:18:07.411415
725	3	1845	1	1	0	0	0	2014-03-25 15:18:01.194447	2014-03-25 15:18:01.196341
791	3	1146	3	1	2	0	0	2014-03-25 15:18:02.756648	2014-03-25 15:18:04.746622
755	3	1667	2	2	0	0	0	2014-03-25 15:18:01.861215	2014-03-25 15:18:04.742106
747	3	1991	2	1	1	0	0	2014-03-25 15:18:01.626613	2014-03-25 15:18:11.410831
768	3	991	8	0	8	0	0	2014-03-25 15:18:02.318783	2014-03-25 15:18:10.599461
749	3	1773	5	4	1	0	0	2014-03-25 15:18:01.789271	2014-03-25 15:18:14.688301
708	3	1385	10	10	0	0	0	2014-03-25 15:18:00.342183	2014-03-25 15:18:14.800498
763	3	730	21	6	15	0	0	2014-03-25 15:18:02.233255	2014-03-25 15:18:14.345192
782	3	1757	4	4	0	0	0	2014-03-25 15:18:02.623767	2014-03-25 15:18:13.547872
714	3	1232	3	3	0	0	0	2014-03-25 15:18:00.593856	2014-03-25 15:18:01.454811
748	3	380	2	2	0	0	0	2014-03-25 15:18:01.633234	2014-03-25 15:18:14.615883
807	3	410	5	5	0	0	0	2014-03-25 15:18:03.497248	2014-03-25 15:18:10.847681
789	3	1152	6	4	2	0	0	2014-03-25 15:18:02.7177	2014-03-25 15:18:12.502021
737	3	1453	1	1	0	0	0	2014-03-25 15:18:01.502018	2014-03-25 15:18:01.503474
738	3	1830	1	1	0	0	0	2014-03-25 15:18:01.509545	2014-03-25 15:18:01.510958
739	3	1233	1	1	0	0	0	2014-03-25 15:18:01.521787	2014-03-25 15:18:01.524199
740	3	682	1	0	1	0	0	2014-03-25 15:18:01.534443	2014-03-25 15:18:01.536466
771	3	1769	6	4	2	0	0	2014-03-25 15:18:02.391592	2014-03-25 15:18:14.261062
783	3	1529	4	3	1	0	0	2014-03-25 15:18:02.630609	2014-03-25 15:18:06.969523
772	3	511	4	2	2	0	0	2014-03-25 15:18:02.401041	2014-03-25 15:18:11.009484
743	3	1006	1	1	0	0	0	2014-03-25 15:18:01.572951	2014-03-25 15:18:01.574445
709	3	992	5	3	2	0	0	2014-03-25 15:18:00.349616	2014-03-25 15:18:14.406524
745	3	2146	1	1	0	0	0	2014-03-25 15:18:01.607035	2014-03-25 15:18:01.608544
736	3	373	24	9	15	0	0	2014-03-25 15:18:01.489272	2014-03-25 15:18:14.401911
777	3	930	11	3	8	0	0	2014-03-25 15:18:02.438384	2014-03-25 15:18:13.417175
744	3	964	3	0	3	0	0	2014-03-25 15:18:01.581406	2014-03-25 15:18:14.622764
726	3	1907	15	12	3	0	0	2014-03-25 15:18:01.201969	2014-03-25 15:18:12.956219
806	3	1186	2	2	0	0	0	2014-03-25 15:18:03.471136	2014-03-25 15:18:09.794827
751	3	1527	1	0	1	0	0	2014-03-25 15:18:01.810123	2014-03-25 15:18:01.811658
734	3	1278	2	2	0	0	0	2014-03-25 15:18:01.460064	2014-03-25 15:18:08.514115
784	3	978	7	5	2	0	0	2014-03-25 15:18:02.647892	2014-03-25 15:18:12.207142
722	3	542	2	1	1	0	0	2014-03-25 15:18:01.162437	2014-03-25 15:18:07.307515
786	3	1437	1	1	0	0	0	2014-03-25 15:18:02.665538	2014-03-25 15:18:02.667949
795	3	1877	6	6	0	0	0	2014-03-25 15:18:03.010654	2014-03-25 15:18:14.520764
760	3	965	1	0	1	0	0	2014-03-25 15:18:01.922694	2014-03-25 15:18:01.924086
715	3	1230	2	2	0	0	0	2014-03-25 15:18:00.601556	2014-03-25 15:18:07.376507
730	3	844	4	1	3	0	0	2014-03-25 15:18:01.24388	2014-03-25 15:18:09.303011
733	3	1465	15	10	5	0	0	2014-03-25 15:18:01.44793	2014-03-25 15:18:13.681059
765	3	1540	1	1	0	0	0	2014-03-25 15:18:02.252708	2014-03-25 15:18:02.254562
793	3	841	2	2	0	0	0	2014-03-25 15:18:02.900287	2014-03-25 15:18:06.524057
766	3	1861	1	0	1	0	0	2014-03-25 15:18:02.273127	2014-03-25 15:18:02.274817
778	3	1951	4	4	0	0	0	2014-03-25 15:18:02.54297	2014-03-25 15:18:14.107656
723	3	966	5	4	1	0	0	2014-03-25 15:18:01.174308	2014-03-25 15:18:11.21323
781	3	1189	6	4	2	0	0	2014-03-25 15:18:02.58142	2014-03-25 15:18:13.782842
735	3	1489	4	2	2	0	0	2014-03-25 15:18:01.477254	2014-03-25 15:18:13.012629
756	3	413	8	6	2	0	0	2014-03-25 15:18:01.885259	2014-03-25 15:18:14.426389
741	3	2034	4	1	3	0	0	2014-03-25 15:18:01.54356	2014-03-25 15:18:13.151733
746	3	1290	2	2	0	0	0	2014-03-25 15:18:01.61359	2014-03-25 15:18:14.367521
757	3	1460	6	5	1	0	0	2014-03-25 15:18:01.892044	2014-03-25 15:18:08.846445
800	3	1464	2	2	0	0	0	2014-03-25 15:18:03.09251	2014-03-25 15:18:06.957
752	3	1900	2	1	1	0	0	2014-03-25 15:18:01.832796	2014-03-25 15:18:13.998548
787	3	1301	5	5	0	0	0	2014-03-25 15:18:02.675619	2014-03-25 15:18:10.988499
805	3	472	3	3	0	0	0	2014-03-25 15:18:03.462767	2014-03-25 15:18:14.194708
758	3	1908	18	14	4	0	0	2014-03-25 15:18:01.90832	2014-03-25 15:18:14.807748
764	3	833	2	2	0	0	0	2014-03-25 15:18:02.243102	2014-03-25 15:18:08.27625
731	3	1379	2	2	0	0	0	2014-03-25 15:18:01.255683	2014-03-25 15:18:14.66612
716	3	1185	8	5	2	0	1	2014-03-25 15:18:00.608273	2014-03-25 15:18:12.823549
797	3	1910	4	2	2	0	0	2014-03-25 15:18:03.043668	2014-03-25 15:18:09.900056
790	3	1946	3	3	0	0	0	2014-03-25 15:18:02.742076	2014-03-25 15:18:13.622922
767	3	1745	2	1	1	0	0	2014-03-25 15:18:02.31128	2014-03-25 15:18:12.283115
759	3	262	2	1	1	0	0	2014-03-25 15:18:01.916737	2014-03-25 15:18:14.475238
780	3	376	3	3	0	0	0	2014-03-25 15:18:02.569707	2014-03-25 15:18:13.429305
796	3	1589	6	5	1	0	0	2014-03-25 15:18:03.029365	2014-03-25 15:18:14.201045
775	3	516	3	3	0	0	0	2014-03-25 15:18:02.421792	2014-03-25 15:18:13.589851
802	3	577	2	1	1	0	0	2014-03-25 15:18:03.364646	2014-03-25 15:18:07.896877
710	3	1662	15	12	3	0	0	2014-03-25 15:18:00.359191	2014-03-25 15:18:13.298559
732	3	1200	15	15	0	0	0	2014-03-25 15:18:01.429875	2014-03-25 15:18:12.988147
794	3	337	15	10	5	0	0	2014-03-25 15:18:02.974959	2014-03-25 15:18:12.404616
761	3	857	6	5	1	0	0	2014-03-25 15:18:01.929314	2014-03-25 15:18:13.987483
750	3	1875	36	34	2	0	0	2014-03-25 15:18:01.801598	2014-03-25 15:18:14.712437
788	3	1281	6	4	2	0	0	2014-03-25 15:18:02.684336	2014-03-25 15:18:13.204702
712	3	1377	14	13	1	0	0	2014-03-25 15:18:00.516767	2014-03-25 15:18:14.077336
798	3	1539	1	0	1	0	0	2014-03-25 15:18:03.054609	2014-03-25 15:18:03.055998
774	3	1151	4	2	2	0	0	2014-03-25 15:18:02.413224	2014-03-25 15:18:12.506154
799	3	1876	13	11	2	0	0	2014-03-25 15:18:03.086385	2014-03-25 15:18:14.760225
792	3	1879	7	7	0	0	0	2014-03-25 15:18:02.870937	2014-03-25 15:18:14.707354
801	3	1654	1	0	1	0	0	2014-03-25 15:18:03.354545	2014-03-25 15:18:03.356549
776	3	1521	6	6	0	0	0	2014-03-25 15:18:02.428871	2014-03-25 15:18:14.273998
803	3	1389	1	1	0	0	0	2014-03-25 15:18:03.396192	2014-03-25 15:18:03.39852
769	3	2036	9	5	4	0	0	2014-03-25 15:18:02.356884	2014-03-25 15:18:14.340189
804	3	645	1	1	0	0	0	2014-03-25 15:18:03.446351	2014-03-25 15:18:03.448456
719	3	1383	13	13	0	0	0	2014-03-25 15:18:00.644512	2014-03-25 15:18:13.285284
728	3	1282	4	2	2	0	0	2014-03-25 15:18:01.227037	2014-03-25 15:18:14.167733
721	3	500	6	4	2	0	0	2014-03-25 15:18:00.674354	2014-03-25 15:18:09.261549
742	3	2035	7	7	0	0	0	2014-03-25 15:18:01.551035	2014-03-25 15:18:13.704113
770	3	1947	7	4	3	0	0	2014-03-25 15:18:02.368491	2014-03-25 15:18:14.126808
808	3	1447	1	0	1	0	0	2014-03-25 15:18:03.538595	2014-03-25 15:18:03.540809
785	3	1999	3	2	1	0	0	2014-03-25 15:18:02.657871	2014-03-25 15:18:09.87686
727	3	558	2	0	2	0	0	2014-03-25 15:18:01.213598	2014-03-25 15:18:03.770799
889	3	1451	2	2	0	0	0	2014-03-25 15:18:07.025506	2014-03-25 15:18:12.015533
811	3	839	1	1	0	0	0	2014-03-25 15:18:03.744936	2014-03-25 15:18:03.746344
827	3	1386	2	1	1	0	0	2014-03-25 15:18:04.243478	2014-03-25 15:18:13.089997
829	3	1078	11	11	0	0	0	2014-03-25 15:18:04.340317	2014-03-25 15:18:12.104681
824	3	840	5	5	0	0	0	2014-03-25 15:18:04.174089	2014-03-25 15:18:14.724375
882	3	1714	2	2	0	0	0	2014-03-25 15:18:06.28729	2014-03-25 15:18:07.356182
813	3	174	4	4	0	0	0	2014-03-25 15:18:03.860544	2014-03-25 15:18:14.279461
818	3	1219	1	1	0	0	0	2014-03-25 15:18:04.110306	2014-03-25 15:18:04.1117
821	3	1406	4	4	0	0	0	2014-03-25 15:18:04.144673	2014-03-25 15:18:12.814236
822	3	1450	1	1	0	0	0	2014-03-25 15:18:04.151766	2014-03-25 15:18:04.153702
848	3	595	2	2	0	0	0	2014-03-25 15:18:05.145098	2014-03-25 15:18:11.150394
825	3	907	1	0	1	0	0	2014-03-25 15:18:04.215916	2014-03-25 15:18:04.21735
817	3	1019	2	0	2	0	0	2014-03-25 15:18:04.009358	2014-03-25 15:18:07.865799
862	3	1902	3	3	0	0	0	2014-03-25 15:18:05.771121	2014-03-25 15:18:13.236943
870	3	473	4	4	0	0	0	2014-03-25 15:18:06.009805	2014-03-25 15:18:10.049467
828	3	626	1	0	1	0	0	2014-03-25 15:18:04.265529	2014-03-25 15:18:04.267828
852	3	2132	1	1	0	0	0	2014-03-25 15:18:05.328015	2014-03-25 15:18:05.329524
878	3	613	3	1	2	0	0	2014-03-25 15:18:06.138797	2014-03-25 15:18:09.518982
815	3	1538	3	2	1	0	0	2014-03-25 15:18:03.93914	2014-03-25 15:18:09.691796
831	3	1989	1	1	0	0	0	2014-03-25 15:18:04.588802	2014-03-25 15:18:04.591566
832	3	1126	1	1	0	0	0	2014-03-25 15:18:04.611138	2014-03-25 15:18:04.612779
833	3	1496	1	1	0	0	0	2014-03-25 15:18:04.637031	2014-03-25 15:18:04.638579
898	3	1619	5	5	0	0	0	2014-03-25 15:18:07.335208	2014-03-25 15:18:14.420323
858	3	379	6	6	0	0	0	2014-03-25 15:18:05.706299	2014-03-25 15:18:14.371771
836	3	1363	1	1	0	0	0	2014-03-25 15:18:04.688512	2014-03-25 15:18:04.689915
838	3	423	1	1	0	0	0	2014-03-25 15:18:04.836981	2014-03-25 15:18:04.838469
900	3	1225	4	4	0	0	0	2014-03-25 15:18:07.388427	2014-03-25 15:18:10.808698
841	3	899	1	1	0	0	0	2014-03-25 15:18:04.934254	2014-03-25 15:18:04.93643
846	3	336	4	4	0	0	0	2014-03-25 15:18:05.008754	2014-03-25 15:18:12.541146
844	3	1577	1	1	0	0	0	2014-03-25 15:18:04.98396	2014-03-25 15:18:04.986181
845	3	1255	1	1	0	0	0	2014-03-25 15:18:04.996218	2014-03-25 15:18:04.998171
896	3	1983	1	1	0	0	0	2014-03-25 15:18:07.264299	2014-03-25 15:18:07.265843
843	3	1980	6	4	2	0	0	2014-03-25 15:18:04.975634	2014-03-25 15:18:14.499122
872	3	1950	4	3	1	0	0	2014-03-25 15:18:06.038311	2014-03-25 15:18:14.223824
816	3	2105	7	7	0	0	0	2014-03-25 15:18:03.968966	2014-03-25 15:18:13.749511
847	3	1888	1	1	0	0	0	2014-03-25 15:18:05.092272	2014-03-25 15:18:05.09368
890	3	598	2	1	1	0	0	2014-03-25 15:18:07.061116	2014-03-25 15:18:12.123695
814	3	2000	2	2	0	0	0	2014-03-25 15:18:03.877116	2014-03-25 15:18:11.334244
849	3	732	1	0	1	0	0	2014-03-25 15:18:05.220857	2014-03-25 15:18:05.223046
851	3	1472	1	1	0	0	0	2014-03-25 15:18:05.294927	2014-03-25 15:18:05.296418
856	3	1237	1	1	0	0	0	2014-03-25 15:18:05.411974	2014-03-25 15:18:05.414034
857	3	2041	1	1	0	0	0	2014-03-25 15:18:05.441402	2014-03-25 15:18:05.443185
873	3	1424	2	1	1	0	0	2014-03-25 15:18:06.047302	2014-03-25 15:18:08.301485
854	3	1899	2	2	0	0	0	2014-03-25 15:18:05.378082	2014-03-25 15:18:08.460511
850	3	1564	2	2	0	0	0	2014-03-25 15:18:05.287778	2014-03-25 15:18:05.721025
859	3	738	1	0	1	0	0	2014-03-25 15:18:05.725329	2014-03-25 15:18:05.726871
860	3	1187	1	1	0	0	0	2014-03-25 15:18:05.747977	2014-03-25 15:18:05.749814
861	3	1361	1	1	0	0	0	2014-03-25 15:18:05.760184	2014-03-25 15:18:05.762061
892	3	261	2	2	0	0	0	2014-03-25 15:18:07.097067	2014-03-25 15:18:11.67657
863	3	369	1	1	0	0	0	2014-03-25 15:18:05.812136	2014-03-25 15:18:05.813778
887	3	1558	1	1	0	0	0	2014-03-25 15:18:06.924804	2014-03-25 15:18:06.926437
840	3	896	2	1	1	0	0	2014-03-25 15:18:04.926935	2014-03-25 15:18:10.787765
877	3	1288	2	2	0	0	0	2014-03-25 15:18:06.129134	2014-03-25 15:18:08.235398
839	3	1588	2	2	0	0	0	2014-03-25 15:18:04.909415	2014-03-25 15:18:06.949026
867	3	1708	1	1	0	0	0	2014-03-25 15:18:05.941697	2014-03-25 15:18:05.943227
875	3	792	2	0	2	0	0	2014-03-25 15:18:06.077798	2014-03-25 15:18:13.631698
869	3	1036	1	1	0	0	0	2014-03-25 15:18:05.970211	2014-03-25 15:18:05.971682
866	3	1021	5	3	2	0	0	2014-03-25 15:18:05.876161	2014-03-25 15:18:14.834684
871	3	1302	1	1	0	0	0	2014-03-25 15:18:06.02547	2014-03-25 15:18:06.026886
893	3	44	1	0	1	0	0	2014-03-25 15:18:07.115188	2014-03-25 15:18:07.117233
820	3	402	2	2	0	0	0	2014-03-25 15:18:04.136311	2014-03-25 15:18:09.588942
874	3	1041	1	1	0	0	0	2014-03-25 15:18:06.056055	2014-03-25 15:18:06.057557
819	3	1204	3	2	1	0	0	2014-03-25 15:18:04.127991	2014-03-25 15:18:09.671598
879	3	1891	1	1	0	0	0	2014-03-25 15:18:06.228235	2014-03-25 15:18:06.229915
880	3	1517	1	1	0	0	0	2014-03-25 15:18:06.239888	2014-03-25 15:18:06.241984
881	3	377	1	1	0	0	0	2014-03-25 15:18:06.248493	2014-03-25 15:18:06.251303
837	3	1786	5	3	2	0	0	2014-03-25 15:18:04.735502	2014-03-25 15:18:14.44927
826	3	488	2	2	0	0	0	2014-03-25 15:18:04.23495	2014-03-25 15:18:07.829859
907	3	726	3	2	1	0	0	2014-03-25 15:18:07.623088	2014-03-25 15:18:14.132512
899	3	412	1	1	0	0	0	2014-03-25 15:18:07.380628	2014-03-25 15:18:07.382021
884	3	1618	1	1	0	0	0	2014-03-25 15:18:06.366819	2014-03-25 15:18:06.368711
885	3	2010	1	1	0	0	0	2014-03-25 15:18:06.414901	2014-03-25 15:18:06.416585
855	3	1747	2	2	0	0	0	2014-03-25 15:18:05.394557	2014-03-25 15:18:10.190417
835	3	1054	2	2	0	0	0	2014-03-25 15:18:04.664536	2014-03-25 15:18:06.579172
864	3	1292	2	2	0	0	0	2014-03-25 15:18:05.83451	2014-03-25 15:18:10.756894
876	3	1466	2	0	2	0	0	2014-03-25 15:18:06.091539	2014-03-25 15:18:09.96588
842	3	1937	3	2	1	0	0	2014-03-25 15:18:04.944752	2014-03-25 15:18:12.198651
891	3	1650	1	1	0	0	0	2014-03-25 15:18:07.073387	2014-03-25 15:18:07.075729
810	3	793	6	6	0	0	0	2014-03-25 15:18:03.729909	2014-03-25 15:18:14.857418
888	3	1621	2	2	0	0	0	2014-03-25 15:18:07.005955	2014-03-25 15:18:09.955197
894	3	1595	1	1	0	0	0	2014-03-25 15:18:07.222369	2014-03-25 15:18:07.224225
895	3	724	1	1	0	0	0	2014-03-25 15:18:07.242123	2014-03-25 15:18:07.243535
809	3	1737	2	2	0	0	0	2014-03-25 15:18:03.673825	2014-03-25 15:18:07.30197
897	3	1156	1	1	0	0	0	2014-03-25 15:18:07.320201	2014-03-25 15:18:07.321671
868	3	1593	3	3	0	0	0	2014-03-25 15:18:05.955342	2014-03-25 15:18:08.140558
823	3	1468	3	3	0	0	0	2014-03-25 15:18:04.159296	2014-03-25 15:18:10.005407
883	3	1756	2	2	0	0	0	2014-03-25 15:18:06.35575	2014-03-25 15:18:07.362696
830	3	892	4	4	0	0	0	2014-03-25 15:18:04.575705	2014-03-25 15:18:10.526803
901	3	269	1	1	0	0	0	2014-03-25 15:18:07.40317	2014-03-25 15:18:07.404643
905	3	1979	3	2	1	0	0	2014-03-25 15:18:07.527818	2014-03-25 15:18:14.054649
902	3	886	1	1	0	0	0	2014-03-25 15:18:07.433019	2014-03-25 15:18:07.434537
812	3	271	2	0	2	0	0	2014-03-25 15:18:03.760812	2014-03-25 15:18:13.026181
903	3	22	1	1	0	0	0	2014-03-25 15:18:07.46344	2014-03-25 15:18:07.465033
904	3	198	1	1	0	0	0	2014-03-25 15:18:07.519204	2014-03-25 15:18:07.520633
886	3	870	2	0	2	0	0	2014-03-25 15:18:06.559774	2014-03-25 15:18:10.147217
906	3	583	1	1	0	0	0	2014-03-25 15:18:07.566801	2014-03-25 15:18:07.568524
853	3	729	7	3	4	0	0	2014-03-25 15:18:05.364126	2014-03-25 15:18:12.357973
834	3	374	3	2	1	0	0	2014-03-25 15:18:04.655073	2014-03-25 15:18:07.639237
908	3	161	1	0	1	0	0	2014-03-25 15:18:07.667857	2014-03-25 15:18:07.67001
909	3	1704	1	0	1	0	0	2014-03-25 15:18:07.67634	2014-03-25 15:18:07.678247
865	3	881	2	1	1	0	0	2014-03-25 15:18:05.863258	2014-03-25 15:18:08.191064
911	3	81	1	1	0	0	0	2014-03-25 15:18:07.704991	2014-03-25 15:18:07.706716
912	3	984	1	0	1	0	0	2014-03-25 15:18:07.718353	2014-03-25 15:18:07.719813
914	3	1976	1	1	0	0	0	2014-03-25 15:18:07.734136	2014-03-25 15:18:07.735746
968	3	256	2	0	2	0	0	2014-03-25 15:18:10.116518	2014-03-25 15:18:14.140273
955	3	791	1	0	1	0	0	2014-03-25 15:18:09.720771	2014-03-25 15:18:09.722655
974	3	868	2	2	0	0	0	2014-03-25 15:18:10.508755	2014-03-25 15:18:10.590943
982	3	211	2	1	1	0	0	2014-03-25 15:18:10.795202	2014-03-25 15:18:14.558713
920	3	611	1	1	0	0	0	2014-03-25 15:18:08.088958	2014-03-25 15:18:08.090529
921	3	1590	1	1	0	0	0	2014-03-25 15:18:08.133917	2014-03-25 15:18:08.135659
922	3	854	1	1	0	0	0	2014-03-25 15:18:08.144718	2014-03-25 15:18:08.14616
1007	3	1746	3	1	2	0	0	2014-03-25 15:18:12.222354	2014-03-25 15:18:13.52788
926	3	1811	1	0	1	0	0	2014-03-25 15:18:08.264861	2014-03-25 15:18:08.266531
927	3	838	1	0	1	0	0	2014-03-25 15:18:08.30896	2014-03-25 15:18:08.310535
949	3	1906	2	2	0	0	0	2014-03-25 15:18:09.491613	2014-03-25 15:18:12.532829
929	3	216	1	1	0	0	0	2014-03-25 15:18:08.3436	2014-03-25 15:18:08.345206
930	3	2002	1	0	1	0	0	2014-03-25 15:18:08.362199	2014-03-25 15:18:08.363874
931	3	1239	1	1	0	0	0	2014-03-25 15:18:08.391669	2014-03-25 15:18:08.393289
932	3	1235	1	1	0	0	0	2014-03-25 15:18:08.398758	2014-03-25 15:18:08.400755
933	3	1238	1	1	0	0	0	2014-03-25 15:18:08.405477	2014-03-25 15:18:08.407049
981	3	1905	2	2	0	0	0	2014-03-25 15:18:10.729228	2014-03-25 15:18:12.059062
935	3	2004	1	1	0	0	0	2014-03-25 15:18:08.562709	2014-03-25 15:18:08.564259
936	3	1393	1	0	1	0	0	2014-03-25 15:18:08.60822	2014-03-25 15:18:08.609947
937	3	239	1	0	1	0	0	2014-03-25 15:18:08.632596	2014-03-25 15:18:08.635078
938	3	1404	1	1	0	0	0	2014-03-25 15:18:08.794626	2014-03-25 15:18:08.796126
957	3	641	1	1	0	0	0	2014-03-25 15:18:09.779519	2014-03-25 15:18:09.781331
940	3	1432	1	0	1	0	0	2014-03-25 15:18:08.858705	2014-03-25 15:18:08.860368
941	3	109	1	1	0	0	0	2014-03-25 15:18:08.870045	2014-03-25 15:18:08.872015
942	3	1259	1	0	1	0	0	2014-03-25 15:18:08.89257	2014-03-25 15:18:08.893945
943	3	2059	1	1	0	0	0	2014-03-25 15:18:09.285304	2014-03-25 15:18:09.286849
939	3	1462	2	1	1	0	0	2014-03-25 15:18:08.837767	2014-03-25 15:18:09.403252
946	3	1370	1	1	0	0	0	2014-03-25 15:18:09.453414	2014-03-25 15:18:09.454954
947	3	1195	1	0	1	0	0	2014-03-25 15:18:09.460477	2014-03-25 15:18:09.46208
948	3	815	1	1	0	0	0	2014-03-25 15:18:09.47306	2014-03-25 15:18:09.474472
985	3	1772	2	2	0	0	0	2014-03-25 15:18:10.864316	2014-03-25 15:18:12.561145
975	3	1537	2	2	0	0	0	2014-03-25 15:18:10.53126	2014-03-25 15:18:13.541871
919	3	1878	4	4	0	0	0	2014-03-25 15:18:07.85483	2014-03-25 15:18:11.432896
951	3	1911	1	0	1	0	0	2014-03-25 15:18:09.578645	2014-03-25 15:18:09.580087
916	3	1934	2	2	0	0	0	2014-03-25 15:18:07.820725	2014-03-25 15:18:09.596009
952	3	1581	1	1	0	0	0	2014-03-25 15:18:09.641356	2014-03-25 15:18:09.642741
953	3	1390	1	1	0	0	0	2014-03-25 15:18:09.650284	2014-03-25 15:18:09.653302
924	3	1609	2	2	0	0	0	2014-03-25 15:18:08.240576	2014-03-25 15:18:09.659668
954	3	13	1	1	0	0	0	2014-03-25 15:18:09.681896	2014-03-25 15:18:09.683649
958	3	1211	2	2	0	0	0	2014-03-25 15:18:09.806338	2014-03-25 15:18:09.817366
913	3	1901	4	4	0	0	0	2014-03-25 15:18:07.726005	2014-03-25 15:18:13.738714
960	3	1625	1	1	0	0	0	2014-03-25 15:18:09.88976	2014-03-25 15:18:09.891608
978	3	2012	1	0	1	0	0	2014-03-25 15:18:10.611774	2014-03-25 15:18:10.613331
962	3	1446	1	1	0	0	0	2014-03-25 15:18:09.959824	2014-03-25 15:18:09.96152
963	3	863	1	0	1	0	0	2014-03-25 15:18:09.979732	2014-03-25 15:18:09.981705
964	3	606	1	0	1	0	0	2014-03-25 15:18:10.014901	2014-03-25 15:18:10.017453
965	3	1720	1	1	0	0	0	2014-03-25 15:18:10.033906	2014-03-25 15:18:10.036446
934	3	1536	2	2	0	0	0	2014-03-25 15:18:08.553942	2014-03-25 15:18:12.009769
967	3	464	1	0	1	0	0	2014-03-25 15:18:10.090586	2014-03-25 15:18:10.092851
918	3	1276	2	1	1	0	0	2014-03-25 15:18:07.840997	2014-03-25 15:18:14.254242
917	3	1203	3	3	0	0	0	2014-03-25 15:18:07.835265	2014-03-25 15:18:14.239161
969	3	2123	1	0	1	0	0	2014-03-25 15:18:10.12791	2014-03-25 15:18:10.1294
970	3	1733	1	1	0	0	0	2014-03-25 15:18:10.184504	2014-03-25 15:18:10.185943
971	3	1357	1	1	0	0	0	2014-03-25 15:18:10.201921	2014-03-25 15:18:10.203861
915	3	382	2	0	2	0	0	2014-03-25 15:18:07.761363	2014-03-25 15:18:14.069511
972	3	414	1	0	1	0	0	2014-03-25 15:18:10.452598	2014-03-25 15:18:10.454185
973	3	1188	1	1	0	0	0	2014-03-25 15:18:10.460179	2014-03-25 15:18:10.461614
990	3	774	1	0	1	0	0	2014-03-25 15:18:11.098247	2014-03-25 15:18:11.099694
959	3	506	2	1	1	0	0	2014-03-25 15:18:09.837306	2014-03-25 15:18:13.57271
998	3	448	1	1	0	0	0	2014-03-25 15:18:11.69063	2014-03-25 15:18:11.693182
977	3	1440	1	1	0	0	0	2014-03-25 15:18:10.566293	2014-03-25 15:18:10.569055
993	3	264	2	2	0	0	0	2014-03-25 15:18:11.180996	2014-03-25 15:18:11.458462
980	3	1422	1	1	0	0	0	2014-03-25 15:18:10.673467	2014-03-25 15:18:10.675199
910	3	1543	4	4	0	0	0	2014-03-25 15:18:07.687477	2014-03-25 15:18:10.713151
997	3	586	2	2	0	0	0	2014-03-25 15:18:11.417081	2014-03-25 15:18:13.247398
956	3	1258	2	1	1	0	0	2014-03-25 15:18:09.757941	2014-03-25 15:18:14.68286
983	3	602	1	1	0	0	0	2014-03-25 15:18:10.813988	2014-03-25 15:18:10.815415
984	3	563	1	1	0	0	0	2014-03-25 15:18:10.822664	2014-03-25 15:18:10.824939
976	3	1396	3	3	0	0	0	2014-03-25 15:18:10.541584	2014-03-25 15:18:12.575687
986	3	752	1	1	0	0	0	2014-03-25 15:18:10.920895	2014-03-25 15:18:10.923359
987	3	1571	1	0	1	0	0	2014-03-25 15:18:10.972198	2014-03-25 15:18:10.97374
988	3	1463	1	1	0	0	0	2014-03-25 15:18:11.032409	2014-03-25 15:18:11.034382
991	3	557	1	1	0	0	0	2014-03-25 15:18:11.11259	2014-03-25 15:18:11.114557
992	3	1825	1	1	0	0	0	2014-03-25 15:18:11.126506	2014-03-25 15:18:11.128058
995	3	447	1	0	1	0	0	2014-03-25 15:18:11.283325	2014-03-25 15:18:11.284844
999	3	515	1	1	0	0	0	2014-03-25 15:18:11.699849	2014-03-25 15:18:11.701166
925	3	1832	2	1	1	0	0	2014-03-25 15:18:08.252627	2014-03-25 15:18:11.29672
989	3	1353	2	2	0	0	0	2014-03-25 15:18:11.040441	2014-03-25 15:18:11.313549
996	3	867	1	1	0	0	0	2014-03-25 15:18:11.342087	2014-03-25 15:18:11.343862
979	3	1400	2	0	2	0	0	2014-03-25 15:18:10.636885	2014-03-25 15:18:11.402332
923	3	982	4	4	0	0	0	2014-03-25 15:18:08.165568	2014-03-25 15:18:11.641156
944	3	1909	5	1	4	0	0	2014-03-25 15:18:09.378255	2014-03-25 15:18:12.582497
1000	3	556	1	1	0	0	0	2014-03-25 15:18:11.705776	2014-03-25 15:18:11.707218
1001	3	425	1	1	0	0	0	2014-03-25 15:18:11.736678	2014-03-25 15:18:11.738625
961	3	429	4	0	4	0	0	2014-03-25 15:18:09.906575	2014-03-25 15:18:12.861095
1002	3	1882	21	21	0	0	0	2014-03-25 15:18:11.764089	2014-03-25 15:18:11.895556
994	3	950	2	1	1	0	0	2014-03-25 15:18:11.204735	2014-03-25 15:18:11.940333
1003	3	1695	1	1	0	0	0	2014-03-25 15:18:11.995021	2014-03-25 15:18:11.99652
966	3	1471	2	2	0	0	0	2014-03-25 15:18:10.056115	2014-03-25 15:18:12.003522
1004	3	1690	1	1	0	0	0	2014-03-25 15:18:12.075777	2014-03-25 15:18:12.077223
1005	3	1977	1	1	0	0	0	2014-03-25 15:18:12.096531	2014-03-25 15:18:12.098218
1006	3	2049	1	1	0	0	0	2014-03-25 15:18:12.164819	2014-03-25 15:18:12.166578
928	3	549	2	0	2	0	0	2014-03-25 15:18:08.328649	2014-03-25 15:18:12.474376
1008	3	1582	1	1	0	0	0	2014-03-25 15:18:12.270348	2014-03-25 15:18:12.272204
1009	3	1522	1	1	0	0	0	2014-03-25 15:18:12.293012	2014-03-25 15:18:12.295164
945	3	365	2	0	2	0	0	2014-03-25 15:18:09.39529	2014-03-25 15:18:12.301231
1010	3	578	1	1	0	0	0	2014-03-25 15:18:12.313965	2014-03-25 15:18:12.31574
950	3	1512	2	1	1	0	0	2014-03-25 15:18:09.526166	2014-03-25 15:18:12.368974
1012	3	1614	1	0	1	0	0	2014-03-25 15:18:12.349311	2014-03-25 15:18:12.351201
1014	3	470	1	1	0	0	0	2014-03-25 15:18:12.462622	2014-03-25 15:18:12.464189
1015	3	1222	1	0	1	0	0	2014-03-25 15:18:12.480045	2014-03-25 15:18:12.481467
1016	3	1898	1	1	0	0	0	2014-03-25 15:18:12.525959	2014-03-25 15:18:12.527534
1017	3	493	1	1	0	0	0	2014-03-25 15:18:12.566214	2014-03-25 15:18:12.568531
1018	3	1774	1	1	0	0	0	2014-03-25 15:18:12.598965	2014-03-25 15:18:12.601218
1019	3	1482	1	1	0	0	0	2014-03-25 15:18:12.807986	2014-03-25 15:18:12.809523
1020	3	593	1	1	0	0	0	2014-03-25 15:18:12.84825	2014-03-25 15:18:12.850583
1021	3	385	1	1	0	0	0	2014-03-25 15:18:12.872723	2014-03-25 15:18:12.874179
1022	3	1884	2	2	0	0	0	2014-03-25 15:18:12.880602	2014-03-25 15:18:12.903203
1057	3	260	1	1	0	0	0	2014-03-25 15:18:14.411742	2014-03-25 15:18:14.414677
1024	3	2003	1	0	1	0	0	2014-03-25 15:18:12.927631	2014-03-25 15:18:12.929284
1025	3	10	1	1	0	0	0	2014-03-25 15:18:12.942891	2014-03-25 15:18:12.944748
1026	3	1706	1	1	0	0	0	2014-03-25 15:18:12.980741	2014-03-25 15:18:12.982072
1011	3	1216	2	0	2	0	0	2014-03-25 15:18:12.33823	2014-03-25 15:18:13.031952
1027	3	846	1	0	1	0	0	2014-03-25 15:18:13.078544	2014-03-25 15:18:13.079936
1028	3	661	1	1	0	0	0	2014-03-25 15:18:13.11216	2014-03-25 15:18:13.113756
1029	3	1112	1	1	0	0	0	2014-03-25 15:18:13.157182	2014-03-25 15:18:13.158614
1030	3	444	1	0	1	0	0	2014-03-25 15:18:13.164266	2014-03-25 15:18:13.165858
1023	3	513	2	0	2	0	0	2014-03-25 15:18:12.910502	2014-03-25 15:18:13.175024
1031	3	817	1	0	1	0	0	2014-03-25 15:18:13.181472	2014-03-25 15:18:13.183328
1032	3	1599	1	1	0	0	0	2014-03-25 15:18:13.219399	2014-03-25 15:18:13.221907
1033	3	25	1	1	0	0	0	2014-03-25 15:18:13.263894	2014-03-25 15:18:13.265849
1034	3	1938	1	1	0	0	0	2014-03-25 15:18:13.307386	2014-03-25 15:18:13.309454
1035	3	526	1	1	0	0	0	2014-03-25 15:18:13.32456	2014-03-25 15:18:13.326152
1037	3	525	1	0	1	0	0	2014-03-25 15:18:13.378985	2014-03-25 15:18:13.380408
1036	3	2054	2	0	2	0	0	2014-03-25 15:18:13.348841	2014-03-25 15:18:13.393559
1038	3	2023	1	0	1	0	0	2014-03-25 15:18:13.400005	2014-03-25 15:18:13.402075
1039	3	2032	1	0	1	0	0	2014-03-25 15:18:13.408004	2014-03-25 15:18:13.409626
1040	3	21	1	0	1	0	0	2014-03-25 15:18:13.422745	2014-03-25 15:18:13.424331
1041	3	541	1	1	0	0	0	2014-03-25 15:18:13.433554	2014-03-25 15:18:13.436123
1042	3	250	1	1	0	0	0	2014-03-25 15:18:13.48363	2014-03-25 15:18:13.485297
1043	3	84	1	1	0	0	0	2014-03-25 15:18:13.504889	2014-03-25 15:18:13.507588
1044	3	865	1	1	0	0	0	2014-03-25 15:18:13.533822	2014-03-25 15:18:13.536173
1045	3	1844	1	1	0	0	0	2014-03-25 15:18:13.614481	2014-03-25 15:18:13.616779
1046	3	1705	1	0	1	0	0	2014-03-25 15:18:13.69794	2014-03-25 15:18:13.699224
1047	3	818	1	1	0	0	0	2014-03-25 15:18:13.713337	2014-03-25 15:18:13.71503
1048	3	559	1	1	0	0	0	2014-03-25 15:18:14.009419	2014-03-25 15:18:14.011362
1049	3	1626	1	1	0	0	0	2014-03-25 15:18:14.083665	2014-03-25 15:18:14.085123
1083	4	1112	3	3	0	0	0	2014-03-25 15:18:15.189897	2014-03-25 15:18:20.58354
1051	3	255	1	1	0	0	0	2014-03-25 15:18:14.216651	2014-03-25 15:18:14.218488
1058	3	579	1	1	0	0	0	2014-03-25 15:18:14.436982	2014-03-25 15:18:14.43875
1053	3	91	2	2	0	0	0	2014-03-25 15:18:14.290882	2014-03-25 15:18:14.297934
1052	3	88	2	2	0	0	0	2014-03-25 15:18:14.285243	2014-03-25 15:18:14.303838
1054	3	95	1	1	0	0	0	2014-03-25 15:18:14.308958	2014-03-25 15:18:14.31064
1055	3	1514	1	1	0	0	0	2014-03-25 15:18:14.317058	2014-03-25 15:18:14.318958
1056	3	166	1	1	0	0	0	2014-03-25 15:18:14.378362	2014-03-25 15:18:14.379915
1059	3	1781	1	1	0	0	0	2014-03-25 15:18:14.463758	2014-03-25 15:18:14.465203
1060	3	2	1	1	0	0	0	2014-03-25 15:18:14.512538	2014-03-25 15:18:14.514557
1061	3	910	1	1	0	0	0	2014-03-25 15:18:14.535867	2014-03-25 15:18:14.537706
1062	3	2060	1	1	0	0	0	2014-03-25 15:18:14.603701	2014-03-25 15:18:14.605452
1063	3	276	1	1	0	0	0	2014-03-25 15:18:14.631824	2014-03-25 15:18:14.633829
1064	3	277	1	1	0	0	0	2014-03-25 15:18:14.638061	2014-03-25 15:18:14.639616
1065	3	1380	1	0	1	0	0	2014-03-25 15:18:14.674213	2014-03-25 15:18:14.676222
1066	3	932	1	1	0	0	0	2014-03-25 15:18:14.774039	2014-03-25 15:18:14.775613
1067	3	1629	1	1	0	0	0	2014-03-25 15:18:14.782183	2014-03-25 15:18:14.784027
1050	3	1371	2	1	1	0	0	2014-03-25 15:18:14.186046	2014-03-25 15:18:14.795436
1068	3	848	1	0	1	0	0	2014-03-25 15:18:14.820914	2014-03-25 15:18:14.822365
1069	3	1885	1	1	0	0	0	2014-03-25 15:18:14.847904	2014-03-25 15:18:14.849604
1070	3	1721	1	1	0	0	0	2014-03-25 15:18:14.868104	2014-03-25 15:18:14.869751
1071	3	1722	1	1	0	0	0	2014-03-25 15:18:14.874382	2014-03-25 15:18:14.875947
1013	3	422	2	2	0	0	0	2014-03-25 15:18:12.398184	2014-03-25 15:18:14.885664
1081	4	842	4	4	0	0	0	2014-03-25 15:18:15.163971	2014-03-25 15:18:20.570199
1075	4	1907	10	8	2	0	0	2014-03-25 15:18:14.91712	2014-03-25 15:18:21.359355
1077	4	249	1	1	0	0	0	2014-03-25 15:18:14.938864	2014-03-25 15:18:14.940262
1094	4	978	5	5	0	0	0	2014-03-25 15:18:15.295961	2014-03-25 15:18:20.68657
1092	4	1995	27	25	2	0	0	2014-03-25 15:18:15.275569	2014-03-25 15:18:21.527245
1080	4	930	5	1	4	0	0	2014-03-25 15:18:14.975237	2014-03-25 15:18:20.56422
1084	4	614	3	3	0	0	0	2014-03-25 15:18:15.195637	2014-03-25 15:18:20.59079
1085	4	555	3	0	3	0	0	2014-03-25 15:18:15.202854	2014-03-25 15:18:20.59997
1086	4	1980	6	4	2	0	0	2014-03-25 15:18:15.210323	2014-03-25 15:18:20.606226
1105	4	253	10	9	1	0	0	2014-03-25 15:18:15.420539	2014-03-25 15:18:21.462721
1101	4	502	9	4	5	0	0	2014-03-25 15:18:15.372319	2014-03-25 15:18:20.840192
1076	4	2108	25	12	13	0	0	2014-03-25 15:18:14.931622	2014-03-25 15:18:21.019029
1099	4	964	5	1	4	0	0	2014-03-25 15:18:15.351719	2014-03-25 15:18:20.742999
1082	4	1905	3	3	0	0	0	2014-03-25 15:18:15.18287	2014-03-25 15:18:20.577479
1091	4	2003	5	5	0	0	0	2014-03-25 15:18:15.265968	2014-03-25 15:18:20.659979
1102	4	1878	3	3	0	0	0	2014-03-25 15:18:15.389365	2014-03-25 15:18:20.957365
1096	4	1786	5	5	0	0	0	2014-03-25 15:18:15.327213	2014-03-25 15:18:20.715738
1107	4	1875	10	9	1	0	0	2014-03-25 15:18:15.441013	2014-03-25 15:18:21.494313
1078	4	432	13	12	1	0	0	2014-03-25 15:18:14.958287	2014-03-25 15:18:21.397015
1093	4	1641	3	3	0	0	0	2014-03-25 15:18:15.285698	2014-03-25 15:18:20.675917
1090	4	2063	3	3	0	0	0	2014-03-25 15:18:15.247131	2014-03-25 15:18:20.634184
1100	4	738	3	0	3	0	0	2014-03-25 15:18:15.361631	2014-03-25 15:18:20.748443
1089	4	516	4	1	3	0	0	2014-03-25 15:18:15.237349	2014-03-25 15:18:20.628541
1095	4	377	4	4	0	0	0	2014-03-25 15:18:15.305435	2014-03-25 15:18:21.477502
1087	4	501	13	11	2	0	0	2014-03-25 15:18:15.221553	2014-03-25 15:18:20.64351
1103	4	2036	12	7	5	0	0	2014-03-25 15:18:15.405739	2014-03-25 15:18:19.171753
1079	4	730	8	1	7	0	0	2014-03-25 15:18:14.96856	2014-03-25 15:18:20.780284
1088	4	2113	7	6	1	0	0	2014-03-25 15:18:15.228632	2014-03-25 15:18:20.652994
1097	4	1529	6	5	1	0	0	2014-03-25 15:18:15.335421	2014-03-25 15:18:20.724503
1104	4	2037	1	1	0	0	0	2014-03-25 15:18:15.412167	2014-03-25 15:18:15.413665
1098	4	634	3	3	0	0	0	2014-03-25 15:18:15.344636	2014-03-25 15:18:20.733802
1073	4	831	28	26	2	0	0	2014-03-25 15:18:14.903589	2014-03-25 15:18:21.301462
1072	4	1662	12	12	0	0	0	2014-03-25 15:18:14.893725	2014-03-25 15:18:20.833127
1108	4	236	2	1	1	0	0	2014-03-25 15:18:15.449181	2014-03-25 15:18:21.060551
1074	4	1874	22	20	2	0	0	2014-03-25 15:18:14.911042	2014-03-25 15:18:21.364905
1109	4	1492	1	1	0	0	0	2014-03-25 15:18:15.457398	2014-03-25 15:18:15.45871
1110	4	739	1	0	1	0	0	2014-03-25 15:18:15.466426	2014-03-25 15:18:15.468423
1106	4	648	3	0	0	0	3	2014-03-25 15:18:15.42718	2014-03-25 15:18:20.75602
1111	4	1383	5	5	0	0	0	2014-03-25 15:18:15.476726	2014-03-25 15:18:19.14381
1112	4	1650	1	0	1	0	0	2014-03-25 15:18:15.484825	2014-03-25 15:18:15.48628
1113	4	1480	1	0	1	0	0	2014-03-25 15:18:15.491027	2014-03-25 15:18:15.492459
1114	4	2023	1	0	1	0	0	2014-03-25 15:18:15.519692	2014-03-25 15:18:15.521253
1115	4	945	1	0	1	0	0	2014-03-25 15:18:15.532366	2014-03-25 15:18:15.534014
1116	4	1736	1	1	0	0	0	2014-03-25 15:18:15.541333	2014-03-25 15:18:15.542789
1142	4	1918	2	2	0	0	0	2014-03-25 15:18:15.896134	2014-03-25 15:18:20.021256
1139	4	1211	3	2	1	0	0	2014-03-25 15:18:15.864068	2014-03-25 15:18:19.334073
1123	4	1424	1	1	0	0	0	2014-03-25 15:18:15.65229	2014-03-25 15:18:15.653742
1124	4	1521	1	1	0	0	0	2014-03-25 15:18:15.661092	2014-03-25 15:18:15.66267
1126	4	1680	1	1	0	0	0	2014-03-25 15:18:15.677662	2014-03-25 15:18:15.679389
1127	4	2090	1	1	0	0	0	2014-03-25 15:18:15.693018	2014-03-25 15:18:15.694564
1128	4	1083	1	1	0	0	0	2014-03-25 15:18:15.702071	2014-03-25 15:18:15.703689
1158	4	413	4	1	3	0	0	2014-03-25 15:18:16.084439	2014-03-25 15:18:19.5185
1177	4	1999	1	1	0	0	0	2014-03-25 15:18:16.566284	2014-03-25 15:18:16.567821
1172	4	1151	2	1	1	0	0	2014-03-25 15:18:16.502697	2014-03-25 15:18:17.785806
1159	4	1325	1	0	1	0	0	2014-03-25 15:18:16.099551	2014-03-25 15:18:16.101284
1189	4	1669	2	2	0	0	0	2014-03-25 15:18:16.775816	2014-03-25 15:18:18.215348
1135	4	1976	1	1	0	0	0	2014-03-25 15:18:15.799863	2014-03-25 15:18:15.801916
1204	4	2048	3	2	1	0	0	2014-03-25 15:18:17.14156	2014-03-25 15:18:20.445653
1120	4	726	3	3	0	0	0	2014-03-25 15:18:15.608848	2014-03-25 15:18:19.01855
1138	4	735	1	1	0	0	0	2014-03-25 15:18:15.819611	2014-03-25 15:18:15.82112
1144	4	1445	2	2	0	0	0	2014-03-25 15:18:15.915346	2014-03-25 15:18:18.259299
1140	4	1381	1	1	0	0	0	2014-03-25 15:18:15.871367	2014-03-25 15:18:15.873168
1141	4	2056	1	1	0	0	0	2014-03-25 15:18:15.881598	2014-03-25 15:18:15.883107
1196	4	1384	6	5	1	0	0	2014-03-25 15:18:16.941592	2014-03-25 15:18:20.890858
1197	4	525	1	1	0	0	0	2014-03-25 15:18:16.966641	2014-03-25 15:18:16.96851
1143	4	966	3	2	1	0	0	2014-03-25 15:18:15.906782	2014-03-25 15:18:19.177945
1121	4	336	2	2	0	0	0	2014-03-25 15:18:15.6279	2014-03-25 15:18:19.594423
1178	4	1750	1	1	0	0	0	2014-03-25 15:18:16.579798	2014-03-25 15:18:16.58195
1148	4	1625	1	1	0	0	0	2014-03-25 15:18:15.95785	2014-03-25 15:18:15.95985
1117	4	2035	16	15	1	0	0	2014-03-25 15:18:15.554672	2014-03-25 15:18:21.441685
1150	4	1109	1	1	0	0	0	2014-03-25 15:18:15.978502	2014-03-25 15:18:15.980088
1151	4	1378	1	1	0	0	0	2014-03-25 15:18:15.998938	2014-03-25 15:18:16.000919
1152	4	1489	1	1	0	0	0	2014-03-25 15:18:16.005725	2014-03-25 15:18:16.00732
1191	4	1979	2	2	0	0	0	2014-03-25 15:18:16.804856	2014-03-25 15:18:17.082612
1145	4	991	4	0	4	0	0	2014-03-25 15:18:15.922155	2014-03-25 15:18:20.454228
1194	4	1465	3	3	0	0	0	2014-03-25 15:18:16.864145	2014-03-25 15:18:19.231902
1154	4	1377	9	5	4	0	0	2014-03-25 15:18:16.029842	2014-03-25 15:18:19.104828
1161	4	2010	1	0	1	0	0	2014-03-25 15:18:16.126483	2014-03-25 15:18:16.128833
1173	4	644	2	1	1	0	0	2014-03-25 15:18:16.513843	2014-03-25 15:18:17.578554
1163	4	264	1	1	0	0	0	2014-03-25 15:18:16.337932	2014-03-25 15:18:16.349002
1147	4	613	2	0	2	0	0	2014-03-25 15:18:15.944338	2014-03-25 15:18:17.101206
1165	4	1900	1	1	0	0	0	2014-03-25 15:18:16.366965	2014-03-25 15:18:16.368515
1166	4	1810	1	1	0	0	0	2014-03-25 15:18:16.375276	2014-03-25 15:18:16.376696
1153	4	1538	4	3	1	0	0	2014-03-25 15:18:16.021283	2014-03-25 15:18:18.416735
1168	4	845	1	1	0	0	0	2014-03-25 15:18:16.405391	2014-03-25 15:18:16.407959
1167	4	1400	2	0	2	0	0	2014-03-25 15:18:16.397209	2014-03-25 15:18:18.299453
1118	4	1873	4	3	1	0	0	2014-03-25 15:18:15.564414	2014-03-25 15:18:21.04011
1180	4	1234	1	1	0	0	0	2014-03-25 15:18:16.603563	2014-03-25 15:18:16.605831
1169	4	566	1	1	0	0	0	2014-03-25 15:18:16.447035	2014-03-25 15:18:16.448473
1137	4	1193	2	1	1	0	0	2014-03-25 15:18:15.812544	2014-03-25 15:18:18.947602
1202	4	1906	2	2	0	0	0	2014-03-25 15:18:17.116524	2014-03-25 15:18:19.074452
1164	4	2002	3	3	0	0	0	2014-03-25 15:18:16.3611	2014-03-25 15:18:17.966038
1171	4	894	1	0	1	0	0	2014-03-25 15:18:16.486701	2014-03-25 15:18:16.489044
1198	4	1702	3	3	0	0	0	2014-03-25 15:18:17.019296	2014-03-25 15:18:20.817105
1211	4	1902	2	2	0	0	0	2014-03-25 15:18:17.284691	2014-03-25 15:18:17.808435
1131	4	840	3	3	0	0	0	2014-03-25 15:18:15.764577	2014-03-25 15:18:17.821421
1125	4	1385	5	5	0	0	0	2014-03-25 15:18:15.667249	2014-03-25 15:18:18.810389
1181	4	512	1	1	0	0	0	2014-03-25 15:18:16.612629	2014-03-25 15:18:16.614373
1182	4	263	1	1	0	0	0	2014-03-25 15:18:16.651983	2014-03-25 15:18:16.653563
1179	4	442	3	2	1	0	0	2014-03-25 15:18:16.58909	2014-03-25 15:18:17.573856
1160	4	1146	2	0	2	0	0	2014-03-25 15:18:16.109114	2014-03-25 15:18:16.669706
1183	4	295	1	0	1	0	0	2014-03-25 15:18:16.675951	2014-03-25 15:18:16.677352
1184	4	1589	1	0	1	0	0	2014-03-25 15:18:16.682611	2014-03-25 15:18:16.684185
1155	4	379	4	3	1	0	0	2014-03-25 15:18:16.042831	2014-03-25 15:18:20.469208
1130	4	1908	10	6	4	0	0	2014-03-25 15:18:15.749396	2014-03-25 15:18:19.73636
1186	4	2054	1	0	1	0	0	2014-03-25 15:18:16.709054	2014-03-25 15:18:16.71059
1132	4	337	3	3	0	0	0	2014-03-25 15:18:15.772929	2014-03-25 15:18:16.73606
1149	4	598	2	1	1	0	0	2014-03-25 15:18:15.967769	2014-03-25 15:18:16.740698
1174	4	1879	7	6	1	0	0	2014-03-25 15:18:16.535533	2014-03-25 15:18:19.091034
1190	4	1951	6	6	0	0	0	2014-03-25 15:18:16.788742	2014-03-25 15:18:21.352407
1156	4	729	3	2	1	0	0	2014-03-25 15:18:16.064293	2014-03-25 15:18:21.316097
1192	4	1092	1	1	0	0	0	2014-03-25 15:18:16.829592	2014-03-25 15:18:16.831098
1146	4	647	5	1	4	0	0	2014-03-25 15:18:15.937507	2014-03-25 15:18:16.887676
1185	4	2059	2	0	2	0	0	2014-03-25 15:18:16.693623	2014-03-25 15:18:16.9004
1188	4	1882	3	2	1	0	0	2014-03-25 15:18:16.762776	2014-03-25 15:18:18.833355
1176	4	539	5	5	0	0	0	2014-03-25 15:18:16.554575	2014-03-25 15:18:20.855008
1193	4	1876	11	11	0	0	0	2014-03-25 15:18:16.838374	2014-03-25 15:18:21.46942
1136	4	1204	2	0	2	0	0	2014-03-25 15:18:15.806776	2014-03-25 15:18:19.340648
1199	4	1708	1	1	0	0	0	2014-03-25 15:18:17.025143	2014-03-25 15:18:17.026677
1200	4	844	1	1	0	0	0	2014-03-25 15:18:17.046966	2014-03-25 15:18:17.049117
1157	4	857	4	3	1	0	0	2014-03-25 15:18:16.075777	2014-03-25 15:18:20.429344
1201	4	151	1	1	0	0	0	2014-03-25 15:18:17.107886	2014-03-25 15:18:17.1098
1203	4	1571	1	1	0	0	0	2014-03-25 15:18:17.131224	2014-03-25 15:18:17.13334
1134	4	1916	24	23	1	0	0	2014-03-25 15:18:15.792032	2014-03-25 15:18:21.488762
1187	4	1288	2	2	0	0	0	2014-03-25 15:18:16.74917	2014-03-25 15:18:17.921401
1205	4	878	1	1	0	0	0	2014-03-25 15:18:17.157036	2014-03-25 15:18:17.159061
1195	4	1899	3	3	0	0	0	2014-03-25 15:18:16.915084	2014-03-25 15:18:21.332004
1206	4	1765	1	1	0	0	0	2014-03-25 15:18:17.201654	2014-03-25 15:18:17.203162
1122	4	1535	3	2	1	0	0	2014-03-25 15:18:15.64371	2014-03-25 15:18:18.189787
1207	4	244	1	1	0	0	0	2014-03-25 15:18:17.216954	2014-03-25 15:18:17.218702
1133	4	1460	5	5	0	0	0	2014-03-25 15:18:15.780979	2014-03-25 15:18:18.043072
1208	4	623	1	1	0	0	0	2014-03-25 15:18:17.23611	2014-03-25 15:18:17.238242
1209	4	500	1	1	0	0	0	2014-03-25 15:18:17.245246	2014-03-25 15:18:17.246959
1162	4	2041	2	0	2	0	0	2014-03-25 15:18:16.135523	2014-03-25 15:18:17.256365
1210	4	815	1	0	1	0	0	2014-03-25 15:18:17.267304	2014-03-25 15:18:17.26974
1129	4	548	2	0	2	0	0	2014-03-25 15:18:15.736588	2014-03-25 15:18:17.27692
1175	4	1917	5	5	0	0	0	2014-03-25 15:18:16.541311	2014-03-25 15:18:18.130973
1212	4	507	1	1	0	0	0	2014-03-25 15:18:17.294063	2014-03-25 15:18:17.295548
1119	4	2034	12	8	4	0	0	2014-03-25 15:18:15.583896	2014-03-25 15:18:21.414794
1170	4	1805	6	6	0	0	0	2014-03-25 15:18:16.455374	2014-03-25 15:18:20.990285
1285	4	846	2	2	0	0	0	2014-03-25 15:18:19.508224	2014-03-25 15:18:21.05403
1215	4	1222	1	1	0	0	0	2014-03-25 15:18:17.619523	2014-03-25 15:18:17.620928
1216	4	618	1	0	1	0	0	2014-03-25 15:18:17.633661	2014-03-25 15:18:17.636295
1217	4	429	1	0	1	0	0	2014-03-25 15:18:17.641803	2014-03-25 15:18:17.64343
1219	4	641	1	0	1	0	0	2014-03-25 15:18:17.68604	2014-03-25 15:18:17.687956
1220	4	508	1	0	1	0	0	2014-03-25 15:18:17.695505	2014-03-25 15:18:17.697532
1221	4	466	1	1	0	0	0	2014-03-25 15:18:17.703895	2014-03-25 15:18:17.705589
1222	4	1144	1	1	0	0	0	2014-03-25 15:18:17.721113	2014-03-25 15:18:17.722916
1247	4	1200	2	2	0	0	0	2014-03-25 15:18:18.318876	2014-03-25 15:18:20.828826
1225	4	688	1	1	0	0	0	2014-03-25 15:18:17.826059	2014-03-25 15:18:17.82745
1226	4	1186	1	1	0	0	0	2014-03-25 15:18:17.840922	2014-03-25 15:18:17.843408
1288	4	262	1	1	0	0	0	2014-03-25 15:18:19.562179	2014-03-25 15:18:19.564137
1228	4	369	1	0	1	0	0	2014-03-25 15:18:17.906754	2014-03-25 15:18:17.908747
1230	4	1964	1	0	1	0	0	2014-03-25 15:18:17.946659	2014-03-25 15:18:17.948661
1232	4	1909	1	0	1	0	0	2014-03-25 15:18:18.015086	2014-03-25 15:18:18.016529
1233	4	656	1	0	1	0	0	2014-03-25 15:18:18.024514	2014-03-25 15:18:18.026599
1279	4	1898	1	0	1	0	0	2014-03-25 15:18:19.263518	2014-03-25 15:18:19.265122
1235	4	1806	1	1	0	0	0	2014-03-25 15:18:18.056615	2014-03-25 15:18:18.058603
1236	4	1890	1	1	0	0	0	2014-03-25 15:18:18.085345	2014-03-25 15:18:18.087702
1289	4	503	1	1	0	0	0	2014-03-25 15:18:19.568954	2014-03-25 15:18:19.570525
1237	4	1552	1	1	0	0	0	2014-03-25 15:18:18.115911	2014-03-25 15:18:18.118117
1238	4	1534	1	0	1	0	0	2014-03-25 15:18:18.123633	2014-03-25 15:18:18.125111
1239	4	907	1	1	0	0	0	2014-03-25 15:18:18.146545	2014-03-25 15:18:18.14812
1231	4	1278	2	2	0	0	0	2014-03-25 15:18:18.008487	2014-03-25 15:18:18.154069
1258	4	1216	2	2	0	0	0	2014-03-25 15:18:18.523388	2014-03-25 15:18:19.286037
1301	4	992	3	3	0	0	0	2014-03-25 15:18:20.38054	2014-03-25 15:18:21.342969
1260	4	1156	1	0	1	0	0	2014-03-25 15:18:18.765102	2014-03-25 15:18:18.766833
1241	4	1213	2	2	0	0	0	2014-03-25 15:18:18.199909	2014-03-25 15:18:18.206209
1242	4	1670	1	1	0	0	0	2014-03-25 15:18:18.223651	2014-03-25 15:18:18.225827
1243	4	1513	1	0	1	0	0	2014-03-25 15:18:18.243616	2014-03-25 15:18:18.245271
1259	4	855	2	2	0	0	0	2014-03-25 15:18:18.743555	2014-03-25 15:18:18.784247
1234	4	1773	3	2	1	0	0	2014-03-25 15:18:18.047822	2014-03-25 15:18:19.319788
1245	4	635	1	0	1	0	0	2014-03-25 15:18:18.274366	2014-03-25 15:18:18.276359
1246	4	261	1	1	0	0	0	2014-03-25 15:18:18.282673	2014-03-25 15:18:18.284299
1249	4	546	1	0	1	0	0	2014-03-25 15:18:18.352043	2014-03-25 15:18:18.35417
1290	4	1368	1	1	0	0	0	2014-03-25 15:18:19.585157	2014-03-25 15:18:19.586819
1251	4	897	1	1	0	0	0	2014-03-25 15:18:18.390922	2014-03-25 15:18:18.392341
1291	4	579	1	1	0	0	0	2014-03-25 15:18:19.599615	2014-03-25 15:18:19.601808
1253	4	583	1	1	0	0	0	2014-03-25 15:18:18.422138	2014-03-25 15:18:18.423453
1254	4	426	1	0	1	0	0	2014-03-25 15:18:18.446227	2014-03-25 15:18:18.447829
1255	4	1220	1	1	0	0	0	2014-03-25 15:18:18.453151	2014-03-25 15:18:18.455209
1257	4	1189	1	1	0	0	0	2014-03-25 15:18:18.505184	2014-03-25 15:18:18.506733
1261	4	853	1	1	0	0	0	2014-03-25 15:18:18.792328	2014-03-25 15:18:18.794188
1218	4	1522	4	3	1	0	0	2014-03-25 15:18:17.6667	2014-03-25 15:18:18.801512
1250	4	979	2	2	0	0	0	2014-03-25 15:18:18.376711	2014-03-25 15:18:19.326925
1262	4	544	1	1	0	0	0	2014-03-25 15:18:18.841888	2014-03-25 15:18:18.843791
1263	4	2112	1	1	0	0	0	2014-03-25 15:18:18.854546	2014-03-25 15:18:18.856605
1264	4	577	1	1	0	0	0	2014-03-25 15:18:18.863451	2014-03-25 15:18:18.864811
1265	4	771	1	1	0	0	0	2014-03-25 15:18:18.886466	2014-03-25 15:18:18.887999
1295	4	372	1	1	0	0	0	2014-03-25 15:18:19.741679	2014-03-25 15:18:19.743636
1266	4	22	1	1	0	0	0	2014-03-25 15:18:18.912035	2014-03-25 15:18:18.913489
1268	4	240	1	0	1	0	0	2014-03-25 15:18:18.959257	2014-03-25 15:18:18.961357
1269	4	728	1	0	1	0	0	2014-03-25 15:18:18.969857	2014-03-25 15:18:18.971606
1271	4	1512	1	1	0	0	0	2014-03-25 15:18:19.008899	2014-03-25 15:18:19.010468
1270	4	1021	2	2	0	0	0	2014-03-25 15:18:19.002436	2014-03-25 15:18:19.023443
1280	4	1667	1	1	0	0	0	2014-03-25 15:18:19.363545	2014-03-25 15:18:19.365785
1223	4	1946	4	4	0	0	0	2014-03-25 15:18:17.75298	2014-03-25 15:18:19.060265
1229	4	1185	3	3	0	0	0	2014-03-25 15:18:17.927262	2014-03-25 15:18:19.086623
1272	4	1852	1	0	1	0	0	2014-03-25 15:18:19.119319	2014-03-25 15:18:19.120835
1273	4	1406	1	1	0	0	0	2014-03-25 15:18:19.125352	2014-03-25 15:18:19.126765
1274	4	1496	1	1	0	0	0	2014-03-25 15:18:19.1498	2014-03-25 15:18:19.151576
1292	4	1221	1	1	0	0	0	2014-03-25 15:18:19.634442	2014-03-25 15:18:19.637276
1276	4	1433	1	1	0	0	0	2014-03-25 15:18:19.196478	2014-03-25 15:18:19.198983
1277	4	7	1	0	1	0	0	2014-03-25 15:18:19.219595	2014-03-25 15:18:19.221984
1278	4	410	1	1	0	0	0	2014-03-25 15:18:19.245004	2014-03-25 15:18:19.246596
1281	4	1668	1	1	0	0	0	2014-03-25 15:18:19.372822	2014-03-25 15:18:19.374689
1256	4	965	2	1	1	0	0	2014-03-25 15:18:18.483987	2014-03-25 15:18:19.40244
1296	4	1191	1	0	1	0	0	2014-03-25 15:18:19.786968	2014-03-25 15:18:19.987136
1282	4	269	1	1	0	0	0	2014-03-25 15:18:19.429865	2014-03-25 15:18:19.431705
1248	4	1577	2	2	0	0	0	2014-03-25 15:18:18.339267	2014-03-25 15:18:19.439346
1283	4	870	1	0	1	0	0	2014-03-25 15:18:19.446927	2014-03-25 15:18:19.449246
1284	4	1624	1	1	0	0	0	2014-03-25 15:18:19.486719	2014-03-25 15:18:19.4884
1227	4	243	2	0	2	0	0	2014-03-25 15:18:17.863962	2014-03-25 15:18:19.501498
1286	4	1931	1	1	0	0	0	2014-03-25 15:18:19.524781	2014-03-25 15:18:19.526302
1275	4	838	2	1	1	0	0	2014-03-25 15:18:19.161439	2014-03-25 15:18:19.538063
1287	4	602	1	1	0	0	0	2014-03-25 15:18:19.549968	2014-03-25 15:18:19.551885
1293	4	27	1	1	0	0	0	2014-03-25 15:18:19.659357	2014-03-25 15:18:19.661271
1294	4	334	1	0	1	0	0	2014-03-25 15:18:19.672348	2014-03-25 15:18:19.674146
1213	4	1768	4	3	1	0	0	2014-03-25 15:18:17.343683	2014-03-25 15:18:19.688182
1299	4	591	1	1	0	0	0	2014-03-25 15:18:20.04998	2014-03-25 15:18:20.051771
1244	4	1947	4	1	3	0	0	2014-03-25 15:18:18.24995	2014-03-25 15:18:19.728281
1252	4	1152	3	2	1	0	0	2014-03-25 15:18:18.407137	2014-03-25 15:18:20.098435
1267	4	1655	3	3	0	0	0	2014-03-25 15:18:18.929223	2014-03-25 15:18:20.008386
1298	4	1431	1	1	0	0	0	2014-03-25 15:18:20.027041	2014-03-25 15:18:20.029016
1297	4	366	2	2	0	0	0	2014-03-25 15:18:20.0024	2014-03-25 15:18:20.034465
1300	4	1363	1	1	0	0	0	2014-03-25 15:18:20.361519	2014-03-25 15:18:20.36355
1302	4	506	1	0	1	0	0	2014-03-25 15:18:20.396499	2014-03-25 15:18:20.398352
1303	4	211	1	1	0	0	0	2014-03-25 15:18:20.410372	2014-03-25 15:18:20.41182
1304	4	1989	1	1	0	0	0	2014-03-25 15:18:20.42328	2014-03-25 15:18:20.424788
1305	4	376	1	1	0	0	0	2014-03-25 15:18:20.433451	2014-03-25 15:18:20.435111
1306	4	1744	1	1	0	0	0	2014-03-25 15:18:20.479782	2014-03-25 15:18:20.482351
1307	4	1547	1	0	1	0	0	2014-03-25 15:18:20.491121	2014-03-25 15:18:20.492758
1308	4	2060	1	1	0	0	0	2014-03-25 15:18:20.808886	2014-03-25 15:18:20.810438
1224	4	1672	2	2	0	0	0	2014-03-25 15:18:17.791574	2014-03-25 15:18:20.822648
1309	4	1455	1	1	0	0	0	2014-03-25 15:18:20.864707	2014-03-25 15:18:20.866407
1310	4	1747	1	1	0	0	0	2014-03-25 15:18:20.874772	2014-03-25 15:18:20.877164
1311	4	1963	1	1	0	0	0	2014-03-25 15:18:20.903645	2014-03-25 15:18:20.905307
1312	4	499	1	1	0	0	0	2014-03-25 15:18:20.995278	2014-03-25 15:18:20.996755
1214	4	1977	2	2	0	0	0	2014-03-25 15:18:17.611314	2014-03-25 15:18:21.030291
1313	4	654	1	1	0	0	0	2014-03-25 15:18:21.082555	2014-03-25 15:18:21.084655
1240	4	276	2	2	0	0	0	2014-03-25 15:18:18.165495	2014-03-25 15:18:21.310388
1314	4	1910	1	0	1	0	0	2014-03-25 15:18:21.277604	2014-03-25 15:18:21.288047
1315	4	401	1	1	0	0	0	2014-03-25 15:18:21.321701	2014-03-25 15:18:21.323248
1316	4	1891	1	1	0	0	0	2014-03-25 15:18:21.372971	2014-03-25 15:18:21.374805
1317	4	1588	1	0	1	0	0	2014-03-25 15:18:21.424072	2014-03-25 15:18:21.426519
1318	4	445	1	0	1	0	0	2014-03-25 15:18:21.451349	2014-03-25 15:18:21.453483
1319	4	1983	1	1	0	0	0	2014-03-25 15:18:21.499302	2014-03-25 15:18:21.501028
1320	1	1261	1	1	0	0	0	2014-03-25 15:18:21.533064	2014-03-25 15:18:21.535347
1322	1	2067	1	0	1	0	0	2014-03-25 15:18:21.59238	2014-03-25 15:18:21.59487
1323	1	1366	1	1	0	0	0	2014-03-25 15:18:21.60281	2014-03-25 15:18:21.605239
1324	1	2056	1	1	0	0	0	2014-03-25 15:18:21.620288	2014-03-25 15:18:21.622655
1325	1	1254	1	0	1	0	0	2014-03-25 15:18:21.637461	2014-03-25 15:18:21.639186
1326	1	457	1	1	0	0	0	2014-03-25 15:18:21.654743	2014-03-25 15:18:21.657085
1327	1	863	1	0	1	0	0	2014-03-25 15:18:21.719597	2014-03-25 15:18:21.721094
1328	1	1424	1	1	0	0	0	2014-03-25 15:18:21.730831	2014-03-25 15:18:21.732918
1329	1	1905	1	1	0	0	0	2014-03-25 15:18:21.794797	2014-03-25 15:18:21.797137
1330	1	1370	1	1	0	0	0	2014-03-25 15:18:21.878681	2014-03-25 15:18:21.88022
1331	1	1807	1	1	0	0	0	2014-03-25 15:18:21.892755	2014-03-25 15:18:21.894225
1332	1	2095	1	1	0	0	0	2014-03-25 15:18:21.902062	2014-03-25 15:18:21.903748
1333	1	563	1	0	1	0	0	2014-03-25 15:18:21.963071	2014-03-25 15:18:21.965496
1334	1	1749	1	1	0	0	0	2014-03-25 15:18:21.98759	2014-03-25 15:18:21.989958
1335	1	1402	1	1	0	0	0	2014-03-25 15:18:22.00925	2014-03-25 15:18:22.010769
1336	1	2147	1	0	1	0	0	2014-03-25 15:18:22.023924	2014-03-25 15:18:22.025608
1361	2	842	1	1	0	0	0	2014-03-25 15:18:23.55404	2014-03-25 15:18:23.555811
1338	1	407	1	0	1	0	0	2014-03-25 15:18:22.074708	2014-03-25 15:18:22.07718
1339	1	1442	1	1	0	0	0	2014-03-25 15:18:22.107882	2014-03-25 15:18:22.11014
1340	1	550	1	1	0	0	0	2014-03-25 15:18:22.118653	2014-03-25 15:18:22.120525
1341	1	1403	1	1	0	0	0	2014-03-25 15:18:22.178711	2014-03-25 15:18:22.181069
1342	1	1423	1	1	0	0	0	2014-03-25 15:18:22.210934	2014-03-25 15:18:22.212639
1343	1	1162	1	1	0	0	0	2014-03-25 15:18:22.268031	2014-03-25 15:18:22.270616
1344	1	1381	1	1	0	0	0	2014-03-25 15:18:22.378943	2014-03-25 15:18:22.380744
1321	1	503	2	1	1	0	0	2014-03-25 15:18:21.547895	2014-03-25 15:18:22.751709
1337	1	1299	3	3	0	0	0	2014-03-25 15:18:22.040409	2014-03-25 15:18:22.943982
1345	1	589	1	0	1	0	0	2014-03-25 15:18:22.974812	2014-03-25 15:18:22.976559
1346	1	833	1	1	0	0	0	2014-03-25 15:18:23.055362	2014-03-25 15:18:23.056826
1347	1	1900	1	1	0	0	0	2014-03-25 15:18:23.085732	2014-03-25 15:18:23.087236
1348	1	270	1	1	0	0	0	2014-03-25 15:18:23.13064	2014-03-25 15:18:23.132767
1349	1	775	1	1	0	0	0	2014-03-25 15:18:23.174175	2014-03-25 15:18:23.175724
1362	2	1389	1	1	0	0	0	2014-03-25 15:18:23.592691	2014-03-25 15:18:23.594097
1351	2	3	1	1	0	0	0	2014-03-25 15:18:23.244907	2014-03-25 15:18:23.247096
1350	2	2115	2	2	0	0	0	2014-03-25 15:18:23.227899	2014-03-25 15:18:23.257746
1352	2	1767	1	1	0	0	0	2014-03-25 15:18:23.304616	2014-03-25 15:18:23.306204
1353	2	894	1	1	0	0	0	2014-03-25 15:18:23.373317	2014-03-25 15:18:23.374826
1354	2	1583	1	1	0	0	0	2014-03-25 15:18:23.382457	2014-03-25 15:18:23.384379
1355	2	1188	1	1	0	0	0	2014-03-25 15:18:23.398846	2014-03-25 15:18:23.400424
1356	2	1408	1	1	0	0	0	2014-03-25 15:18:23.40845	2014-03-25 15:18:23.410842
1360	2	1641	2	1	1	0	0	2014-03-25 15:18:23.543206	2014-03-25 15:18:24.918034
1358	2	1301	1	1	0	0	0	2014-03-25 15:18:23.505604	2014-03-25 15:18:23.507982
1359	2	1538	1	1	0	0	0	2014-03-25 15:18:23.514591	2014-03-25 15:18:23.516086
1397	2	270	1	1	0	0	0	2014-03-25 15:18:25.309965	2014-03-25 15:18:25.311452
1363	2	1280	1	1	0	0	0	2014-03-25 15:18:23.607774	2014-03-25 15:18:23.609917
1364	2	626	1	0	1	0	0	2014-03-25 15:18:23.982383	2014-03-25 15:18:23.983857
1365	2	2039	1	1	0	0	0	2014-03-25 15:18:23.994343	2014-03-25 15:18:23.99572
1366	2	1035	1	1	0	0	0	2014-03-25 15:18:24.020795	2014-03-25 15:18:24.022791
1367	2	295	1	0	1	0	0	2014-03-25 15:18:24.207508	2014-03-25 15:18:24.209029
1368	2	1655	1	1	0	0	0	2014-03-25 15:18:24.245765	2014-03-25 15:18:24.247255
1369	2	236	1	1	0	0	0	2014-03-25 15:18:24.263562	2014-03-25 15:18:24.265397
1371	2	945	1	1	0	0	0	2014-03-25 15:18:24.295957	2014-03-25 15:18:24.29781
1383	2	1078	1	1	0	0	0	2014-03-25 15:18:24.558155	2014-03-25 15:18:24.559676
1373	2	2113	1	1	0	0	0	2014-03-25 15:18:24.312118	2014-03-25 15:18:24.313614
1374	2	1418	1	1	0	0	0	2014-03-25 15:18:24.328448	2014-03-25 15:18:24.329877
1375	2	1447	1	1	0	0	0	2014-03-25 15:18:24.341969	2014-03-25 15:18:24.344101
1376	2	1474	1	0	1	0	0	2014-03-25 15:18:24.357413	2014-03-25 15:18:24.359032
1377	2	1581	1	1	0	0	0	2014-03-25 15:18:24.383315	2014-03-25 15:18:24.384826
1378	2	1390	1	1	0	0	0	2014-03-25 15:18:24.390304	2014-03-25 15:18:24.39178
1379	2	1620	1	1	0	0	0	2014-03-25 15:18:24.396074	2014-03-25 15:18:24.39762
1380	2	617	1	0	1	0	0	2014-03-25 15:18:24.405857	2014-03-25 15:18:24.407291
1381	2	1262	3	2	1	0	0	2014-03-25 15:18:24.449582	2014-03-25 15:18:24.464776
1372	2	598	2	1	1	0	0	2014-03-25 15:18:24.304189	2014-03-25 15:18:24.48437
1382	2	841	1	1	0	0	0	2014-03-25 15:18:24.539401	2014-03-25 15:18:24.541865
1385	2	152	1	1	0	0	0	2014-03-25 15:18:24.659173	2014-03-25 15:18:24.661327
1386	2	1744	1	1	0	0	0	2014-03-25 15:18:24.668151	2014-03-25 15:18:24.669737
1387	2	1599	1	1	0	0	0	2014-03-25 15:18:24.687063	2014-03-25 15:18:24.689459
1388	2	1558	1	1	0	0	0	2014-03-25 15:18:24.731287	2014-03-25 15:18:24.733287
1389	2	1820	1	1	0	0	0	2014-03-25 15:18:24.742973	2014-03-25 15:18:24.744336
1390	2	546	1	1	0	0	0	2014-03-25 15:18:24.7488	2014-03-25 15:18:24.75024
1391	2	1906	1	1	0	0	0	2014-03-25 15:18:24.762511	2014-03-25 15:18:24.764116
1392	2	1492	1	1	0	0	0	2014-03-25 15:18:24.781264	2014-03-25 15:18:24.782812
1357	2	1161	2	2	0	0	0	2014-03-25 15:18:23.474369	2014-03-25 15:18:24.818899
1393	2	1372	1	1	0	0	0	2014-03-25 15:18:24.83155	2014-03-25 15:18:24.832965
1394	2	1565	1	1	0	0	0	2014-03-25 15:18:24.83886	2014-03-25 15:18:24.840486
1395	2	1968	1	1	0	0	0	2014-03-25 15:18:25.179267	2014-03-25 15:18:25.18083
1384	2	892	2	2	0	0	0	2014-03-25 15:18:24.58826	2014-03-25 15:18:25.23016
1396	2	1371	1	1	0	0	0	2014-03-25 15:18:25.296618	2014-03-25 15:18:25.298486
1370	2	1852	6	3	3	0	0	2014-03-25 15:18:24.272581	2014-03-25 15:18:25.30567
\.


--
-- Name: school_word_counts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('school_word_counts_id_seq', 1397, true);


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY schools (id, name, student_body_count, first_post_time, most_recent_post_time, geofeedia_id, post_count, positive_post_count, negative_post_count, neutral_post_count, mixed_post_count, created_at, updated_at) FROM stdin;
4	Michigan State University	47954	\N	\N	32207	3577	1845	971	761	0	2014-03-25 15:09:20.902222	2014-03-25 15:13:26.78777
2	University of Michigan, Ann Arbor	43426	\N	\N	32206	3896	1947	1222	727	0	2014-03-25 15:09:20.85809	2014-03-25 15:13:33.542645
3	University of Texas, Austin	38463	\N	\N	32211	8799	5014	1828	1957	0	2014-03-25 15:09:20.880321	2014-03-25 15:13:12.130671
1	Arizona State University	59794	\N	\N	32204	7891	4142	1865	1884	0	2014-03-25 15:09:20.781431	2014-03-25 15:13:30.153227
\.


--
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('schools_id_seq', 1, false);


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: andrewwittrock
--

COPY topics (id, name, created_at, updated_at) FROM stdin;
1	food	2014-03-25 15:09:12.140079	2014-03-25 15:09:12.140079
2	tech	2014-03-25 15:09:12.152722	2014-03-25 15:09:12.152722
3	nerd_culture	2014-03-25 15:09:12.155866	2014-03-25 15:09:12.155866
4	art	2014-03-25 15:09:12.158265	2014-03-25 15:09:12.158265
5	sports	2014-03-25 15:09:12.160624	2014-03-25 15:09:12.160624
6	partying	2014-03-25 15:09:12.163231	2014-03-25 15:09:12.163231
7	academics	2014-03-25 15:09:12.165998	2014-03-25 15:09:12.165998
8	romance	2014-03-25 15:09:12.168291	2014-03-25 15:09:12.168291
9	music	2014-03-25 15:09:12.170555	2014-03-25 15:09:12.170555
10	lgbt	2014-03-25 15:09:12.173668	2014-03-25 15:09:12.173668
11	fitness	2014-03-25 15:09:12.176355	2014-03-25 15:09:12.176355
12	social life	2014-03-25 15:09:12.178493	2014-03-25 15:09:12.178493
13	career	2014-03-25 15:09:12.181039	2014-03-25 15:09:12.181039
14	finance	2014-03-25 15:09:12.183425	2014-03-25 15:09:12.183425
15	gender	2014-03-25 15:09:12.185759	2014-03-25 15:09:12.185759
16	housing	2014-03-25 15:09:12.187929	2014-03-25 15:09:12.187929
17	politics	2014-03-25 15:09:12.19075	2014-03-25 15:09:12.19075
18	religion	2014-03-25 15:09:12.19332	2014-03-25 15:09:12.19332
19	fashion	2014-03-25 15:09:12.195831	2014-03-25 15:09:12.195831
\.


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewwittrock
--

SELECT pg_catalog.setval('topics_id_seq', 19, true);


--
-- Name: analyzed_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY analyzed_posts
    ADD CONSTRAINT analyzed_posts_pkey PRIMARY KEY (id);


--
-- Name: keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


--
-- Name: original_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY original_posts
    ADD CONSTRAINT original_posts_pkey PRIMARY KEY (id);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: reference_words_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY reference_words
    ADD CONSTRAINT reference_words_pkey PRIMARY KEY (id);


--
-- Name: school_word_counts_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY school_word_counts
    ADD CONSTRAINT school_word_counts_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: topics_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewwittrock; Tablespace: 
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: andrewwittrock; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: andrewwittrock
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM andrewwittrock;
GRANT ALL ON SCHEMA public TO andrewwittrock;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

