INSERT INTO director VALUES(101, 'John', 'Smith', 085551234, 100);
INSERT INTO director VALUES(266, 'David', 'Ellison', 0855510391, 76);
INSERT INTO director VALUES(41, 'Aedan ', 'Ramsey', 085553888, 395);
INSERT INTO director VALUES(399, 'Abbi', 'Blackburn', 085556892, 201);
INSERT INTO director VALUES(186, 'Nina', 'Ingram', 085556134, 101);

INSERT INTO degree VALUES(10, 'Bachelor of Science', 360, 'Science', 101);
INSERT INTO degree VALUES(73, 'Masters of Science', 380, 'Science', 266);
INSERT INTO degree VALUES(32, 'Bachelor of Agriculture', 240, 'Agriculture', 41);
INSERT INTO degree VALUES(49, 'Bachelor of Arts', 300, 'Arts', 399);
INSERT INTO degree VALUES(485, 'Masters of Arts', 360, 'Arts', 186);

INSERT INTO advisor VALUES(95, 'Adam', 'Steve', 'Tutor', 085554321, 102, 'Science');
INSERT INTO advisor VALUES(219, 'Livia ', 'Rosa', 'Lecturer', 095556551, 28, 'Agriculture');
INSERT INTO advisor VALUES(1, 'Jeffry', 'Kleiner', 'Tutor', 095557777, 71, 'Arts');
INSERT INTO advisor VALUES(125, 'Barb', 'Hagberg', 'Tutor', 085555016, 115, 'Arts');
INSERT INTO advisor VALUES(161, 'Keila', 'Villalpando', 'Tutor', 085553321, 34, 'Science');

INSERT INTO next_of_kin VALUES(3, 'Jospeh', 'Applegate', 'Father', 035559767);
INSERT INTO next_of_kin VALUES(259, 'Tahlia', 'Bradshaw', 'Sister', 0553314891);
INSERT INTO next_of_kin VALUES(4, 'Jerome', 'Black', 'Father', 466443023);
INSERT INTO next_of_kin VALUES(157, 'Seamus', 'Bryan', 'Brother', 950649697);
INSERT INTO next_of_kin VALUES(60, 'Najma', 'Burris', 'Mother', 795252176);

INSERT INTO staff VALUES(34, 'Mona', 'Gasser', 'f', '23', 'River Street', 'Mount Beach', 2001, );
INSERT INTO staff VALUES(44, 'Fletcher', 'Mccumber', 'm', '174', 'Elm Road', 'Lathetagin', 9835, );
INSERT INTO staff VALUES(24, 'Amanda', 'Kepler', 'f', '32', 'Hillcrest Avenue', 'Easquain', 7001, );
INSERT INTO staff VALUES(30, 'Shanell', 'Roseborough', 'f', '127', 'Briarwood Court', 'Welchgrand', 0442, );
INSERT INTO staff VALUES(95, 'Carrol', 'Dashner', 'm', '80', 'Lake Lane', 'Ann Arbor', 1000, );

INSERT INTO student VALUES(189, 'Gary', 'Ricker', 'm', '28', 'Heather Court', 'Corinth', 4001,
DATE '1996-11-20', 'undergraduate', 'Australia', 0, ' ', ' ', 'placed', 10, 95, 3);
INSERT INTO student VALUES(2755, 'Cherryl', 'Clary', 'f', '38', 'Brookside Drive', 'Buderim', 4653,
DATE '2002-05-16', 'undergraduate', 'New Zealand', 0, '', '', 'placed', 10, 219, 259);
INSERT INTO student VALUES(107, 'Porfirio', 'Danaher', 'm', '148', 'Durham Road', 'Pocklington', 8002,
DATE '2001-03-13', 'postgraduate', 'New Zealand', 0, '', '', 'placed', 73, 95, 4);
INSERT INTO student VALUES(8134, 'Rita', 'Sprouse', 'f', '12', 'Brown Street', 'Scranton', 1201,
DATE '1998-01-12', 'undergraduate', 'Canada', 1, '', '', 'placed', 73, 125, 157);
INSERT INTO student VALUES(5585, 'Dennis', 'Redfield', 'm', '17', 'Market Street', 'Elland', 0451,
DATE '1997-05-26', 'postgraduate',  'New Zealand', 0, '', '', 'placed', 32, 1, 60);
INSERT INTO student VALUES(140, 'Idell', 'Head', 'f', '70', 'Sunset Drive', 'Towcester', 7852,
DATE '2000-12-18', 'undergraduate', 'New Zealand', 1, '', '', 'placed', 32, 161, NULL);
INSERT INTO student VALUES(411, 'Ellen', 'Durgan', 'f', '44', 'Jefferson Street', 'Burford', 3200,
DATE '2001-09-03', 'undergraduate', 'China', 1, '', '', 'placed', 49, 125, NULL);
INSERT INTO student VALUES(8659, 'Lissette', 'Ray', 'f', '27', 'Laurel Drive', 'Keyser', 8884,
DATE '2001-06-08', 'undergraduate', 'New Zealand', 0, '', '', 'placed', 49, 161, NULL);
INSERT INTO student VALUES(1524, 'Felton', 'Kittinger', 'm', '88', 'Fawn Lane', 'Lansing', 6844,
DATE '1999-01-14', 'postgraduate', 'New Zealand', 0, '', '', 'waiting', 485, 1, NULL);
INSERT INTO student VALUES(4049, 'Jeannine', 'Mckee', 'f', '60', 'Primrose Lane', 'Acton', 1234,
DATE '2002-09-05', 'postgraduate', 'Great Britain', 1, '', '', 'waiting', 485, 161, NULL);



