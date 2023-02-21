DROP DATABASE IF EXISTS MUSEUM;
CREATE DATABASE MUSEUM;
USE MUSEUM;

DROP TABLE IF EXISTS ART_OBJECT;
CREATE TABLE ART_OBJECT( id_no double,
						 Origin char(50),
						 Title char(50),
						 Epoch char(50),
                         Description char(50),
                         Year double,
                         PRIMARY KEY (id_no)
                         );

DROP TABLE IF EXISTS ARTIST;                         
CREATE TABLE ARTIST  ( id_no double,
					   Name char(50),
					   Description char(50),
					   Date_born double,
                       Date_died double,
                       Country_of_origin char(50),
                       Epoch char(50),
                       Main_style char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT (id_no)
					   );
                       
DROP TABLE IF EXISTS PAINTING;                       
CREATE TABLE PAINTING( id_no double,
					   paint_type char(50),
					   drawn_on char(50),
					   Style char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT (id_no)
					   );

DROP TABLE IF EXISTS SCULPTURE;
CREATE TABLE SCULPTURE( id_no double,
					   Material char(50),
					   Height double,
                       Weight double,
					   Style char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT (id_no)
					   );
					
DROP TABLE IF EXISTS STATUE;
CREATE TABLE STATUE  ( id_no double,
					   Material char(50),
					   Height double,
                       Weight double,
					   Style char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT (id_no)
					   );
                       
DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER   ( id_no double,
					   Type char(50),
					   Style char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT (id_no)
					   );
                       
DROP TABLE IF EXISTS COLLECTIONS;
CREATE TABLE COLLECTIONS ( Name char(50),
					   Phone double,
					   Contact_person char(50),
					   Street_address char(50),
                       City char(50),
                       Country char(50),
                       Postal_code char(50),
                       Type char(50),
                       Description char(50),
					   PRIMARY KEY (Name)
					   );
                       
DROP TABLE IF EXISTS PERMANENT_COLLECTION;
CREATE TABLE PERMANENT_COLLECTION   ( id_no double,
					   Status char(50),
					   Cost double,
                       Date_acquired char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT(id_no)
					   );
                       
DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED   ( id_no double,
					   Collection_origin char(50),
                       Date_borrowed char(50),
                       Date_returned char(50),
					   FOREIGN KEY (id_no) REFERENCES ART_OBJECT(id_no)
					   );
                       
DROP TABLE IF EXISTS EXHIBITIONS;
CREATE TABLE EXHIBITIONS ( Name char(50),
                       Start_date char(50),
                       End_date char(50),
					   PRIMARY KEY (Name)
					   );
                       
DROP TABLE IF EXISTS IN_COLLECTION;
CREATE TABLE IN_COLLECTION ( id_no double,
					   Name char(50),
                       FOREIGN KEY (id_no) REFERENCES ART_OBJECT(id_no),
                       FOREIGN KEY (Name) REFERENCES COLLECTIONS(Name)
                       );
                       
DROP TABLE IF EXISTS ON_DISPLAY;
CREATE TABLE ON_DISPLAY ( id_no double,
					   Name char(50),
                       FOREIGN KEY (id_no) REFERENCES ART_OBJECT(id_no),
                       FOREIGN KEY (Name) REFERENCES EXHIBITIONS(Name)
                       );


DROP ROLE IF EXISTS db_admin@localhost, read_access@localhost, db_entry@localhost;

CREATE ROLE db_admin@localhost, read_access@localhost, db_entry@localhost;

GRANT ALL PRIVILEGES ON *.* TO db_admin@localhost WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON MUSEUM.* TO db_entry@localhost;
GRANT SELECT ON MUSEUM.* TO read_access@localhost;

DROP USER IF EXISTS administrator@localhost;
DROP USER IF EXISTS guest@localhost;
DROP USER IF EXISTS employee@localhost;

CREATE USER administrator@localhost IDENTIFIED WITH mysql_native_password BY 'password';
CREATE USER employee@localhost IDENTIFIED WITH mysql_native_password BY '12345';
CREATE USER guest@localhost;

GRANT db_admin@localhost TO administrator@localhost;
GRANT CREATE USER ON *.* TO administrator@localhost WITH GRANT OPTION;
GRANT db_entry@localhost TO employee@localhost;
GRANT read_access@localhost TO guest@localhost;

SET DEFAULT ROLE ALL TO administrator@localhost;
SET DEFAULT ROLE ALL TO employee@localhost;
SET DEFAULT ROLE ALL TO guest@localhost;

FLUSH PRIVILEGES;

USE MUSEUM;

INSERT INTO ART_OBJECT (id_no, Origin, Title, Epoch, Description, Year)
 VALUES (1, 'Italian', 'Mona Lisa', 'Renaissance', 'Florentine Wife', 1503),
		(2, 'Italian', 'The Last Supper', 'Renaissance', 'Jesus eats', 1496),
		(3, 'French', 'The Starry Night', 'Modern', 'Dream', 1889),
		(4, 'Norweigan', 'The Scream', 'Modern', 'paniced creature', 1893),
		(5, 'Indian', 'Horses', 'Modern', 'Four horses', 1960),
		(6, 'Brazillian', 'Christ the Redeemer',	'Modern' ,'Jesus w/ open arms', 1931),
		(7, 'French', 'Statue of Liberty', 'Modern', 'Lady hold torch', 1886),
		(8, 'Russian', 'Mother Russia Statue', 'Modern', 'winged female', 1967),
		(9,'Chinese','Spring Temple Buddha','Modern','Vairocana Buddha',2007),
		(10,'Indian','Statue of Unity','Modern','Indian statesman',2013),
		(11,'Italian', 'The Statue David', 'Renaissance', 'Naked man',1504),
		(12,'Italian', 'Ecstasy of Saint Teresa', 'Renaissance','Religious ecstasy',1652),
		(13, 'French', 'The Thinker', 'Renaissance', 'A man sitting',1904),
		(14,'Italian', 'Manekken Pis', 'Renaissance', 'A naked infant',1619),
		(15, 'Italian', 'Pieta', 'Renaissance', 'Mary',1499),
		(16, 'French', 'Puddle', 'Modern', 'Man jumping',1932),
		(17, 'American', 'Lunch atop a skyscraper', 'Modern', 'Workers eating lunch',1932),
		(18, 'American','V-J Day in Times Square', 'Modern', 'couple kissing', 1945),
		(19, 'Vietnamese','The Burning Monk', 'Modern','Protesting buddhist',1963),
		(20, 'Vietnamese', 'Napalm Girl', 'Modern', 'Girl sobbing',1972);

INSERT INTO ARTIST (id_no, Name, Description, Date_born, Date_died, Country_of_origin, Epoch, Main_style)
 VALUES (1, 'Leonardo Da Vinci', 'Mona Lisa',1452,1519,'Italy','Renaissance','Renaissance'),
 		(2,'Leonardo Da Vinci', 'The Last Supper', 1452, 1519, 'Italy', 'Renaissance', 'Renaissance'),
		(3,'Vincent Van Gogh','The Starry Night',1853,1890, 'Netherlands','Modern', 'Post-Impressionism'),
		(4, 'Edvard Munch', 'Ecstasy of Saint Teresa', 1863, 1944, 'Norway', 'Modern', 'Post-Impressionism'),
		(5, 'Maqbool Fida Hussain', 'Horses', '1915', '2011', 'India', 'Modern', 'Cubism'),
		(6, 'Paul Landowski', 'Christ the Redeemer', 1875, 1961, 'France','Modern', 'Art Nouveau'),
		(7, 'Auguste Bartholdi', 'Statue of Liberty', 1834, 1904, 'France', 'Modern', 'Modern'),
		(8, 'Yevgeny Vuchetich', 'Mother Russia Statue' , 1908, 1974, 'Ukraine', 'Modern', 'Modern'),
		(9, 'Hai Tong', 'Spring Temple Buddha', 720, 760, 'China', 'Ancient', 'Ancient Chinese'),
		(10, 'Ram Suttar', 'Statue of Unity', 1925, 2022,'India', 'Modern', 'Modern'),
		(11, 'Michelangelo', 'The Statue David', 1475, 1564, 'Italy', 'Renaissance', 'Renaissance'),
		(12, 'Gian Lorenzo Bernini', 'Ecstasy of Saint Teresa', 1598, 1680, 'Italy', 'Renaissance', 'Renaissance'),
		(13, 'Auguste Rodin', 'The Thinker', 1840, 1917, 'France', 'Modern', 'Expressionist Human'),
		(14, 'Jerome Duquesnoy', 'Manekken Pis', 1602, 1654, 'Belgium' , 'Renaissance', 'Renaissance'),
		(15, 'Michelangelo', 'Pieta', 1475, 1564, 'Italy', 'Renaissance', 'Renaissance'),
		(16, 'Henri Cartier-Bresson', 'Puddle', '1908', 2004, 'French', 'Modern', 'Modern'),
		(17, 'Charles Clyde Ebbets', 'Lunch atop a skyscraper',1905,1978, 'American', 'Modern','Modern'),
		(18, 'Alfred Eisenstaedt', 'V-J Day in Times Square', 1898, 1995, 'Polish', 'Modern', 'Modern'),
		(19, 'Malcome Brown', 'The Burning Monk', 1931, 2012, 'American', 'Modern', 'Modern'),
		(20, 'Nick Ut', 'Napalm Girl', 1951, 2022,'American', 'Modern', 'Modern');


INSERT INTO PAINTING (id_no, paint_type, drawn_on, Style)
 VALUES (1, 'Portrait', 1503, 'Renaissance'),
		(2, 'Mural', 1496, 'Renaissance'),
		(3, 'Landscape', 1889, 'Modern'),
		(4, 'Abstract', 1893, 'Modern'),
		(5, 'Animal', 1960, 'Modern');

INSERT INTO SCULPTURE (id_no, Material, Height, Weight, Style)
 VALUES (6, 'Concrete/Soapstone', 30, 635, 'Art-Deco'),
		(7, 'Copper/Steel', 93, 204, 'Neoclassical'),
		(8, 'Concrete/Metal', 85, 8000, 'Socialist Realism'),
		(9, 'Copper', 128, 1000, 'Buddhist'),
		(10, 'Concrete/Bronze', 182, 67000, 'Naturalistic');

INSERT INTO STATUE (id_no, Material, Height, Weight, Style)
 VALUES (11, 'Marble', 5.17, 6, 'Renaissance'),
		(12, 'Marble', 3.5, 4.2, 'Renaissance'),
		(13, 'Marble', 1.89, 5.4, 'Renaissance'),
		(14, 'Marble', 10, 1, 'Renaissance'),
		(15, 'Marble', 1.74, 6.1, 'Renaissance');

INSERT INTO OTHER (id_no, Type, Style)
 VALUES (16, 'Photo', 'Humanist'),
		(17, 'Photo', 'Humanist'),
		(18, 'Photo', 'Humanist'),
		(19, 'Photo', 'Photojournalism'),
		(20, 'Photo', 'Photojournalism');

INSERT INTO COLLECTIONS (Name, Phone, Contact_person, Street_address, City, Country, Postal_code, Type, Description)
 VALUES ('Louvre', 140205050, 'Jean Hollande', 'Musée du Louvre', 'Paris', 'France', 75001, 'Renaissance', 'Renaissance art'),
		('The Museum of Modern Art', 2127089400, 'Adam McCormick', '11 W 53rd St', 'New York City', 'USA', 10019, 'Modern', 'Modern Art'),
		('National Museum of Oslo', 21982000, 'Erik Magnusson', 'Brynjulf Bulls plass 3', 'Oslo', 'Norway', 250, 'Abstract', 'Modern Art'),
		('Accademia Gallery', 0550987100, 'Antonio Basillieni', 'Via Ricasoli, 58/60', 'Firenze Fi', 'Italy', 50129, 'Renaissance', 'Renaissance Art'),
		('Musée Rodin', 144186110, 'Francois Dubois', '77 Rue de Varenne', 'Paris', 'France', 75007, 'Modern', 'Modern Art'),
		('Brussels City Museum', 22794350, 'Michel Peeters', 'Grote Markt van', 'Brussels', 'Belgium', 1000, 'Renaissance', 'Renaissance Art');


INSERT INTO PERMANENT_COLLECTION (id_no, Status, Cost, Date_acquired)
 VALUES (1, 'On Display', 870000000, 1804),
		(3, 'On Display', 100000000, 1941),
		(4, 'On Display', 120000000, 1910),
		(11, 'On Display', 200000000, 1910),
		(13, 'In Collection', 16000000, 1922),
		(14, 'stored', 5000000, 1966);


INSERT INTO BORROWED (id_no, Collection_origin, Date_borrowed, Date_returned)
VALUES	(11, 'Accademia Gallery', '11/05/2022', '12/06/2022'),
		(13, 'Musée Rodin', '11/05/2022', '12/06/2022');

INSERT INTO EXHIBITIONS (Name, Start_date, End_date)
	VALUES ('The Tudors', '03/12/2021', '03/02/2022');

INSERT INTO IN_COLLECTION (id_no, Name)
	VALUES (13, 'Musée Rodin');

INSERT INTO ON_DISPLAY (id_no, Name)
 VALUES (1, 'The Tudors'),
		(3, 'The Tudors'),
		(4, 'The Tudors'),
		(11, 'The Tudors');