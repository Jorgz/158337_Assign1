CREATE TABLE director
(
    dir_id NUMBER,
    dir_fname VARCHAR2(18) NOT NULL,
    dir_lname VARCHAR2(32) NOT NULL,
    -- Assume phone number is local NZ number
    dir_phone NUMBER(9) NOT NULL UNIQUE CHECK(dir_phone NOT LIKE '%[^0-9%'), -- Check that only numbers entered for phone number
    dir_room NUMBER(4) NOT NULL,

    PRIMARY KEY (dir_id)
);


CREATE TABLE degree
(
    deg_id NUMBER,
    deg_name VARCHAR2(40) NOT NULL UNIQUE,
    deg_credits NUMBER(3) NOT NULL CHECK(deg_credits > 0), -- ensure credits is a positive number
    deg_department VARCHAR(40) NOT NULL,
    deg_director NUMBER,

    PRIMARY KEY (deg_id),
    FOREIGN KEY (deg_director) REFERENCES director(dir_id)
);

CREATE TABLE advisor
(
    adv_id NUMBER,
    adv_fname VARCHAR2(18) NOT NULL,
    adv_lname VARCHAR2(32) NOT NULL,
    adv_position VARCHAR2(40) NOT NULL,
    -- Assume phone number is local NZ number
    adv_phone NUMBER(9) NOT NULL UNIQUE CHECK(adv_phone NOT LIKE '%[^0-9%'), -- Check that only numbers entered for phone number
    adv_room NUMBER(4) NOT NULL,
    adv_department VARCHAR2(40) NOT NULL,

    PRIMARY KEY (adv_id)
);

CREATE TABLE next_of_kin
(
    nok_id NUMBER,
    nok_fname VARCHAR2(18) NOT NULL,
    nok_lname VARCHAR2(32) NOT NULL,
    nok_relationship VARCHAR2(20) NOT NULL,
    -- Assume contact number maybe international, requiring max length of 15
    nok_phone NUMBER(15) NOT NULL CHECK(nok_phone NOT LIKE '%[^0-9%'), -- Check that only numbers entered for phone number

    PRIMARY KEY (nok_id)
);

CREATE TABLE staff
(
    sta_id NUMBER,
    sta_fname VARCHAR2(18) NOT NULL,
    sta_lname VARCHAR2(32) NOT NULL,
    sta_sex CHAR(1) NOT NULL CHECK (sta_sex IN('m', 'f')),
    sta_street_number VARCHAR2(6) NOT NULL,  -- VARCHAR to support subdivisions e.g 102B or 22/1 etc.
    sta_street VARCHAR2(48) NOT NULL,
    sta_suburb VARCHAR2(32) NOT NULL,
    sta_postcode NUMBER(4, 0),
    sta_dob DATE NOT NULL,  
    sta_position VARCHAR2(30) NOT NULL,
    sta_location VARCHAR2(30) DEFAULT ('Acommodation Office'),

    PRIMARY KEY (sta_id)
);

CREATE TABLE studio
(
    std_number NUMBER,
    std_street_number VARCHAR2(6) NOT NULL, -- VARCHAR to support subdivisions e.g 102B or 22/1 etc.
    std_street VARCHAR2(48) NOT NULL,
    std_suburb VARCHAR2(32) NOT NULL,
    std_postcode NUMBER(4, 0) NOT NULL,
    std_furnished VARCHAR(9) DEFAULT ('fully') NOT NULL CHECK (std_furnished IN('fully', 'partially')),
    PRIMARY KEY (std_number)
);

CREATE TABLE flat
(
    fla_number NUMBER,
    fla_street_number VARCHAR2(6) NOT NULL, -- VARCHAR to support subdivisions e.g 102B or 22/1 etc.
    fla_street VARCHAR2(48) NOT NULL,
    fla_suburb VARCHAR2(32) NOT NULL,
    fla_postcode NUMBER(4, 0) NOT NULL,
    fla_rooms NUMBER(1, 0) NOT NULL CHECK(fla_rooms BETWEEN 4 AND 5),
    fla_furnished VARCHAR(9) DEFAULT ('fully') NOT NULL CHECK (fla_furnished IN('fully')),

    PRIMARY KEY(fla_number)
);

CREATE TABLE hall
(
    hal_id NUMBER,
    hal_name VARCHAR2(42),
    hal_phone VARCHAR(9),
    hal_street_number VARCHAR2(6), -- VARCHAR to support subdivisions e.g 102B or 22/1 etc.
    hal_street VARCHAR2(48) NOT NULL,
    hal_suburb VARCHAR2(32) NOT NULL,
    hal_postcode NUMBER(4, 0) NOT NULL,
    hal_staff NUMBER, -- Hall Manager

    PRIMARY KEY(hal_id),
    FOREIGN KEY(hal_staff) REFERENCES staff(sta_id)
);

CREATE TABLE student 
(
  stu_id NUMBER, 
  stu_fname VARCHAR2(18) NOT NULL, 
  stu_lname VARCHAR2(32) NOT NULL,
  stu_sex CHAR(1) NOT NULL CHECK(stu_sex IN('m', 'f')), 
  stu_street_number VARCHAR2(6) NOT NULL,
  stu_street VARCHAR2(48) NOT NULL,
  stu_suburb VARCHAR2(32) NOT NULL,
  stu_postcode NUMBER(4, 0) NOT NULL,
  stu_dob DATE NOT NULL, 
  stu_level VARCHAR2(13) NOT NULL CHECK(stu_level IN('undergraduate', 'postgraduate')), 
  stu_nationality VARCHAR2(32) NOT NULL, 
  stu_smoker NUMBER(1, 0) DEFAULT(0) NOT NULL CHECK (stu_smoker BETWEEN 0 AND 1), -- Boolean, 1 indicates a smoker
  stu_sp_need VARCHAR2(300) NOT NULL, 
  stu_comment VARCHAR2(300) NOT NULL,
  stu_status VARCHAR2(7) DEFAULT('waiting') NOT NULL CHECK (stu_status IN('placed', 'waiting')), 
  stu_degree NUMBER NOT NULL, 
  stu_advisor NUMBER NOT NULL,
  stu_nok NUMBER,
  
  PRIMARY KEY (stu_id),
  FOREIGN KEY (stu_degree) REFERENCES degree(deg_id),
  -- Assume that its possible for for a student to be without an advisor temporarily
  FOREIGN KEY (stu_advisor) REFERENCES advisor(adv_id) ON DELETE SET NULL,
  FOREIGN KEY (stu_nok) REFERENCES next_of_kin(nok_id) ON DELETE SET NULL
);

CREATE TABLE place
(
    pla_number NUMBER,
    pla_rent NUMBER (5, 2) NOT NULL CHECK(pla_rent > 0), -- Ensure the amount of rent for a room is greater than 0
    pla_catering VARCHAR2(8) DEFAULT('self') NOT NULL CHECK(pla_catering IN('self', 'partial', 'full')),
    pla_hall NUMBER,
    pla_flat NUMBER,
    pla_studio NUMBER,

    PRIMARY KEY (pla_number),
    -- Assume that if the building that if the building is removed then the corresponding places are no longer in the universities possession and archival is not necessary
    FOREIGN KEY(pla_hall) REFERENCES hall(hal_id) ON DELETE CASCADE,
    FOREIGN KEY(pla_flat) REFERENCES flat(fla_number) ON DELETE CASCADE,
    FOREIGN KEY(pla_studio) REFERENCES studio(std_number) ON DELETE CASCADE
);

CREATE TABLE lease
(
    lea_number NUMBER,
    lea_duration NUMBER(1, 0) NOT NULL CHECK (lea_duration > 2), -- Ensure that the duration of the lease contract is a minimum of one year (3 semesters)
    lea_start DATE NOT NULL,
    lea_end DATE,
    lea_student NUMBER NOT NULL,
    lea_place NUMBER NOT NULL,

    PRIMARY KEY(lea_number),
    FOREIGN KEY(lea_student) REFERENCES student(stu_id),
    FOREIGN KEY(lea_place) REFERENCES place(pla_number)
);

CREATE TABLE invoice
(
    inv_number NUMBER,
    inv_due DATE NOT NULL,
    inv_payed DATE NOT NULL,
    inv_method VARCHAR2(18) NOT NULL,
    inv_reminder DATE NOT NULL,
    inv_lease NUMBER NOT NULL,
    inv_student NUMBER NOT NULL,

    PRIMARY KEY (inv_number),
    -- Assume that even if a place is removed invoice records will want to be kept
    FOREIGN KEY (inv_lease) REFERENCES lease(lea_number) ON DELETE SET NULL,
    FOREIGN KEY (inv_student) REFERENCES student(stu_id) ON DELETE SET NULL
);

CREATE TABLE inspection
(
    ins_id NUMBER,
    ins_date DATE NOT NULL,
    ins_satisfactory NUMBER(1) NOT NULL CHECK (ins_satisfactory BETWEEN 0 AND 1), -- Boolean, 1 = satisfactory
    ins_comments VARCHAR2(300),
    ins_inspector NUMBER NOT NULL,
    ins_place NUMBER NOT NULL,

    PRIMARY KEY(ins_id),
    FOREIGN KEY(ins_inspector) REFERENCES staff(sta_id),
    -- Assume that even if a place is removed the inspection records are no longer necessary
    FOREIGN KEY(ins_place) REFERENCES place(pla_number) ON DELETE CASCADE
);

-- CREATING SEQUENCES TO AUTOINCREMENT SURROGATE IDS

CREATE SEQUENCE DIR_ID_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE DEG_ID_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE ADV_ID_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE NOK_ID_SEQ START WITH 10000 NOCACHE;
CREATE SEQUENCE STA_ID_SEQ START WITH 2000 NOCACHE;
CREATE SEQUENCE HAL_ID_SEQ START WITH 500 NOCACHE;
CREATE SEQUENCE INS_ID_SEQ START WITH 100000 NOCACHE;