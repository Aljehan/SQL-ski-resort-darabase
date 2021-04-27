DROP TABLE enrolled_in; 
DROP TABLE lessons;
DROP TABLE lesson_price;
DROP TABLE rented_in;
DROP TABLE rental_transaction;
DROP TABLE rental_equipment; 
DROP TABLE rental_pricing;
DROP TABLE job_type;
DROP TABLE staff; 
DROP TABLE customer;
DROP TABLE lift_pass;
DROP TABLE pass_types;



CREATE TABLE pass_types
(
    pass_type   VARCHAR2(20)    PRIMARY KEY,
    time_period INT             NOT NULL -- number of days pass has on it 
);

INSERT INTO pass_types VALUES ('Season Pass', 100);
INSERT INTO pass_types VALUES ('MultiDay Pass', 3);
INSERT INTO pass_types VALUES ('Day Pass', 1);

CREATE TABLE lift_pass
(
    pass_num    NUMBER(8)    PRIMARY KEY,
    start_date  DATE         NOT NULL,
    pass_type   VARCHAR2(20) REFERENCES pass_types(pass_type)
);

INSERT INTO lift_pass VALUES 
    (12345675, TO_DATE('30-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345676, TO_DATE('30-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345677, TO_DATE('14-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345678, TO_DATE('14-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345679, TO_DATE('14-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345680, TO_DATE('15-07-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345681, TO_DATE('16-06-2020', 'DD-MM-YYYY'), 'Season Pass');
INSERT INTO lift_pass VALUES 
    (12345682, TO_DATE('14-06-2020', 'DD-MM-YYYY'), 'MultiDay Pass');
INSERT INTO lift_pass VALUES 
    (12345683, TO_DATE('20-06-2020', 'DD-MM-YYYY'), 'MultiDay Pass');
INSERT INTO lift_pass VALUES 
    (12345684, TO_DATE('23-08-2020', 'DD-MM-YYYY'), 'MultiDay Pass');
INSERT INTO lift_pass VALUES 
    (12345685, TO_DATE('11-07-2020', 'DD-MM-YYYY'), 'Day Pass');
INSERT INTO lift_pass VALUES 
    (12345686, TO_DATE('01-08-2020', 'DD-MM-YYYY'), 'Day Pass');
INSERT INTO lift_pass VALUES 
    (12345687, TO_DATE('09-07-2020', 'DD-MM-YYYY'), 'Day Pass');

CREATE TABLE customer 
(
    cust_pass_num NUMBER(8)     REFERENCES lift_pass(pass_num),
    fname         VARCHAR2(25)  NOT NULL,
    lname         VARCHAR2(25)  NOT NULL,
    email         VARCHAR2(60),
    date_of_birth DATE,
    phone         VARCHAR2(15),
    PRIMARY KEY(cust_pass_num, fname, lname)
);

INSERT INTO customer VALUES 
    (12345680, 'Jordon', 'Wong', 'jordon@example.com', TO_DATE('22-07-1990', 'DD-MM-YYYY'), '027856987');
INSERT INTO customer VALUES 
    (12345681, 'Jennifer', 'Hope', 'jennifer@example.com', TO_DATE('16-02-1989', 'DD-MM-YYYY'), '027456123');
INSERT INTO customer VALUES 
    (12345682, 'Joyce', 'Ford', 'joyce@example.com', TO_DATE('14-06-1950', 'DD-MM-YYYY'), '021456789');
INSERT INTO customer VALUES 
    (12345683, 'Tim', 'Stevens', 'tim@example.com', TO_DATE('20-06-1989', 'DD-MM-YYYY'), '021147258');
INSERT INTO customer VALUES 
    (12345684, 'Rob', 'Dick', 'rob@example.com', TO_DATE('23-08-1985', 'DD-MM-YYYY'), '021369852');
INSERT INTO customer VALUES 
    (12345685, 'Jim', 'McDonald', 'jim@example.com', TO_DATE('11-06-1986', 'DD-MM-YYYY'), '021256325');
INSERT INTO customer VALUES 
    (12345686, 'Sam', 'Borg', 'sam@example.com', TO_DATE('01-05-1996', 'DD-MM-YYYY'), '023789456');
INSERT INTO customer VALUES 
    (12345687, 'Caitlin', 'Gould', 'caitlin@example.com', TO_DATE('09-02-1956', 'DD-MM-YYYY'), '025156423');

CREATE TABLE staff
(
    ird_num         CHAR(9)         PRIMARY KEY,
    fname           VARCHAR2(20)    NOT NULL,
    lName           VARCHAR2(20)    NOT NULL,
    sex             CHAR,
    salary          NUMBER(6),
    date_of_birth   DATE,
    start_date      DATE,
    staff_pass_num NUMBER(8) REFERENCES lift_pass(pass_num)
);

INSERT INTO staff VALUES 
    (770345320, 'Sam', 'Davies', 'M', 200000, TO_DATE('09-01-1995','DD-MM-YYYY'),
        TO_DATE('20-08-2020','DD-MM-YYYY'), 12345675); 
INSERT INTO staff VALUES 
    (770345321, 'Elisa', 'Baker', 'F', 210000, TO_DATE('11-06-1993','DD-MM-YYYY'),
        TO_DATE('20-08-2019','DD-MM-YYYY'), 12345676); 
INSERT INTO staff VALUES 
    (770345323, 'Leon', 'Gould', 'M', 190000, 
        TO_DATE('05-11-1996','DD-MM-YYYY'), TO_DATE('20-09-2020','DD-MM-YYYY'), 12345677); 
INSERT INTO staff VALUES 
    (770345324, 'Caitlin', 'Dyas', 'F', 250000,
        TO_DATE('28-09-1993','DD-MM-YYYY'), TO_DATE('20-08-2018','DD-MM-YYYY'), 12345678); 
INSERT INTO staff VALUES 
    (770345325, 'Kaleb', 'Clark', 'M', 220000, 
        TO_DATE('28-09-1994','DD-MM-YYYY'), TO_DATE('21-08-2018','DD-MM-YYYY'), 12345679); 

CREATE TABLE job_type
(
    staff_ird_num   CHAR(9)         REFERENCES staff(ird_num),
    staff_job_type  VARCHAR2(10)    NOT NULL,
    PRIMARY KEY (staff_ird_num, staff_job_type)
);

INSERT INTO job_type VALUES (770345320, 'Rentals');
INSERT INTO job_type VALUES (770345321, 'Instructor'); 
INSERT INTO job_type VALUES (770345323, 'Instructor'); 
INSERT INTO job_type VALUES (770345324, 'Rentals'); 
INSERT INTO job_type VALUES (770345325, 'Rentals'); 


CREATE TABLE lesson_price
(
    lesson_type     VARCHAR2(20),
    lesson_level    VARCHAR2(15),
    time_period     DATE,
    price           DECIMAL(10,2), 
    PRIMARY KEY(lesson_type, lesson_level, time_period)
);

INSERT INTO lesson_price VALUES 
    ('Private', 'Beginner', TO_DATE('10:00:00','hh24:mi:ss'), 100.00); 
INSERT INTO lesson_price VALUES 
    ('Group', 'Beginner', TO_DATE('12:30:00','hh24:mi:ss'), 70.00); 
INSERT INTO lesson_price VALUES 
    ('Private', 'Intermediate', TO_DATE('09:00:00','hh24:mi:ss'), 110.00); 
INSERT INTO lesson_price VALUES 
    ('Private', 'Advanced', TO_DATE('13:45:00','hh24:mi:ss'), 80.00); 
INSERT INTO lesson_price VALUES 
    ('Group', 'Beginner', TO_DATE('01:23:44','hh24:mi:ss'), 80.00); 

CREATE TABLE lessons
(
    lesson_num      NUMBER(8)       PRIMARY KEY,
    lesson_type     VARCHAR2(20)    NOT NULL,
    date_time       DATE            NOT NULL,
    sport           VARCHAR2(20)    NOT NULL,
    lesson_level    VARCHAR(15),
    time_period     DATE,
    staff_ird_num   CHAR(9),
    FOREIGN KEY (staff_ird_num) REFERENCES staff(ird_num),
    FOREIGN KEY (lesson_type, lesson_level, time_period) REFERENCES 
        lesson_price(lesson_type, lesson_level, time_period)
);

INSERT INTO lessons VALUES
    ('00001321', 'Private', TO_DATE('20-Aug-2020 10:00:00','dd-mon-yyyy hh24:mi:ss'),
         'Skiing', 'Beginner', TO_DATE('10:00:00','hh24:mi:ss'), 770345323 );
INSERT INTO lessons VALUES
    ('12345678', 'Group', TO_DATE('22-Aug-2020 12:30:00','dd-mon-yyyy hh24:mi:ss'),
         'Skiing', 'Beginner', TO_DATE('12:30:00','hh24:mi:ss'), 770345321 ); 
INSERT INTO lessons VALUES
    ('22222222', 'Private', TO_DATE('06-May-2020 09:00:00','dd-mon-yyyy hh24:mi:ss'),
         'Skiing', 'Intermediate', TO_DATE('09:00:00','hh24:mi:ss'), 770345321 ); 
INSERT INTO lessons VALUES
    ('33333333', 'Private', TO_DATE('05-Aug-2020 13:45:00','dd-mon-yyyy hh24:mi:ss'),
         'Skiing', 'Advanced', TO_DATE('13:45:00','hh24:mi:ss'), 770345323 ); 
INSERT INTO lessons VALUES
    ('44444444', 'Group', TO_DATE('27-Jul-2020 01:23:44','dd-mon-yyyy hh24:mi:ss'),
         'Skiing', 'Beginner', TO_DATE('01:23:44','hh24:mi:ss'), 770345321 ); 

CREATE TABLE enrolled_in
(
    lesson_num      NUMBER(8)       REFERENCES lessons(lesson_num), 
    cust_pass_num   NUMBER(8),
    cust_fname      VARCHAR2(25),
    cust_lname      VARCHAR2(25),
    PRIMARY KEY (lesson_num, cust_pass_num, cust_fname, cust_lname),
    FOREIGN KEY (cust_pass_num, cust_fname, cust_lname) REFERENCES 
        customer(cust_pass_num, fname, lname) 
); 

INSERT INTO enrolled_in VALUES('00001321', 12345680, 'Jordon', 'Wong');
INSERT INTO enrolled_in VALUES('12345678', 12345681, 'Jennifer', 'Hope'); 
INSERT INTO enrolled_in VALUES('22222222', 12345682, 'Joyce', 'Ford'); 
INSERT INTO enrolled_in VALUES('33333333', 12345683, 'Tim', 'Stevens'); 
INSERT INTO enrolled_in VALUES('44444444', 12345684, 'Rob', 'Dick'); 

CREATE TABLE rental_pricing 
(
    type    VARCHAR(15)     PRIMARY KEY,
    price   DECIMAL(10,2)   NOT NULL
); 

INSERT INTO rental_pricing VALUES ('Ski Boots', 12.5); 
INSERT INTO rental_pricing VALUES ('Helmet', 5); 
INSERT INTO rental_pricing VALUES ('Skis', 25); 
INSERT INTO rental_pricing VALUES ('Snowboard', 25); 
INSERT INTO rental_pricing VALUES ('Ski Poles', 10); 
INSERT INTO rental_pricing VALUES ('Jacket', 15); 
INSERT INTO rental_pricing VALUES ('Snow Boots', 13);

CREATE TABLE rental_equipment 
(
    type            VARCHAR(15)     NOT NULL,
    equip_size      VARCHAR(15),
    equipment_code  NUMBER(8)       PRIMARY KEY,
    FOREIGN KEY (type) REFERENCES rental_pricing(type) 
); 

INSERT INTO rental_equipment VALUES ('Ski Boots', '8', 10000001); 
INSERT INTO rental_equipment VALUES ('Helmet', NULL, 10000002); 
INSERT INTO rental_equipment VALUES ('Snowboard', 'Medium', 10000003); 
INSERT INTO rental_equipment VALUES ('Ski Poles', NULL, 10000004);  
INSERT INTO rental_equipment VALUES ('Snow Boots', '5', 10000005); 
INSERT INTO rental_equipment VALUES ('Skis', 'Small', 10000006); 
INSERT INTO rental_equipment VALUES ('Jacket', '10', 10000007); 

CREATE TABLE rental_transaction 
(
    rental_length   INTEGER         NOT NULL, 
    transaction_id  NUMBER(8)       PRIMARY KEY, 
    date_time       DATE            NOT NULL, 
    staff_ird       CHAR(9)         NOT NULL, 
    cust_pass_num   NUMBER(8)       NOT NULL, 
    cust_fname      VARCHAR(25), 
    cust_lname      VARCHAR(25), 
    FOREIGN KEY (staff_ird) REFERENCES staff(ird_num), 
    FOREIGN KEY (cust_pass_num, cust_fname, cust_lname) 
        REFERENCES customer(cust_pass_num, fname, lname) 
); 

INSERT INTO rental_transaction VALUES 
    (2, 00000001, TO_DATE('07-May-2020 10:30:00','dd-mon-yyyy hh:mi:ss'), 
        770345320, 12345680, 'Jordon', 'Wong'); 
INSERT INTO rental_transaction VALUES 
    (2, 00000002, TO_DATE('08-May-2020 11:30:00','dd-mon-yyyy hh:mi:ss'),
         770345320, 12345680, 'Jordon', 'Wong'); 
INSERT INTO rental_transaction VALUES 
    (12, 00000003, TO_DATE('23-May-2020 09:42:00','dd-mon-yyyy hh:mi:ss'),
         770345324, 12345682, 'Joyce', 'Ford'); 
INSERT INTO rental_transaction VALUES 
    (5, 00000004, TO_DATE('07-Jun-2020 10:12:00','dd-mon-yyyy hh:mi:ss'),
         770345320, 12345684, 'Rob', 'Dick'); 
INSERT INTO rental_transaction VALUES 
    (1, 00000005, TO_DATE('09-Jul-2020 09:20:00','dd-mon-yyyy hh:mi:ss'),
         770345324, 12345683, 'Tim', 'Stevens'); 
INSERT INTO rental_transaction VALUES 
    (3, 00000006, TO_DATE('19-Jul-2020 08:10:00','dd-mon-yyyy hh:mi:ss'),
         770345325, 12345682, 'Joyce', 'Ford'); 
INSERT INTO rental_transaction VALUES 
    (3, 00000007, TO_DATE('27-Jul-2020 08:30:00','dd-mon-yyyy hh:mi:ss'),
         770345325, 12345685, 'Jim', 'McDonald'); 


CREATE TABLE rented_in 
(
    transaction_id      NUMBER(8), 
    equipment_code      NUMBER(8),
    PRIMARY KEY (transaction_id, equipment_code),
    FOREIGN KEY (transaction_id) REFERENCES 
        rental_transaction(transaction_id),
    FOREIGN KEY (equipment_code) REFERENCES 
        rental_equipment(equipment_code) 
); 

INSERT INTO rented_in VALUES (00000001, 10000002); 
INSERT INTO rented_in VALUES (00000002, 10000006);
INSERT INTO rented_in VALUES (00000003, 10000005);
INSERT INTO rented_in VALUES (00000004, 10000007);
INSERT INTO rented_in VALUES (00000005, 10000004);
INSERT INTO rented_in VALUES (00000006, 10000005);
INSERT INTO rented_in VALUES (00000007, 10000001);

COMMIT;