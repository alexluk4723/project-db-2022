CREATE SCHEMA compilations_db;

SET SEARCH_PATH = compilations_db;

-- Создаем таблицы

CREATE TABLE users(
    user_id serial PRIMARY KEY,
	user_name  VARCHAR(200) NOT NULL,
	nickname   VARCHAR(30)  NOT NULL UNIQUE,
	password   VARCHAR(30)  NOT NULL
);

CREATE TABLE tasks(
    task_id serial  PRIMARY KEY,
	problem     VARCHAR(200) NOT NULL,
	solution    TEXT NOT NULL UNIQUE,
	hint        TEXT,
	status      TEXT,
	date_start  DATE NOT NULL,
	date_end    DATE NOT NULL
);


CREATE TABLE theory(
    theory_id serial PRIMARY KEY,
	header       VARCHAR(200) NOT NULL,
	content      TEXT         NOT NULL
);


CREATE TABLE themes(
    theme_id serial PRIMARY KEY,
	shortname   VARCHAR(15) NOT NULL,
	theme_name  VARCHAR(30) NOT NULL
);


CREATE TABLE compilations(
    compilation_id serial PRIMARY KEY,
	header            VARCHAR(200) NOT NULL,
	description       TEXT
);

CREATE TABLE themes_of_tasks(
    theme_id INT REFERENCES themes(theme_id),
	task_id INT REFERENCES tasks(task_id),
	PRIMARY KEY(theme_id, task_id)
);

CREATE TABLE authors_of_tasks(
     user_id INT REFERENCES users(user_id),
	task_id INT REFERENCES tasks(task_id),
	PRIMARY KEY(user_id, task_id)
);

CREATE TABLE authors_of_compilations(
     user_id INT REFERENCES users(user_id),
	compilation_id INT REFERENCES compilations(compilation_id),
	PRIMARY KEY(user_id, compilation_id)
);

CREATE TABLE tasks_in_compilation(
     task_id INT REFERENCES tasks(task_id),
	compilation_id INT REFERENCES compilations(compilation_id),
	PRIMARY KEY(task_id, compilation_id)
);

CREATE TABLE theory_in_compilation(
     theory_id INT REFERENCES theory(theory_id),
	compilation_id INT REFERENCES compilations(compilation_id),
	PRIMARY KEY(theory_id, compilation_id)
);


CREATE TABLE themes_of_theory(
    theme_id INT REFERENCES themes(theme_id),
	theory_id INT REFERENCES theory(theory_id),
	PRIMARY KEY(theme_id, theory_id)
);


CREATE TABLE authors_of_theory(
     user_id INT REFERENCES users(user_id),
	theory_id INT REFERENCES theory(theory_id),
	PRIMARY KEY(user_id, theory_id)
);

CREATE TABLE grade_of_compilation(
     user_id            INT REFERENCES users(user_id),
	compilation_id  INT REFERENCES compilations(compilation_id),
	grade           INT CHECK(grade<11 AND grade>0),
	PRIMARY KEY(user_id, compilation_id)
);
