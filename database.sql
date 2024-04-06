--7. В подключенном MySQL репозитории создать базу данных “Друзья человека”


CREATE DATABASE human_friends; 
USE human_friends;


--8. Создать таблицы с иерархией из диаграммы в БД

CREATE TABLE animals(
	Id INT AUTO_INCREMENT PRIMARY KEY,  
	animal_class VARCHAR(20)
);

CREATE TABLE pets(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    pet_class VARCHAR (20),
    animal_id INT,
    FOREIGN KEY (animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE pack_animals(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    pack_animal_class VARCHAR (20),
    animal_id INT,
    FOREIGN KEY (animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
    

CREATE TABLE dogs(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pet_id int,
    Foreign KEY (pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cats(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pet_id int,
    Foreign KEY (pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hamsters(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pet_id int,
    Foreign KEY (pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horses(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pack_animal_id int,
    Foreign KEY (pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE camels(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pack_animal_id int,
    Foreign KEY (pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE donkeys(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(15), 
    birthday DATE,
    commands VARCHAR(100),
    pack_animal_id int,
    Foreign KEY (pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

--9. Заполнить низкоуровневые таблицы именами(животных), командами
которые они выполняют и датами рождени
INSERT INTO animals (animal_class) VALUES ('pets'),('pack animals'); 

INSERT INTO pets (pet_class, animal_id) VALUES ('Dog', 1),('Cat', 2),('Hamster', 3); 

INSERT INTO pack_animals (pack_animal_class, animal_id) VALUES ('Horse', 1), ('Camel', 2), ('Donkey', 3); 


INSERT INTO dogs (Name, birthday, commands, pet_id)
VALUES ('Бусинка', '2022-05-15', 'cидеть, лежать, голос', 1),

INSERT INTO cats (Name, birthday, commands, pet_id)
VALUES ('Рысь', '2022-09-04', 'Кс-Кс-Кс , брысь', 2),

INSERT INTO hamsters (Name, birthday, commands, pet_id)
VALUES ('Бомбер', '2024-03-17', NULL, 3),


INSERT INTO horses (Name, birthday, commands, pack_animal_id)
VALUES ('Плотва', '2012-01-01', 'шагом,галопом,стоп', 1),

INSERT INTO camels (Name, birthday, commands, pack_animal_id)
VALUES ('Кемаль', '2015-07-30', 'сесть,встать', 2),


INSERT INTO donkeys (Name, birthday, commands, pack_animal_id)
VALUES ('Осёл', '2022-01-17', 'сесть,встать', 3),

--10. Удаление верблюдов и объединение таблиц:

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

SELECT Name, birthday, commands FROM horses
UNION ALL SELECT  Name, birthday, commands FROM donkeys;

--11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице
CREATE TEMPORARY TABLE tmp_full AS
    SELECT *, 'Собаки' as class FROM dogs
    UNION SELECT *, 'Кошки' AS class FROM cats
    UNION SELECT *, 'Хомяки' AS class FROM hamsters
    UNION SELECT *, 'Лошади' AS class FROM horses
    UNION SELECT *, 'Ослы' AS class FROM donkeys;

CREATE TABLE young_animals AS
SELECT Name, birthday, commands, class, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS ages
FROM tmp_full WHERE birthday BETWEEN DATE_SUB(NOW(), INTERVAL 3 YEAR) AND DATE_SUB(NOW(), INTERVAL 1 YEAR);




--12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам
SELECT horses.name, horses.birthday, horses.commands, pack_animals.pack_animal_class, young_animal.ages
FROM horses
LEFT JOIN young_animals ON young_animals.Name = h.Name
LEFT JOIN pack_animals ON pack_animalsa.Id = h.pack_animal_id
UNION 
SELECT donkeys.Name, donkeys.birthday, donkeys.commands, pack_animals.pack_animal_class, young_animals.ages
FROM donkeys
LEFT JOIN young_animals ON young_animals.Name = donkeys.Name
LEFT JOIN pack_animals ON pack_animals.Id = donkeys.pack_animal_id
UNION
SELECT cat.Name, cat.birthday, cat.commands, pets.pet_class, young_animals.ages
FROM cats
LEFT JOIN young_animals  ON young_animals.Name = cat.Name
LEFT JOIN pets ON pets.Id = cat.Pet_id
UNION
SELECT dogs.Name, dogs.birthday, dogs.commands, dogs.pet_class, young_animals.ages
FROM dogs
LEFT JOIN young_animals  ON young_animals.Name = dogs.Name
LEFT JOIN pets ON pets.Id = dogs.pet_id
UNION
SELECT hamsters.Name, hamsters.birthday, hamsters.commands, pets.pet_class, young_animals.ages
FROM hamsters
LEFT JOIN young_animals ON young_animals.Name = hamsters.Name
LEFT JOIN pets ON pets.Id = hamsters.pet_id;