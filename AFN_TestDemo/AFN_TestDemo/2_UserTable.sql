CREATE TABLE user_temp AS SELECT id, name, age, gender FROM tb_user WHERE 1 = 1;
DROP TABLE tb_user;
ALTER TABLE user_temp RENAME TO tb_user;
