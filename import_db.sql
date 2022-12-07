PRAGMA foreign_keys = ON;


DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);


CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);   

INSERT INTO
    users (fname, lname)
VALUES  
    ('Brandon', 'Choi'),
    ('Kevin', 'Liu');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('NOT NULL?', 'Why do we need NOT NULL in sql?', (SELECT id FROM users WHERE (fname = 'Brandon' AND lname = 'Choi'))),
    ('Caps?', 'All sql in caps?', (SELECT id FROM users WHERE (fname = 'Kevin' AND lname = 'Liu')));

INSERT INTO
    replies (user_id, question_id, parent_reply_id, body)
VALUES  
    (1, 2, NULL,'can you clarify your question, Kevin?'), 
    (2, 2, 1, 'NO'),
    (1, 2, 2, 'I''m just trying to help..');