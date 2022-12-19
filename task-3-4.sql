-- DROP SCHEMA compilations_db CASCADE;

CREATE SCHEMA compilations_db;

SET SEARCH_PATH = compilations_db, public;

-- Создаем таблицы

CREATE TABLE users(
    user_id serial PRIMARY KEY,
	user_name  VARCHAR(200) NOT NULL,
	nickname   VARCHAR(30)  NOT NULL UNIQUE CHECK(nickname ~* '[A-Za-z0-9]{3,20}'),
	password   VARCHAR(30)  NOT NULL
);

CREATE TABLE tasks(
    task_id serial  PRIMARY KEY,
	problem     VARCHAR(200) NOT NULL,
	solution    TEXT         NOT NULL,
	hint        TEXT,
	status      TEXT,
	date_start  DATE         NOT NULL,
	date_end    DATE         NOT NULL
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

CREATE TABLE authors_of_compilation(
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
     user_id INT REFERENCES users(user_id),
	compilation_id INT REFERENCES compilations(compilation_id),
	grade INT CHECK(grade<11 AND grade>0),
	PRIMARY KEY(user_id, compilation_id)
);

-- Заполним таблицы

-- Пользователи
INSERT INTO users(user_name, nickname, password) VALUES ('Леонард Эйлер', 'euler', 'teorema');
INSERT INTO users(user_name, nickname, password) VALUES ('Григорий Перельман', 'perelman', 'puankare');
INSERT INTO users(user_name, nickname, password) VALUES ('Андрей Райгородский', 'raygorodski', 'formalist');
INSERT INTO users(user_name, nickname, password) VALUES ('Алексей Савватеев', 'savvateev', 'matkult-privet');
INSERT INTO users(user_name, nickname, password) VALUES ('Лосяш', 'smesharik', 'fenomenalno');

-- Задачи
INSERT INTO tasks(problem, solution, hint, date_start, date_end) VALUES ('2+2', '2+2=4', 'Сложите', '2020-01-01', '01.01.9999');
INSERT INTO tasks(problem, solution, hint, date_start, date_end) VALUES ('1*1', '1*1=1', 'Умножьте', '2021-02-02', '01.01.9999');
INSERT INTO tasks(problem, solution, hint, date_start, date_end) VALUES ('2+2*2', '2+2*2=6', 'Ловушка', '2020-01-01', '01.01.9999');
INSERT INTO tasks(problem, solution, date_start, date_end) VALUES ('2+2', '2+2=4', '2020-01-01', '01.01.9999');
INSERT INTO tasks(problem, solution, hint, date_start, date_end) VALUES ('2+2', '2+2=4', 'Сложите', '2020-01-01', '01.01.9999');

-- Темы
INSERT INTO themes(shortname, theme_name) VALUES ('num-theory', 'Теория чисел');
INSERT INTO themes(shortname, theme_name) VALUES ('graph', 'Теория  графов');
INSERT INTO themes(shortname, theme_name) VALUES ('geom', 'Геометрия');
INSERT INTO themes(shortname, theme_name) VALUES ('comb', 'Комбинаторика');
INSERT INTO themes(shortname, theme_name) VALUES ('complex', 'Комплексные числа');

-- Теория
INSERT INTO theory(header, content) VALUES ('Как складывать числа', 'вот так');
INSERT INTO theory(header, content) VALUES ('Деревья', 'В дереве на $n$ вершинах $n-1$ ребро');
INSERT INTO theory(header, content) VALUES ('Сочетания', '$\binom{n}{k}$');
INSERT INTO theory(header, content) VALUES ('Игры и стратегии', 'не попадите в проигрышную позицию;)');
INSERT INTO theory(header, content) VALUES ('Правильный треугольник', 'Все углы по 60');

-- Подборки
INSERT INTO compilations(header, description) VALUES ('Геометрия. Повторение', 'Повторение темы \textit{Треугольники}');
INSERT INTO compilations(header, description) VALUES ('Графы. Деревья', 'Основные понятия');
INSERT INTO compilations(header) VALUES ('Сочетания без повторений');
INSERT INTO compilations(header) VALUES ('Для самых маленьких');
INSERT INTO compilations(header) VALUES ('Задачи по ТЧ с финала ВСОШ');

-- Темы задач
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (1, 5);
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (1, 3);
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (2, 5);
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (4, 4);
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (1, 2);
INSERT INTO themes_of_tasks(theme_id, task_id) VALUES (1, 4);


-- Темы теории
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (1, 1);
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (2, 4);
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (3, 3);
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (4, 3);
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (5, 2);
INSERT INTO themes_of_theory(theme_id, theory_id) VALUES (2, 1);

-- Авторы задач
INSERT INTO authors_of_tasks(user_id, task_id) VALUES (1, 3);
INSERT INTO authors_of_tasks(user_id, task_id) VALUES (2, 1);
INSERT INTO authors_of_tasks(user_id, task_id) VALUES (3, 2);
INSERT INTO authors_of_tasks(user_id, task_id) VALUES (4, 1);
INSERT INTO authors_of_tasks(user_id, task_id) VALUES (5, 2);

-- Авторы подборки
INSERT INTO authors_of_compilation(user_id, compilation_id) VALUES (1, 4);
INSERT INTO authors_of_compilation(user_id, compilation_id) VALUES (2, 3);
INSERT INTO authors_of_compilation(user_id, compilation_id) VALUES (2, 2);
INSERT INTO authors_of_compilation(user_id, compilation_id) VALUES (3, 1);
INSERT INTO authors_of_compilation(user_id, compilation_id) VALUES (4, 1);

-- Задачи в подборке
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (5, 1);
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (4, 2);
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (3, 3);
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (2, 4);
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (1, 5);
INSERT INTO tasks_in_compilation(task_id, compilation_id) VALUES (1, 1);

-- Теория в подборке
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (5, 1);
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (1, 2);
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (5, 3);
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (4, 4);
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (3, 5);
INSERT INTO theory_in_compilation(theory_id, compilation_id) VALUES (2, 1);


-- Оценка подборки
INSERT INTO grade_of_compilation(user_id, compilation_id, grade) VALUES (1, 4, 5);
INSERT INTO grade_of_compilation(user_id, compilation_id, grade) VALUES (2, 4, 7);
INSERT INTO grade_of_compilation(user_id, compilation_id, grade) VALUES (3, 3, 8);
INSERT INTO grade_of_compilation(user_id, compilation_id, grade) VALUES (4, 2, 2);
INSERT INTO grade_of_compilation(user_id, compilation_id, grade) VALUES (5, 1, 9);
