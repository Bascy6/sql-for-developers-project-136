DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS modules;
DROP TABLE IF EXISTS programs;

CREATE TABLE courses (
    id bigint PRIMARY KEY,
    name varchar(255),
    description text,
    created_at timestamp,
    updated_at timestamp,
    is_deleted tinyint default 0
);

CREATE TABLE lessons (
    id bigint PRIMARY KEY,
    name varchar(255),
    content text,
    url_video varchar(255),
    position bigint,
    created_at timestamp,
    updated_at timestamp,
    course_id bigint REFERENCES courses (id),
    is_deleted tinyint default 0
);

CREATE TABLE modules (
    id bigint PRIMARY KEY,
    name varchar(255),
    description text,
    created_at timestamp,
    updated_at timestamp,
    is_deleted tinyint default 0
);

CREATE TABLE programs (
    id bigint PRIMARY KEY,
    name varchar(255),
    price int,
    type varchar(255),
    created_at timestamp,
    updated_at timestamp
);