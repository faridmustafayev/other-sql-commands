CREATE TABLE authors
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128),
    last_name  VARCHAR(128),
    email      VARCHAR(256),
    created_at TIMESTAMP
);

CREATE TABLE posts
(
    id         BIGSERIAL PRIMARY KEY,
    title      VARCHAR(256),
    created_at TIMESTAMP,
    update_at  TIMESTAMP
);

ALTER TABLE authors
    ADD COLUMN about TEXT;

ALTER TABLE authors
    ADD COLUMN nick VARCHAR(128);

CREATE TABLE authors_posts
(
    id        BIGSERIAL PRIMARY KEY,
    author_id INTEGER REFERENCES authors (id),
    post_id   INTEGER REFERENCES posts (id)
);

ALTER TABLE authors
    ALTER COLUMN created_at SET DEFAULT now();

CREATE TABLE subscribes
(
    id    BIGSERIAL PRIMARY KEY,
    email VARCHAR(256)
);

ALTER TABLE authors
    ADD CONSTRAINT authors_nick_email_key UNIQUE (nick, email);

ALTER TABLE posts
    ADD COLUMN image_url TEXT;

CREATE TABLE tags
(
    id         BIGSERIAL PRIMARY KEY,
    tag        VARCHAR(256),
    created_at TIMESTAMP
);

CREATE INDEX idx_tag ON tags (tag);

CREATE TABLE posts_tags
(
    id      BIGSERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES posts (id),
    tag_id  INTEGER REFERENCES tags (id)
);

ALTER TABLE authors
    ADD COLUMN github VARCHAR(256);

ALTER TABLE authors
    ADD COLUMN update_at TIMESTAMP;

ALTER TABLE subscribes
    ADD CONSTRAINT email_key UNIQUE (email);

CREATE OR REPLACE VIEW authors_posts_view AS
SELECT a.nick, p.title, p.created_at
FROM authors a
         INNER JOIN posts p ON a.created_at = p.created_at;
