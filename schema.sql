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
