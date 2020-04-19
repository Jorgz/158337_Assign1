CREATE TABLE director
(
    dir_id INTEGER,
    dir_fname VARCHAR2(20) NOT NULL,
    dir_lname VARCHAR2(20) NOT NULL,
    -- Assume phone number is local NZ number
    dir_phone NUMBER(9) NOT NULL,
    dir_room NUMBER(5) NOT NULL,

    PRIMARY KEY (dir_id)
);

CREATE TABLE degree
(
    deg_id INTEGER,
    deg_name VARCHAR2(20) NOT NULL UNIQUE,
    deg_credits NUMBER(3) NOT NULL,

    PRIMARY KEY (deg_id)
);

CREATE TABLE advisor
(
    adv_id INTEGER,
    adv_fname VARCHAR2(20) NOT NULL,
    adv_lname VARCHAR2(20) NOT NULL,
    adv_position VARCHAR2(20) NOT NULL,
    adv_phone NUMBER(9) NOT NULL,
    adv_room NUMBER(5) NOT NULL,
    adv_department VARCHAR(20) NOT NULL,

    PRIMARY KEY (adv_id)
);

CREATE TABLE next_of_kin
(
    nok_id INTEGER,
    nok_fname VARCHAR(20) NOT NULL,
    nok_lname VARCHAR(20) NOT NULL,
    nok_relationship VARCHAR(12) NOT NULL,
    -- Assume contact number maybe international, requiring max length of 15
    nok_contact NUMBER(15) NOT NULL,

    PRIMARY KEY (nok_id)
);

CREATE TABLE staff
(
    stf_id INTEGER,
    stf_fname VARCHAR2(20) NOT NULL,
    stf_lname VARCHAR2(20) NOT NULL,
    stf_streetnum INTEGER NOT NULL,
    stf_street VARCHAR2(34) NOT NULL,
    stf_suburb VARCHAR2(24) NOT NULL,
    stf_dob DATE NOT NULL,
    stf_sex CHAR(1) NOT NULL CHECK (stf_sex IN('m', 'f')),
    stf_position VARCHAR2(20) NOT NULL,
    -- Check this, most likely will be a FK when lease rent hall stuff figured out
    stf_location VARCHAR2(20) DEFAULT ('Acommodation Office'),

    PRIMARY KEY (stf_id)
);

CREATE TABLE inspection
(
    ins_id INTEGER,
    ins_date DATE NOT NULL,
    ins_satisfactory NUMBER(1) NOT NULL CHECK (ins_satisfactory BETWEEN 0 AND 1),
    ins_comments VARCHAR2(300),
    ins_inspector INTEGER NOT NULL,

    PRIMARY KEY(ins_id),
    FOREIGN KEY(ins_inspector) REFERENCES staff(stf_id)
);

CREATE TABLE student 
(
  stu_id INTEGER, 
  stu_fname VARCHAR2(20) NOT NULL, 
  stu_lname VARCHAR2(20) NOT NULL, 
  stu_address VARCHAR2(20) NOT NULL, 
  stu_dob DATE NOT NULL, 
  stu_sex CHAR(1) NOT NULL CHECK(stu_sex IN('m', 'f')), 
  stu_level VARCHAR2(20) NOT NULL, 
  stu_nationality VARCHAR2(20) NOT NULL, 
  stu_smoker VARCHAR2(1) NOT NULL, 
  stu_sp_need VARCHAR2(20) NOT NULL, 
  stu_add_comment VARCHAR2(20) NOT NULL,
  stu_status VARCHAR2(20) NOT NULL, 
  stu_contact VARCHAR2(20) NOT NULL, 
  stu_waiting VARCHAR2(1) NOT NULL, 
  stu_degree INTEGER NOT NULL, 
  stu_advisor INTEGER NOT NULL,
  stu_nok INTEGER,
  
  PRIMARY KEY (STU_ID),
  FOREIGN KEY (STU_DEGREE) REFERENCES degree(deg_id),
  FOREIGN KEY (stu_advisor) REFERENCES advisor(adv_id) ON DELETE SET NULL,
  FOREIGN KEY (STU_NOK) REFERENCES next_of_kin(nok_id) ON DELETE SET NULL
);

CREATE TABLE lease
(
    -- unsure about the current modelling of lease and bedrooms etc.
    lea_num INTEGER,
    lea_duration VARCHAR2(20) NOT NULL,
    lea_start DATE NOT NULL,
    lea_end DATE,
    lea_student INTEGER NOT NULL,

    PRIMARY KEY(lea_num),
    FOREIGN KEY(lea_student) REFERENCES student(stu_id)
);


CREATE TABLE invoice
(
    inv_num INTEGER,
    -- Ensure that the duration of the lease contract is a minimum of one year (3 semesters)
    inv_duration INTEGER CHECK (inv_duration > 2),
    inv_start DATE NOT NULL,
    inv_end DATE NOT NULL,
    inv_student INTEGER NOT NULL,

    PRIMARY KEY (inv_num),
    FOREIGN KEY (inv_student) REFERENCES student(stu_id) ON DELETE SET NULL
);