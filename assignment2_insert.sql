-- 
-- ORACLE application database and associated users creation script for CST2355
--
--
-- should be run while connected as 'sqlplus / as sysdba'
--

-- Create STORAGE
CREATE TABLESPACE cst2355_assignment2
  DATAFILE 'cst2355_assignment2.dat' SIZE 40M 
  ONLINE; 
  
-- Create Users
CREATE USER group9User IDENTIFIED BY group9UserPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE cst2355_assignment2
	QUOTA 20M ON cst2355_assignment2;
	
CREATE USER testUser IDENTIFIED BY testPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE cst2355_assignment2
	QUOTA 5M ON cst2355_assignment2;
	
-- Create ROLES
CREATE ROLE applicationAdmin;
CREATE ROLE applicationUser;

-- Grant PRIVILEGES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO applicationAdmin;
GRANT CONNECT, RESOURCE TO applicationUser;

GRANT applicationAdmin TO group9User;
GRANT applicationUser TO testUser;

-- NOW we can connect as the applicationAdmin and create the stored procedures, tables, and triggers

CONNECT group9User/group9UserPassword;

--
-- Stored procedures for use by triggers
--

CREATE OR REPLACE PROCEDURE sp_checkInvalidPostalCode(postalcode IN VARCHAR)
AS
BEGIN
	-- Check the format is OK, otherwise throw a unique error
	IF NOT REGEXP_LIKE (postalcode, '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')  THEN
		RAISE_APPLICATION_ERROR (-20000, 'The postal code must be 6 characters in length of the form: "A9A9A9"!');
	END IF;	
END;
/

CREATE OR REPLACE PROCEDURE sp_checkInvalidTelephone(telnumber IN VARCHAR)
AS
BEGIN
	-- Check the format is OK, otherwise throw a unique error
	IF  telnumber NOT LIKE '(___) ___-____'  THEN
		RAISE_APPLICATION_ERROR (-20000, 'The telephone number must be of the form: "(xxx) xxx-xxxx"!');
	END IF;	
END; 
/

CREATE TABLE address (
  idaddress int NOT NULL,
  street varchar(50) NOT NULL,
  city varchar(50) NOT NULL,
  province varchar(50) NOT NULL,
  postalcode varchar(7) NOT NULL,
  PRIMARY KEY (idaddress)
);


CREATE OR REPLACE TRIGGER address_check
BEFORE INSERT OR UPDATE 
ON address
FOR EACH ROW 
DECLARE 
	var_pc	varchar(45) := :NEW.postalcode;
BEGIN
	sp_checkInvalidPostalCode(var_pc);
END;
/


CREATE TABLE customer (
  idcustomer int NOT NULL,
  customerName varchar(50) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY (idcustomer)
);




CREATE TABLE customer_address (
  idcustomer_address int NOT NULL,
  startdate timestamp NOT NULL,
  enddate timestamp DEFAULT NULL,
  customer_idcustomer int NOT NULL,
  address_idaddress int NOT NULL,
  PRIMARY KEY (idcustomer_address),
  CONSTRAINT fk_c_a_a1 FOREIGN KEY (address_idaddress) REFERENCES address (idaddress),
  CONSTRAINT fk_c_a_c1 FOREIGN KEY (customer_idcustomer) REFERENCES customer (idcustomer)
);


--
-- Table structure for table `telephone`
--

CREATE TABLE telephone (
  idtelephone int NOT NULL,
  telephonetype varchar(45) NOT NULL,
  telephonenumber varchar(45) NOT NULL,
  PRIMARY KEY (idtelephone)
);

CREATE OR REPLACE TRIGGER telephone_check
BEFORE INSERT OR UPDATE 
ON telephone
FOR EACH ROW 
DECLARE 
	var_tel	varchar(45) := :NEW.telephonenumber;
BEGIN
	sp_checkInvalidTelephone (var_tel);
END;
/

CREATE TABLE customer_telephone (
  idcustomer_telephone int NOT NULL,
  startdate timestamp NOT NULL,
  enddate timestamp DEFAULT NULL,
  customer_idcustomer int NOT NULL,
  telephone_idtelephone int NOT NULL,
  PRIMARY KEY (idcustomer_telephone),
  CONSTRAINT fk_ct_c1 FOREIGN KEY (customer_idcustomer) REFERENCES customer (idcustomer),
  CONSTRAINT fk_ct_t1 FOREIGN KEY (telephone_idtelephone) REFERENCES telephone (idtelephone)
);


CREATE TABLE equipment(
  idequipment int NOT NULL,
  daily_rental_rate int  NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (idequipment)
);

CREATE TABLE ename (
  idename int NOT NULL,
  equipment_name varchar(45) NOT NULL,
  PRIMARY KEY (idename)
);


CREATE TABLE equipment_name (
  idequipment_name int NOT NULL,
  startdate timestamp NOT NULL,
  enddate timestamp DEFAULT NULL,
  equipment_idequipment int NOT NULL,
  ename_idename int NOT NULL,
  PRIMARY KEY (idequipment_name),
  CONSTRAINT fk_equipment FOREIGN KEY (equipment_idequipment) REFERENCES equipment (idequipment),
  CONSTRAINT fk_ename FOREIGN KEY (ename_idename) REFERENCES ename (idename)
);


CREATE TABLE rental (
  idrental int NOT NULL,
  rental_date date NOT NULL,
  quantity int NOT NULL,
  customer_id int NOT NULL,
  equipment_id int NOT NULL,
  PRIMARY KEY (idrental),
  CONSTRAINT fk_p_c1 FOREIGN KEY (customer_id) REFERENCES customer (idcustomer),
  CONSTRAINT fk_p_p1 FOREIGN KEY (equipment_id) REFERENCES equipment (idequipment)
);


COMMIT;

-- End of File
