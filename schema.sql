CREATE TABLE  IF NOT EXISTS contacts (
	contact_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	phone TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS groups (
   group_id INTEGER PRIMARY KEY,
   name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS contact_groups(
   contact_id INTEGER,
   group_id INTEGER,
   PRIMARY KEY (contact_id, group_id),
   FOREIGN KEY (contact_id) 
      REFERENCES contacts (contact_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
   FOREIGN KEY (group_id) 
      REFERENCES groups (group_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);
INSERT OR IGNORE INTO contacts (contact_id, first_name, last_name, email, phone)
VALUES( '1', 'anonyme', 'noname', 'anonymous@email.fr', '+2653546434');
INSERT OR IGNORE INTO contacts (contact_id, first_name, last_name, email, phone)
VALUES( '2', 'anne onim', 'onim', 'anne.onim@email.com', '+86877779898');
create table if not exists user(
        id integer primary key autoincrement,
        username text,
            email text,
            password text,
            phone text,
            country-id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists language(
        id integer primary key autoincrement,
        name text,
            shortname text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists habitationhasvideo(
        id integer primary key autoincrement,
        video text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists userhaswaypoints(
        id integer primary key autoincrement,
        lat text,
            Lon text,
            placename text,
            city text,
            sea text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists waypointhasmeal(
        id integer primary key autoincrement,
        title text,
            content text,
            waypoint_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists mealhasuser(
        id integer primary key autoincrement,
        user_id text,
            meal_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists waypointhaspeopleyouknow(
        id integer primary key autoincrement,
        user_id text,
            waypoint_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists waypointhasforeignlanguage(
        id integer primary key autoincrement,
        user_id text,
            language_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists waypointhasconcert(
        id integer primary key autoincrement,
        waypoint_id text,
            title text,
            pic text,
            date text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists waypointhassocialmediapost(
        id integer primary key autoincrement,
        user_id text,
            title text,
            content text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists userhashabitation(
        id integer primary key autoincrement,
        user_id text,
            habitation_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
create table if not exists habitationhasjob(
        id integer primary key autoincrement,
        job_id text,
            user_id text,
            habitation_id text
      , created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP                );
-- ==========================================
-- 1. CRÉATION DES TABLES (DDL)
-- ==========================================

DROP TABLE IF EXISTS steps CASCADE;
DROP TABLE IF EXISTS social_queries CASCADE;
DROP TABLE IF EXISTS activities CASCADE;
DROP TABLE IF EXISTS housings CASCADE;
DROP TABLE IF EXISTS professions CASCADE;
DROP TABLE IF EXISTS teas CASCADE;
DROP TABLE IF EXISTS languages CASCADE;
DROP TABLE IF EXISTS cities CASCADE;

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    photo VARCHAR(255)
);

CREATE TABLE languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE
);

CREATE TABLE teas (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE
);

CREATE TABLE professions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    tasks TEXT
);

CREATE TABLE housings (
    id SERIAL PRIMARY KEY,
    housing_type VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    image VARCHAR(255),
    city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE,
    profession_id INTEGER REFERENCES professions(id) ON DELETE SET NULL
);

CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    activity_type VARCHAR(50),
    location_name VARCHAR(255),
    location_photo VARCHAR(255),
    practitioner_photo VARCHAR(255),
    housing_context TEXT,
    city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE
);

CREATE TABLE social_queries (
    id SERIAL PRIMARY KEY,
    prompt TEXT NOT NULL,
    category VARCHAR(255)
);

CREATE TABLE steps (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    social_query_id INTEGER REFERENCES social_queries(id) ON DELETE CASCADE
);


-- ==========================================
-- 2. INSERTION DES DONNÉES (DML)
-- ==========================================

-- Insertion des Villes (IDs 1 à 5)
INSERT INTO cities (id, name, country, photo) VALUES
(1, 'Rio de Janeiro', 'Brésil', 'assets/images/cities/rio.jpg'),
(2, 'Kyoto', 'Japon', 'assets/images/tea/kyoto_tea_house.jpg'),
(3, 'Londres', 'Royaume-Uni', 'assets/images/tea/london_afternoon_tea.jpg'),
(4, 'La Nouvelle-Orléans', 'États-Unis', 'assets/images/cities/new_orleans.jpg'),
(5, 'Nice', 'France', 'assets/images/housing/sea_apartment.jpg');

-- Insertion des Langues
INSERT INTO languages (name, city_id) VALUES
('Portugais', 1),
('Japonais', 2),
('Anglais', 3),
('Anglais', 4),
('Français', 5);

-- Insertion des Thés / Salons de thé
INSERT INTO teas (name, city_id) VALUES
('Maté / Thé glacé local', 1),
('Matcha / Sencha (Uji Tea House)', 2),
('Earl Grey / Afternoon Tea (The Ritz)', 3),
('Thé glacé du Sud', 4),
('Thé à la bergamote', 5);

-- Insertion des Professions (IDs 1 et 2)
INSERT INTO professions (id, name, tasks) VALUES
(1, 'Jardinier', 'Entretien du potager, Taille de haies'),
(2, 'Cuisinier', 'Préparation des repas, Gestion du garde-manger');

-- Insertion des Habitations
INSERT INTO housings (housing_type, category, image, city_id, profession_id) VALUES
('Appartement bord de mer', 'simple_sea_housing', 'assets/images/housing/sea_apartment.jpg', 5, NULL),
('Maison de maître avec jardin', 'spacious_workplace_housing', 'assets/images/housing/gardener_house.jpg', 2, 1),
('Villa avec grande cuisine professionnelle', 'spacious_workplace_housing', 'assets/images/housing/chef_house.jpg', 3, 2);

-- Insertion des Activités (Sport & Musique)
INSERT INTO activities (name, activity_type, location_name, location_photo, practitioner_photo, housing_context, city_id) VALUES
('Football', 'sport', 'Stade Maracanã / Terrain de favela', 'assets/images/sports/maracana.jpg', 'assets/images/sports/football_player.jpg', 'Logement précaire surplombant le terrain de sport', 1),
('Jazz / Trompette', 'music', 'Preservation Hall / Club de Jazz street', 'assets/images/music/preservation_hall.jpg', 'assets/images/music/jazz_band_performing.jpg', 'Habitation modeste à proximité des clubs de jazz historiques', 4);

-- Insertion des Requêtes Sociales (IDs 1 à 3)
INSERT INTO social_queries (id, prompt, category) VALUES
(1, 'How to give homeless people food to survive?', 'Social Action / Relief'),
(2, 'How to fulfill the dreams of dying children?', 'Humanitarian / Wish-Granting'),
(3, 'How to follow people career path after graduation?', 'Career Tracking / Alumni Networking');

-- Insertion des Étapes liées aux Requêtes Sociales
INSERT INTO steps (content, social_query_id) VALUES
-- Étapes pour la requête 1
('Contacter les banques alimentaires locales et associations (ex: Restos du Cœur, Croix-Rouge).', 1),
('Organiser des maraudes de distribution de repas chauds.', 1),
('Distribuer des kits de survie non périssables et de l''eau potable.', 1),
-- Étapes pour la requête 2
('Partenariat avec des fondations spécialisées (ex: Make-A-Wish Foundation, Petits Princes).', 2),
('Coordonner avec les équipes médicales pour s''assurer du confort et de la sécurité de l''enfant.', 2),
('Organiser des expériences sur-mesure (rencontre avec des idoles, voyages adaptés).', 2),
-- Étapes pour la requête 3
('Utiliser le réseau Alumni de l''université ou école.', 3),
('Suivre les parcours professionnels via LinkedIn (suivi d''évolution de poste).', 3),
('Mettre en place des enquêtes d''insertion professionnelle à 6 mois, 1 an et 3 ans.', 3);
