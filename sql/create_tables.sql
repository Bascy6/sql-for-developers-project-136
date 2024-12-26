CREATE TABLE Lessons (
    id bigint PRIMARY KEY,
    name varchar(255),
    content text,
    url_video varchar(255),
    position bigint,
    created_at timestamp,
    updated_at timestamp,
    url_course varchar(255)
);