CREATE TABLE department
(
    dep_id INTEGER,
    dep_name VARCHAR2(20) NOT NULL,
    dep_director VARCHAR2(20) NOT NULL,
    dep_phone NUMBER NOT NULL,
    dep_room INTEGER NOT NULL,

    PRIMARY KEY (dep_id)
);

CREATE TABLE degree
(
    deg_id INTEGER,
    deg_name VARCHAR2(20) NOT NULL UNIQUE,
    deg_length INTEGER NOT NULL,
    deg_department INTEGER NOT NULL,

    PRIMARY KEY (deg_id),
    FOREIGN KEY (deg_department) REFERENCES department(dep_id)
);

CREATE TABLE advisor
(
    adv_id INTEGER,
    adv_fname VARCHAR2(20) NOT NULL,
    adv_lname VARCHAR2(20) NOT NULL,
    adv_position VARCHAR2(20) NOT NULL,
    adv_phone INTEGER NOT NULL,
    adv_room INTEGER NOT NULL,
    adv_department INTEGER NOT NULL,

    PRIMARY KEY (adv_id),
    FOREIGN KEY (adv_department) REFERENCES department(dep_id)
    
);

CREATE TABLE next_of_kin
(
    nok_id INTEGER,
    nok_fname VARCHAR(20) NOT NULL,
    nok_lname VARCHAR(20) NOT NULL,
    nok_relationship VARCHAR(12) NOT NULL,
    nok_contact VARCHAR(20) NOT NULL,

    PRIMARY KEY (nok_id)
);

CREATE TABLE staff
(
    stf_id INTEGER,
    stf_fname VARCHAR2(20) NOT NULL,
    stf_lname VARCHAR2(20) NOT NULL,
    stf_addr_num INTEGER NOT NULL,
    stf_addr_street VARCHAR2(30) NOT NULL,
    stf_addr_street_type VARCHAR2(12) NOT NULL,
    stf_addr_suburb VARCHAR2(24) NOT NULL,
    stf_dob DATE NOT NULL,
    stf_sex CHAR(1) NOT NULL CHECK (stf_sex IN('m', 'f')),
    stf_position VARCHAR2(20) NOT NULL,
    stf_location VARCHAR2(20) DEFAULT ('Acommodation Office'),

    PRIMARY KEY (stf_id)
);

CREATE TABLE inspection
(
    ins_id INTEGER,
    ins_date DATE NOT NULL,
    ins_satisfactory NUMBER(1) NOT NULL CHECK (ins_satisfactory BETWEEN 0 AND 1),
    ins_comments VARCHAR2(240),
    ins_inspector INTEGER NOT NULL,

    PRIMARY KEY(ins_id),
    FOREIGN KEY(ins_inspector) REFERENCES staff(stf_id)
);

CREATE TABLE lease
(
    -- unsure about the current modelling of lease and bedrooms etc.
    lea_id INTEGER,
    lea_duration VARCHAR2(20) NOT NULL,
    lea_start DATE NOT NULL CHECK(lea_start > STSDATE),
    lea_end DATE NOT NULL,
    lea_student INTEGER NOT NULL

    PRIMARY KEY(lease)
);

ALTER TABLE lease
  modify (
    -- check to make sure the end date of a lease is not before the start date, has to be done as an ALTER as Oracle SQL does not 
    -- support referencing two columns during table create as part of a CHECK 
    CONSTRAINT chk_valid_date CHECK(lea_start < lea_end)
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
  FOREIGN KEY (STU_NOK) REFERENCES next_of_kin(nok_id) ON DELETE SET NULL
);

