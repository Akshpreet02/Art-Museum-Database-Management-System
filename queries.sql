USE MUSEUM;

-- 1) Show all tables and explain how they are related to one another (keys, triggers, etc.)
SHOW TABLES;
-- TABLES & KEYS:
--
-- The tables present in the relational schema are ART_OBJECT, PAINTING, STATUE, SCULPTURE, OTHER, PERMANENT COLLECTION, BORROWED, 
-- COLLECTIONS, EXHIBITIONS, ARTIST, IN_COLLECTION, ON_DISPLAY
--
-- The table ART_OBJECT has primary id_no used to uniquely identify each art object in the database. It contains the following other attributes: the origin of the 
-- art object (Origin), title of the art object (title), Epoch, a short description of the art object (Description), and the Year it was made (Year).
--
-- The table PAINTING has the foreign key id_no that points to ART_OBJECT. It contains the following other attributes about paintings present in the database:
-- paint_type which is the type of painting, Drawn_on which is the year/date the painting was drawn, and the style of painting.
--
-- The table SCULPTURE has the foreign key id_no that points to ART_OBJECT, It contains the following other attributes about sculptures present in the database
-- Material, Height, Weight, and Style. 
--
-- The table STATUE has the foreign key id_no that points to ART_OBJECT. It contains the following other attributes about statues present in the database
-- Material, Height, Weight, and Style.
-- 
-- The table OTHER has the foreign key id_no that points to ART_OBJECT. It contains informaiton about other types of art objects in the database
-- such as photos and prints. It contains the following other attributes to describe these art objects: type, style. 
--
-- The table COLLECTIONS contains the primary key NAME which is the name of the art collection in a museum or otherwise. It also contains the following other attributes 
-- Phone (Phone number of the museum hosting the art collection or other institution), Contact.person (the person to contact in the museum hosting the collection),
-- Street.address (the street address of where the collection is being hosted), City (the city in which the collection exists), Country (country in which the collection exists), 
-- Postal_code, Type (the type of art being shown in the collection), Description (a short description of the collection).
-- 
-- The table EXHIBITIONS has the primary key NAME which is the name of the art exhibition. It contains the attributes Start.date (the starting date of the exhibition) and
-- End_Date (which is the day the exhibition ends).
--
-- The table ARTIST contains the foreign key id_no which is used to identify what art object the artist is responsible for making, the primary key Name which is 
-- the name of the artist. It contains the following other  other attributes as well: Description (Description of the artist), Date.born, Date.died, Country_of_origin, 
-- Epoch, Main_style.
--
-- The table PERMANENT_cOLLECTION contains the foreign key id_no that points to ART_OBJECT and is used to store art objects permanently in a collection.
-- It also contains the following other attributes: Status, Cost, and Date.acquired.
--
-- The table IN_COLLECTION contains the foreign keys id_no that points to ART_OBJECT and Name that points to COLLECTIONS. It is used to store art objects
-- that are in a collection currently.
--
-- The table ON_DISPLAY contains the foreign keys id_no that points to ART_OBJECT and Name that points to EXHIBITIONS. It is used to store art objects that
-- are currently on display in an exhibition.
--
-- TRIGGERS:
-- Two triggers were used between the tables IN_COLLECTION and ON_DISPLAY. The triggers used were 'Update' and 'Delete'.


-- 2) A basic retrieval query
SELECT Name, Description, Date_born, Date_died
FROM ARTIST
WHERE id_no = 2;

-- 3) A retrieval query with ordered results
SELECT id_no, Name, Description, Date_born, Date_died
FROM ARTIST
ORDER BY id_no ASC;

-- 4) A nested retrieval query
SELECT Status, Cost
FROM PERMANENT_COLLECTION
WHERE id_no IN (SELECT id_no
                FROM ART_OBJECT
                WHERE id_no = 4);

-- 5) A retrieval query using joined tables
SELECT SCULPTURE.id_no, SCULPTURE.Material, SCULPTURE.Height, SCULPTURE.Weight
FROM SCULPTURE
INNER JOIN ART_OBJECT
ON SCULPTURE.id_no = ART_OBJECT.id_no;

-- 6) An update operation with any necessary triggers
DELIMITER $$

CREATE TRIGGER COLLECTION_DISPLAY
AFTER UPDATE
ON IN_COLLECTION FOR EACH ROW
BEGIN
    IF OLD.IN_COLLECTION <> new.IN_COLLECTION THEN
        INSERT INTO ON_DISPLAY (id_no, Name)
        VALUES(old.id_no, old.Name);
    END IF;
END$$

DELIMITER ;

UPDATE IN_COLLECTION 
SET id_no = 5
WHERE id_no = 5;

-- 7) A deletion operation with any necessary triggers
DELIMITER $$
CREATE TRIGGER DELETE_COLLECTION
AFTER DELETE ON ON_DISPLAY FOR EACH ROW
BEGIN
INSERT INTO IN_COLLECTION (id_no, Nme)
VALUES (OLD.id_no, OLD.Name);
END$$
DELIMITER ;

DELETE FROM ON_DISPLAY
WHERE id_no = 5;

