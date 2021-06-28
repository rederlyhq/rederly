--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Debian 12.6-1.pgdg100+1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SequelizeMeta" (name) FROM stdin;
20200917141653-grades-auditing-additions.js
20200924034242-student-overrides-setup.js
20200925034242-assessments-setup.js
20201026190412-attachments-setup.js
20201118202558-user-uuid.js
20201112094400-curriculum-assessments.js
20201216215621-paid-until.js
20210104113400-course-audit.js
20210105150502-workbook-problem-path.js
20210106191421-sma.js
20210125141500-bulk-export.js
20210218213139-description-and-feedback.js
20210408192059-auditing-feedback-fields.js
20210416174515-originating-course-id.js
20210504010450-retro-updates.js
20210505163542-topic-description-curricula.js
20210608181809-superadmin.js
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.permission (permission_id, permission_active, permission_role_name, permission_description, permission_name, created_at, updated_at) FROM stdin;
0	t	student	worker bee	drone	2020-08-23 14:37:08.137809+00	2020-08-23 14:37:08.137809+00
1	t	professor	student commander	instructor	2020-08-23 14:37:08.137809+00	2020-08-23 14:37:08.137809+00
2	t	admin	the big cheese	mr manager	2020-08-23 14:37:08.137809+00	2020-08-23 14:37:08.137809+00
3	t	superadmin	A Rederly administrator that can modify all universities.	superadmin	2021-06-28 00:47:46.771+00	2021-06-28 00:47:46.771+00
\.


--
-- Data for Name: topic_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.topic_type (topic_type_id, topic_type_active, topic_type_name, created_at, updated_at) FROM stdin;
1	t	homework assignment	2020-08-23 14:37:08.137809+00	2020-08-23 14:37:08.137809+00
2	t	test	2020-08-23 14:37:08.137809+00	2020-08-23 14:37:08.137809+00
\.


--
-- Name: permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permission_permission_id_seq', 1, false);


--
-- Name: topic_type_topic_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.topic_type_topic_type_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

