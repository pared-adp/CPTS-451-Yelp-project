--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: business; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business (
    busi_id character(1) NOT NULL,
    name character varying(50),
    busi_stars numeric(3,2),
    busi_num_of_review integer,
    busi_avg_rating numeric(3,2),
    state character varying(20),
    city character varying(30)
);


ALTER TABLE public.business OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    cat_name character varying(50) NOT NULL,
    busi_id character(1)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: friend; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friend (
    friend_name character varying(50) NOT NULL,
    friend_stars numeric(3,2),
    friend_yelp_since date,
    user_id character(30)
);


ALTER TABLE public.friend OWNER TO postgres;

--
-- Name: overpriced; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.overpriced (
    over_name character varying(50) NOT NULL,
    over_price_range integer,
    over_num_of_checkin integer,
    zip_avg_income integer
);


ALTER TABLE public.overpriced OWNER TO postgres;

--
-- Name: popular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.popular (
    pop_name character varying(50) NOT NULL,
    pop_stars numeric(3,2),
    pop_review_rating numeric(3,2),
    pop_num_of_review integer,
    zip_avg_income integer
);


ALTER TABLE public.popular OWNER TO postgres;

--
-- Name: rates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rates (
    busi_id character(1) NOT NULL,
    user_id character(1) NOT NULL
);


ALTER TABLE public.rates OWNER TO postgres;

--
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    review_author character(1),
    review_id integer NOT NULL,
    review_contents character varying(200),
    review_date date,
    review_rating numeric(3,2)
);


ALTER TABLE public.review OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    friend_name character varying(50) NOT NULL,
    user_id character(1) NOT NULL,
    busi_id character(1) NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id character(20) NOT NULL,
    user_name character varying(50),
    user_stars numeric(3,2),
    user_yelp_since date,
    user_num_of_fans integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votes (
    votes_funny integer,
    votes_cool integer,
    votes_useful integer,
    user_id character(20),
    review_id integer
);


ALTER TABLE public.votes OWNER TO postgres;

--
-- Name: zipcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zipcode (
    zip_population integer,
    zip_avg_income integer NOT NULL,
    zip_total_num_of_busi integer,
    busi_id character(1)
);


ALTER TABLE public.zipcode OWNER TO postgres;

--
-- Data for Name: business; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business (busi_id, name, busi_stars, busi_num_of_review, busi_avg_rating, state, city) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (cat_name, busi_id) FROM stdin;
\.


--
-- Data for Name: friend; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friend (friend_name, friend_stars, friend_yelp_since, user_id) FROM stdin;
\.


--
-- Data for Name: overpriced; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.overpriced (over_name, over_price_range, over_num_of_checkin, zip_avg_income) FROM stdin;
\.


--
-- Data for Name: popular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.popular (pop_name, pop_stars, pop_review_rating, pop_num_of_review, zip_avg_income) FROM stdin;
\.


--
-- Data for Name: rates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rates (busi_id, user_id) FROM stdin;
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.review (review_author, review_id, review_contents, review_date, review_rating) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, friend_name, user_id, busi_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, user_stars, user_yelp_since, user_num_of_fans) FROM stdin;
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.votes (votes_funny, votes_cool, votes_useful, user_id, review_id) FROM stdin;
\.


--
-- Data for Name: zipcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zipcode (zip_population, zip_avg_income, zip_total_num_of_busi, busi_id) FROM stdin;
\.


--
-- Name: business business_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business
    ADD CONSTRAINT business_pkey PRIMARY KEY (busi_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (cat_name);


--
-- Name: friend friend_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_pkey PRIMARY KEY (friend_name);


--
-- Name: overpriced overpriced_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpriced
    ADD CONSTRAINT overpriced_pkey PRIMARY KEY (over_name);


--
-- Name: popular popular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular
    ADD CONSTRAINT popular_pkey PRIMARY KEY (pop_name);


--
-- Name: rates rates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_pkey PRIMARY KEY (busi_id, user_id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id, friend_name, user_id, busi_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: zipcode zipcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zipcode
    ADD CONSTRAINT zipcode_pkey PRIMARY KEY (zip_avg_income);


--
-- Name: category category_busi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_busi_id_fkey FOREIGN KEY (busi_id) REFERENCES public.business(busi_id);


--
-- Name: friend friend_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: overpriced overpriced_zip_avg_income_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpriced
    ADD CONSTRAINT overpriced_zip_avg_income_fkey FOREIGN KEY (zip_avg_income) REFERENCES public.zipcode(zip_avg_income);


--
-- Name: popular popular_zip_avg_income_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular
    ADD CONSTRAINT popular_zip_avg_income_fkey FOREIGN KEY (zip_avg_income) REFERENCES public.zipcode(zip_avg_income);


--
-- Name: rates rates_busi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_busi_id_fkey FOREIGN KEY (busi_id) REFERENCES public.business(busi_id);


--
-- Name: rates rates_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: reviews reviews_busi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_busi_id_fkey FOREIGN KEY (busi_id) REFERENCES public.business(busi_id);


--
-- Name: reviews reviews_friend_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_friend_name_fkey FOREIGN KEY (friend_name) REFERENCES public.friend(friend_name);


--
-- Name: reviews reviews_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.review(review_id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: votes votes_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.review(review_id);


--
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: zipcode zipcode_busi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zipcode
    ADD CONSTRAINT zipcode_busi_id_fkey FOREIGN KEY (busi_id) REFERENCES public.business(busi_id);


--
-- PostgreSQL database dump complete
--

