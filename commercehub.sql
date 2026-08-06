--
-- PostgreSQL database dump
--

\restrict xW0oCMgC4IhL1qaczvgp5VOEgqoyIaVtdYoekssnztk1wkCiF2e8OByracTdPbd

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: payment; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment AS ENUM (
    'PAYSTACK',
    'STRIPE'
);


ALTER TYPE public.payment OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: cart_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_item (
    id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT cart_item_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart_item OWNER TO postgres;

--
-- Name: cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_item_id_seq OWNER TO postgres;

--
-- Name: cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_item_id_seq OWNED BY public.cart_item.id;


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_item_id_seq OWNER TO postgres;

--
-- Name: order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_item_id_seq OWNED BY public.order_item.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    amount real,
    total integer,
    ref character varying(100),
    payment_method public.payment
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    price real NOT NULL,
    description text NOT NULL,
    image_url character varying
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: resetTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."resetTokens" (
    id integer NOT NULL,
    email character varying NOT NULL,
    token character varying NOT NULL,
    used boolean DEFAULT false NOT NULL,
    expiration timestamp without time zone
);


ALTER TABLE public."resetTokens" OWNER TO postgres;

--
-- Name: resetTokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."resetTokens_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."resetTokens_id_seq" OWNER TO postgres;

--
-- Name: resetTokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."resetTokens_id_seq" OWNED BY public."resetTokens".id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    user_id integer NOT NULL,
    content text NOT NULL,
    rating integer NOT NULL,
    product_id integer NOT NULL,
    date date NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    password character varying(200),
    email character varying(100) NOT NULL,
    fullname character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    google_id character varying(100),
    roles character varying(10)[] DEFAULT '{customer}'::character varying[] NOT NULL,
    address character varying(200),
    city character varying(100),
    state character varying(100),
    country character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: cart_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item ALTER COLUMN id SET DEFAULT nextval('public.cart_item_id_seq'::regclass);


--
-- Name: order_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item ALTER COLUMN id SET DEFAULT nextval('public.order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: resetTokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."resetTokens" ALTER COLUMN id SET DEFAULT nextval('public."resetTokens_id_seq"'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, user_id) FROM stdin;
1	1
2	2
\.


--
-- Data for Name: cart_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_item (id, cart_id, product_id, quantity) FROM stdin;
16	1	19	1
17	1	4	1
18	1	15	1
19	2	14	1
20	2	13	2
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item (id, order_id, product_id, quantity) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, status, date, amount, total, ref, payment_method) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, slug, price, description, image_url) FROM stdin;
1	Swiss Cheese	swiss-cheese	956.97	Swiss cheese is a mild cow's milk cheese with a firmer texture than baby Swiss. The flavor is light, sweet, and nutty. Swiss cheese is distinguished by its luster, pale yellow color, and large holes (called eyes) caused by carbon dioxide released during the maturation process.	https://i.ibb.co/N16wJ48/swiss-cheese.png
2	Pears	pears	759.19	Pears are rich in essential antioxidants, plant compounds, and dietary fiber. They pack all of these nutrients in a fat free, cholesterol free, 100 calorie package.	https://i.ibb.co/4fn5HJv/pear.png
3	Wasabi Paste	wasabi-paste	669.45	Wasabi paste is spicy and pungent in flavour and is most commonly served with sushi and sashimi.	https://i.ibb.co/TB3vQy2/Wasabi-Paste.jpg
4	Soup - Cambells Chicken	soup-cambells-chicken	707.1	You'll enjoy serving delicious, nutritious Campbells Chicken Noodle Soup to your children. Kids love Campbells Chicken Noodle Soup because it has bite-sized chicken, slurpable noodles, and a warm, savory broth. 12 cans weighing 10.75 oz each. Cans with a condensed flavor and an easy-to-open pop top. It's a quick and easy way to warm up mealtime for your kids at any time.	https://i.ibb.co/Vp9fw0F/campbell-chicken-soup.jpg
5	Triple Sec-Mcguinness	triple-sec-mcguinness	753.58	When mixed with your favorite cocktail, McGuinness Triple Sec becomes three times more delicious. The drink's name means "dry" in French, and "triple" implies three times as dry, so it's no surprise that people fall in love with this whisky flavor.	https://i.ibb.co/3TVtKHm/triple.jpg
6	Sage Ground	sage-ground	936.89	Sage is an excellent herb for seasoning fatty meats like pork, lamb, mutton, and game (goose or duck). It also complements onions, eggplant, tomatoes, and potatoes. Sage is frequently used in stuffings and cheeses.	https://i.ibb.co/B65SyN5/sage-ground.jpg
7	Beef Consomme	beef-consume	897.34	A sauce or soup base made from clarified meat stock (usually beef, veal, or poultry, but also fish) into a clear and flavorful liquid broth. Egg whites are used to clarify the meat stock as well as any additional ingredients such as vegetables and/or herbs. While the mixture is being brought to a boil, it is being stirred. The boiled solution is no longer stirred as the egg whites solidify on top of the mixture, allowing the fats and impurities to be absorbed or attached to the white.	https://i.ibb.co/Np4L8bs/beef-consomme.jpg
8	Sausage Chorizo	sausage-chorizo	782.82	Chorizo is a highly seasoned chopped or ground pork sausage that is commonly found in Spanish and Mexican cuisine. Mexican chorizo is made from fresh (raw, uncooked) pork, whereas Spanish chorizo is typically smoked.	https://i.ibb.co/hXsSSCt/Sausage-Chorizo.jpg
9	Apple Custard	apple-custard	802.23	Custard apples have delicious mellow flesh that is almost as soft as custard. Custard apples are thought to have originated in South America and the West Indies. These apples are usually heart or oval in shape and can weigh up to 450g. They have quilted skin that is light tan or greenish in color and turns brown as the fruit ripens.	https://i.ibb.co/ctRZSqC/sugar-apple-custard-apple-sharifa-1.jpg
10	Bacardi Breezer	bacardi-breezer	890.29	The Bacardi Breezer is an excellent way to enjoy the world's most popular rum â€“ Bacardi. Bacardi Breezer Cranberry is a refreshing drink made from Bacardi rum, real cranberry juice, and carbonated water.	https://i.ibb.co/4f81wgz/bacardi.png
11	Pita Bread	pita-bread	935.72	A versatile flat bread that is soft and slightly chewy on the inside and often has a pocket inside as a result of baking the bread in a hot oven. Pita bread is frequently mistakenly thought to be unleavened, but it is usually leavened with yeast. The bread can be eaten plain or with a drizzle of olive oil.	https://i.ibb.co/G21ZsqY/Original-Pita-Bread-Front-1200x1200.jpg
12	English Muffins	english-muffins	979.29	A small, round, yeast-leavened sourdough bread that is commonly sliced horizontally, toasted, and buttered. In North America and Australia, it is commonly eaten for breakfast, often with sweet or savory toppings such as fruit jam or honey, or eggs, sausage, bacon, or cheese.	https://i.ibb.co/B6pr46Z/muffins.png
13	Mince - Meat Filling	mince-meat-filling	611.56	Mincemeat is a combination of chopped dried fruit, distilled spirits, and spices, as well as occasionally beef suet, beef, or venison. Usually used as filling for mince pies during Christmas, but it tastes great mixed with vanilla ice cream, as well	https://i.ibb.co/mCMhF9N/meat-filling.jpg
14	Pate - Cognac	pate-cognac	787.14	PÃ¢tÃ© made with pork liver and meat that has been infused with cognac. The spirits complement the pÃ¢tÃ©'s rich, smooth flavor, which is sure to appeal to foodies.	https://i.ibb.co/8j9ghkk/Pate-Cognac.jpg
15	Lamb Shoulder (Boneless)	lamb-shoulder	605	Great for roasts, stews or any lamb recipe that has a marinade or a long slow cooking time and temperature.	https://i.ibb.co/h9Bm7nP/lamb-shoulder.png
16	Icecream - Dark Super Cone	icecream-dark-super-cone	867.05	Natural flavors, colors, and fragrances Contains no peanuts or nuts. 4 cones of French Vanilla ice cream and 4 cones of Dark Chocolate ice cream with a thick dark chocolate core These Super Cones are made with 100% Canadian dairy and are wrapped in dark chocolate sugar cones with a chocolate topping. A fantastic flavor offering in a great family package.\r\nDelectables for a single serving. Produced in a peanut and nut-free environment.	https://i.ibb.co/KXqcnsG/icecream.png
17	Puree Raspberry	puree-raspberry	717.68	Make the perfect summer sorbet to cool off in style! This 100% natural frozen puree is made of 90% fruit and 10% sugar, with no artificial flavors, colorings, or preservatives: simple, fresh, and delicious! Make sorbets, smoothies, ice creams, jellies and jams, sauces, and pastry fillings with this raspberry puree.	https://i.ibb.co/1LX9RMw/puree-raspberry.jpg
18	Black Currant Jelly	black-currant jelly	898.42	The natural flavor of the fruit is preserved by gently cooking in the French countryside tradition.\r\nSweetened only with vineyard ripened grape and fruit juices, 100 percent from fruit Authentic French Recipe, Gently cooked to preserve the natural flavor of the fruit, Gluten-Free, Only Natural Sugars, Non-Genetically Modified Ingredients, No Cane Sugars, Corn Syrups, Artificial Sweeteners, Colors, Flavors, or Preservatives, All Natural Ingredients	https://i.ibb.co/znrFfPt/jam.jpg
19	Rice - 7 Grain Blend	rice-7-grain-blend	732.36	Rice with a brown hue. Barley. Millet. Flax seed is a type of seed. Wheat. Quinoa in a red color. Rice from the wild. Microwave for 90 seconds in the pouch. USDA certified organic. 100% Whole Grain: 44 g or more per serving Consume 48 g or more of whole grains per day. You're only 90 seconds away from a nutritious side dish or a meal on its own. It's that easy!	https://i.ibb.co/Srv1Hjr/rice.png
20	Saskatoon Berries - Frozen	saskatoon-berries-frozen	606.2	Raw plant-based superfood jam-packed with nutrients to get you through the day! We can keep all of the benefits and flavors of fresh Saskatoon Berries by freeze drying them, making them an easy on-the-go treat! They're great as a healthy snack or added to cereals, smoothies, salads, and baking. A healthy diet high in vegetables and fruits may lower the risk of certain types of cancer.	https://i.ibb.co/ZcPjq1Y/berry.png
\.


--
-- Data for Name: resetTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."resetTokens" (id, email, token, used, expiration) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (user_id, content, rating, product_id, date, id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, password, email, fullname, username, google_id, roles, address, city, state, country, created_at) FROM stdin;
1	$2b$10$VQhzjohMkSWz5sPvMLfx6enQBZ4hiYmHEylCNRybDMHDzISeTWRP.	mansi687614@gmail.com	Mansi Patel	MansiCart	\N	{customer}	\N	\N	\N	\N	2026-08-05 23:08:31.376777
2	$2b$10$QsQ2tvkyc/ZT2O2aUVO1tuxyiuQCZgJ46VDVTJdbru79.rFcYsTUi	mansi.patel.23031@iitgoa.ac.in	Mansi Patel	MyCart	\N	{customer}	\N	\N	\N	\N	2026-08-06 12:16:02.586374
\.


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 2, true);


--
-- Name: cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_item_id_seq', 22, true);


--
-- Name: order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_item_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- Name: resetTokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."resetTokens_id_seq"', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 2, true);


--
-- Name: cart_item cart_item_cart_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_cart_id_product_id_key UNIQUE (cart_id, product_id);


--
-- Name: cart_item cart_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_pkey PRIMARY KEY (id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: cart cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_key UNIQUE (user_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: products products_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: products products_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_key UNIQUE (slug);


--
-- Name: resetTokens resetTokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."resetTokens"
    ADD CONSTRAINT "resetTokens_pkey" PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (user_id, product_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_google_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_google_id_key UNIQUE (google_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users_unique_lower_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_unique_lower_email_idx ON public.users USING btree (lower((email)::text));


--
-- Name: users_unique_lower_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_unique_lower_username_idx ON public.users USING btree (lower((username)::text));


--
-- Name: cart_item cart_item_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON DELETE CASCADE NOT VALID;


--
-- Name: cart_item cart_item_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE SET NULL NOT VALID;


--
-- Name: cart cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL NOT VALID;


--
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE NOT VALID;


--
-- Name: order_item order_item_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE SET NULL NOT VALID;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE NOT VALID;


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE SET NULL NOT VALID;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL NOT VALID;


--
-- PostgreSQL database dump complete
--

\unrestrict xW0oCMgC4IhL1qaczvgp5VOEgqoyIaVtdYoekssnztk1wkCiF2e8OByracTdPbd

