DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS modules;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS teaching_groups;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS program_completions;
DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS discussions;
DROP TABLE IF EXISTS blogs;
DROP TABLE IF EXISTS program_modules;
DROP TABLE IF EXISTS course_modules;

CREATE TABLE courses (
    id bigint PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    deleted_at boolean default false NOT NULL
);

CREATE TABLE lessons (
    id bigint PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    content text NOT NULL,
    video_url varchar(255) NOT NULL,
    position bigint NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    course_id bigint REFERENCES courses (id) NOT NULL,
    deleted_at boolean default false NOT NULL
);

CREATE TABLE modules (
    id bigint PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    deleted_at boolean default false NOT NULL
);

CREATE TABLE programs (
    id bigint PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    price int NOT NULL,
    program_type varchar(255) NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE teaching_groups (
    id bigint PRIMARY KEY NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE users (
    id bigint PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    password_hash varchar(255) NOT NULL,
    teaching_group_id bigint REFERENCES teaching_groups (id) NOT NULL,
    role varchar(50) CHECK (role IN ('student', 'teacher', 'admin')) NOT NULL,
    deleted_at boolean default false NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE enrollments (
    id bigint PRIMARY KEY NOT NULL,
    user_id bigint REFERENCES users (id) NOT NULL,
    program_id bigint REFERENCES programs (id) NOT NULL,
    status varchar(50) CHECK
        (status IN ('active', 'pending', 'cancelled', 'completed')) NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE payments (
    id bigint PRIMARY KEY NOT NULL,
    enrollment_id bigint REFERENCES enrollments (id) NOT NULL,
    amount int NOT NULL,
    status varchar(50) CHECK
        (status IN ('pending', 'paid', 'failed', 'refunded')) NOT NULL,
    paid_at timestamp NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE program_completions (
    id bigint PRIMARY KEY NOT NULL,
    user_id bigint REFERENCES users (id) NOT NULL,
    program_id bigint REFERENCES programs (id) NOT NULL,
    status varchar(50) CHECK
        (status IN ('active', 'completed', 'pending', 'cancelled')) NOT NULL,
    started_at timestamp NOT NULL,
    completed_at timestamp NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE certificates (
    id bigint PRIMARY KEY NOT NULL,
    user_id bigint REFERENCES users (id) NOT NULL,
    program_id bigint REFERENCES programs (id) NOT NULL,
    url varchar(255) NOT NULL,
    issued_at timestamp NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE quizzes (
    id bigint PRIMARY KEY NOT NULL,
    lesson_id bigint REFERENCES lessons (id) NOT NULL,
    name varchar(255) NOT NULL,
    content text,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE exercises (
    id bigint PRIMARY KEY NOT NULL,
    lesson_id bigint REFERENCES lessons (id) NOT NULL,
    name varchar(255) NOT NULL,
    url varchar(255) NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE discussions (
    id bigint PRIMARY KEY NOT NULL,
    user_id bigint REFERENCES users (id) NOT NULL,
    lesson_id bigint REFERENCES lessons (id) NOT NULL,
    text text NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE blogs (
    id bigint PRIMARY KEY NOT NULL,
    user_id bigint REFERENCES users (id) NOT NULL,
    content text NOT NULL,
    name varchar(255) NOT NULL,
    status varchar(50) CHECK
        (status IN ('created', 'in moderation', 'published', 'archived')) NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE program_modules (
    module_id bigint REFERENCES modules (id) NOT NULL,
    program_id bigint REFERENCES programs (id) NOT NULL
);

CREATE TABLE course_modules (
    course_id bigint REFERENCES courses (id) NOT NULL,
    module_id bigint REFERENCES modules (id) NOT NULL
);