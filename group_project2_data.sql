
-- add test data

INSERT INTO customer VALUES (1, 'John Doe', 'john.doe@example.com'); 
INSERT INTO customer VALUES (2, 'Jane Smith', 'jane.smith@example.com'); 
INSERT INTO customer VALUES (3, 'Bob Johnson', 'bob.johnson@example.com');


INSERT INTO address VALUES (1,'123 Blake Street','Guelph','Ontario','L4M1K2');
INSERT INTO address VALUES (2,'234 Derek Drive','Toronto','Ontario','M5W1E5');
INSERT INTO address VALUES (3,'1 Lewis Street','Ottawa','Ontario','K2S1E6');



INSERT INTO customer_address VALUES (1,to_timestamp('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2018-10-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),1,1);
INSERT INTO customer_address VALUES (2,to_timestamp('2018-10-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL,1,2);
INSERT INTO customer_address VALUES (3,to_timestamp('2017-02-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL,2,3);

INSERT INTO telephone VALUES (1, 'Mobile', '(123) 456-7890'); 
INSERT INTO telephone VALUES (2, 'Home', '(987) 654-3210'); 
INSERT INTO telephone VALUES (3, 'Work', '(555) 555-5555');

INSERT INTO customer_telephone VALUES (1, '2024-11-01 00:00:00', NULL, 1, 1); 
INSERT INTO customer_telephone VALUES (2, '2024-11-15 00:00:00', '2024-11-30 12:00:00', 2, 2); 
INSERT INTO customer_telephone VALUES (3, '2024-11-20 00:00:00', NULL, 3, 3);

INSERT INTO equipment VALUES (1, 50, 10);
INSERT INTO equipment VALUES (2, 60, 15);
INSERT INTO equipment VALUES (3, 10, 25); 


INSERT INTO ename VALUES (1, 'Ski');
INSERT INTO ename VALUES (2, 'Snowboard'); 
INSERT INTO ename VALUES (3, 'Helmet'); 


INSERT INTO equipment_name VALUES (1, TO_TIMESTAMP('2024-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 1, 1); 
INSERT INTO equipment_name VALUES (2, TO_TIMESTAMP('2024-11-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2); 
INSERT INTO equipment_name VALUES (3, TO_TIMESTAMP('2024-11-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 3, 3);


INSERT INTO rental VALUES (1, '2024-11-28', 2, 1, 1);
INSERT INTO rental VALUES (2, '2024-11-29', 1, 2, 3);
INSERT INTO rental VALUES (3, '2024-11-30', 3, 3, 2);

COMMIT;

