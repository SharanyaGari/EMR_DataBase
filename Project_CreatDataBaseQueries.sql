-- Creating DataBase Query:
Create database EMR;

-- Creating Tables Queries:

CREATE TABLE doctor(
Doctor_Id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
Doctor_Name VARCHAR(50),
Doctor_Specialization  VARCHAR(100),
DR_availabilityStatus  VARCHAR(20),
Dr_availabilityDate DATE);

-- 2

CREATE TABLE nurse(
Nurse_Id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
Nurse_Name VARCHAR(50),
Nurse_Address  VARCHAR(100),
Nurse_Email  VARCHAR(100)
);

-- 3

CREATE TABLE receptionist(
receptionist_Id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
receptionist_Name VARCHAR(50),
receptionist_Address  VARCHAR(100),
receptionist_Gender  VARCHAR(100)
);

-- 4
CREATE TABLE room(
Room_Number INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
Room_Availability VARCHAR(20),
Room_EntryDate  DATE,
Room_ExitDate  VARCHAR(20)
);

-- 5

CREATE TABLE  patient (
 Patient_ID  INT  NOT NULL AUTO_INCREMENT PRIMARY KEY ,
 Patient_Name VARCHAR(50) ,
 Patient_Gender  VARCHAR(20) ,
 Patient_EntryDate Date ,
 Patient_ExitDate  Date ,
 ReasonOfVisit VARCHAR(200),
 Insurance_Provider VARCHAR(100),
 Cure VARCHAR(200),
 Doctor_Id INT,
 Nurse_Id INT,
 Room_Number INT,
 CONSTRAINT fk_patient_doctor
 FOREIGN KEY (Doctor_Id)
 REFERENCES doctor (Doctor_Id),
 CONSTRAINT fk_patient_nurse
 FOREIGN KEY (Nurse_Id)
REFERENCES nurse (Nurse_Id),
CONSTRAINT fk_patient_room
 FOREIGN KEY (Room_Number)
REFERENCES room (Room_Number)
) ENGINE = InnoDB;

-- 6

CREATE TABLE Insurance(
Patient_Id INT,
Insurance_Name VARCHAR(50),
CONSTRAINT fk_Insurance_Patient 
FOREIGN KEY (Patient_ID)
REFERENCES Patient (Patient_ID)
) ENGINE = InnoDB;

-- 7

create table InsuranceInfo (
Insurance_Name VARCHAR(50) PRIMARY KEY,
Insurance_Number INT,
Insurance_Validity INT
);

-- 8

CREATE TABLE Cure(
Patient_Id INT,
Cure_ID INT Primary Key,
Cure_Action VARCHAR(50),
Cure_Result VARCHAR(100),
CONSTRAINT fk_Cure_Patient 
FOREIGN KEY (Patient_ID)
REFERENCES Patient (Patient_ID)
) ENGINE = InnoDB;


-- 9

create table PatientAdmit (
Room_Number INT NOT NULL,
Patient_Id INT NOT NULL,
CONSTRAINT PK_Patient_Admit PRIMARY KEY (Room_Number,Patient_Id)
);

-- 10

Create table Visit (
Patient_id INT,
ReasonOfVisit VARCHAR(100),
Sympotoms VARCHAR(50),
CONSTRAINT fK_Visit_Patient FOREIGN KEY (Patient_Id) REFERENCES Patient (patient_id)
);

-- 11
create table payments(
Patient_id INT,
Bill_Amount INT,
CONSTRAINT fK_payments_Patient FOREIGN KEY (Patient_Id) REFERENCES Patient (patient_Id)
);

-- ---------------------Inserting Data ------------------

-- 1 Nurse
insert into nurse (Nurse_Id,Nurse_Name_Nurse_Address,Nurse_Email)
values ('101','Nate','220-Idolstreet','nate1@gmail.com'),
	   ('102','Max','106-RockDrive','max324@gmail.com'),
       ('103','renee','908-mantionRoad','renee.h4@gmail.com'),
       ('104','Monica','1134-ProvidenceRoad','monica123@gmail.com'),
       ('105','Harvey','256-StreetCenter','harveyS23@gmail.com');
       
-- Room

insert into Room (Room_Number,Room_Availability,Room_EntryDate,Room_ExitDate)
values ('200','No','2022-03-18','2022-03-20'),
	   ('201','Yes','2022-05-01','2022-05-10'),
       ('202','Yes','2022-05-12','2022-05-15'),
       ('203','No','2022-03-22','2022-03-28'),
       ('204','No','2022-03-25','2022-03-26'),
       ('205','No','2022-04-01','2022-04-09'),
       ('206','No','2022-04-12','2022-04-15'),
       ('207','No','2022-04-18','2022-04-22');

-- Receptionist

insert into receptionist (receptionist_Id,receptionist_Name,receptionist_Address,receptionist_Gender)
values ('301','Jake','190-HighwayRoad','Male'),
	   ('302','Phill','155-HillRoad','Male'),
       ('303','Sara','908-NorthStreet','female'),
       ('304','Rachel','1654-WestHigh','female'),
       ('305','Lilly','880-MaintainRoad','female');
       
-- Doctor

INSERT INTO doctor (Doctor_Id, Doctor_Name, Doctor_Specialization, Dr_availabilityStatus, Dr_availabilityDate)
VALUES ('400', 'Dr.Miller', 'Neurologist', 'Yes', '2022-04-13'),
	   ('401', 'Dr.Mike', 'Neurologist', 'No', '2022-04-23'),
       ('402', 'Dr.Brinda', 'Gynecologist', 'Yes', '2022-05-09'),
       ('403', 'Dr.Gill', 'Gynecologist', 'No', '2022-05-11'),
       ('404', 'Dr.Jerry', 'MBBS', 'Yes', '2022-05-18'),
       ('405', 'Dr.Julia', 'MBBS', 'No', '2023-05-30');
       
-- Patient

INSERT INTO patient (Patient_ID,Patient_Name,Patient_Gender,Patient_EntryDate,Patient_ExitDate,Doctor_Id,Nurse_Id,Receptionist_Id,Patient_Address)
values ('06','Rockey','male','2022-04-13','2022-04-16','404','105','304','824 Hillroad'),
('07','Richi','female','2022-03-19','2022-03-24','403','101','301','1 West Road'),
('08','Milli','Female','2022-04-28','2022-04-30','402','105','302','520 MountainHills'),
('09','Haley','female','2022-02-09','2022-02-12','404','103','305','1432 PeerRoad'),
('10','Haley','female','2022-05-03','2022-05-06','405','105','304','786 MathewHill');


-- Insurance

Insert into Insurance (Patient_Id,Insurance_Name)
values ('1','VSP'),
	   ('2','VSP'),
       ('3','VSP'),
       ('4','BlueCross'),
       ('5','BlueCross');
       
-- InsuranceInfo

insert into InsuranceInfo (Insurance_Name,Insurance_Number,Insurance_Validity)
Values ('VSP','6001','3'),
	   ('BlueCross','6002','2');
       
-- PatientAdmit

insert into PatientAdmit (Room_Number,Patient_Id)
Values ('200','1'),
	   ('200','2'),
       ('205','3'),
       ('202','4'),
       ('206','5');
       
-- Payment

INSERT into payments(Patient_Id,Bill_Amount)
values ('1','1200'),
	   ('2','550'),
       ('3','40'),
       ('4','900'),	
       ('5','500'),
       ('6','20'),
       ('7','100'),
       ('8','1900'),
       ('9','250'),
       ('10','690');
       
-- cure

insert into cure (Cure_id,Cure_Action,Cure_Result,patient_id) 
values ('1007','Rest','Successfull','6'),
('1008','Medicine','Successfull','7'),
('1009','Surgery','Successfull','8'),
('1010','medication','Successfull','9'),
('1011','MRI','Successfull','10');

-- Visit

insert into visit (patient_id,ReasonOfVisit,Symptoms)
values ('6','HighFever','High body temperature'),
	   ('7','Menstrual','Body Cramps'),
       ('8','Pregenency Issue','Nauseous'),
       ('9','food allergy','Rashes'),
       ('10','Sinus','Cold');
       
