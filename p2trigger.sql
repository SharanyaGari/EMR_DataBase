-- Stored Procedures
DELIMITER //
CREATE PROCEDURE InsertDoctor()
BEGIN

-- Inserting into Doctor table
INSERT INTO doctor (Doctor_Id, Doctor_Name, Doctor_Specialization, Dr_availabilityStatus, Dr_availabilityDate)
VALUES ('406', 'Dr.Roy', 'Neurologist', 'Yes', '2022-05-18');

-- Seeing if values got inserted
select Doctor_Id,Doctor_Name from Doctor;

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateDoctor()
BEGIN

-- Updating into Doctor table
Update doctor set Doctor_Name = "Dr.Ray" where Doctor_Id = '406';

-- Seeing if values got Updated
select Doctor_Id,Doctor_Name from Doctor where Doctor_Id = '406';

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteDoctor()
BEGIN

-- Updating into Doctor table
Delete from doctor where Doctor_Id = '406';

-- Seeing if values got Updated
select Doctor_Id,Doctor_Name from Doctor;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PatientsBill()
BEGIN

-- Select patients and their Bill Amounts
Select t.patient_id,t.patient_Name,p.Bill_Amount from patient t join payments p where t.patient_id = p.patient_id;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PatientsInsurance()
BEGIN

-- ISelect patients and their insurance
Select p.patient_id,p.patient_name,i.Insurance_Name from patient p join insurance i where p.patient_id = i.patient_id;


END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PatientsDoctor()
BEGIN

-- Select patients and their Doctor
Select p.patient_id,p.patient_name,d.doctor_name,d.Doctor_Specialization from patient p join doctor d where p.doctor_id = d.doctor_id;


END //
DELIMITER ;
-- Views

Create view PatientReasonOfVisit as
Select p.Patient_id,p.Patient_name,v.ReasonOfVisit from Patient p join Visit v
on p.patient_Id = v.Patient_id ;

Create view PatientDoctor as
Select p.Patient_name,v.ReasonOfVisit,d.doctor_Name from Patient p join Visit v
on p.patient_Id = v.Patient_id join doctor d 
on p.doctor_id = d.doctor_id;

Create view PatientSymptoms as
Select p.Patient_Name,v.Reasonofvisit,v.Sympotoms,d.Doctor_specialization,d.Doctor_Name 
from patient p join visit v
on p.patient_id = v.patient_id join doctor d
on p.doctor_id = d.doctor_id;

Create view PatientCure as
Select p.Patient_Name,v.Reasonofvisit,v.Sympotoms,c.cure_Action,c.Cure_Result 
from patient p join visit v
on p.patient_id = v.patient_id join cure c
on p.patient_id = c.patient_id;

Create view PatientBillAmount as
select p.patient_id,p.patient_name,a.Bill_amount from patient p join payments a 
on p.patient_id = a.patient_id
where a.bill_amount > 500
order by a.bill_amount desc;

-- Indexes
CREATE INDEX Patient_Patient_id
ON Patient (Patient_Id,Patient_Name);

CREATE INDEX Doctor_Doctor_Name
ON Doctor (Doctor_Name);

CREATE INDEX Visit_ReasonOfVisit
ON Visit (ReasonOfVisit);

CREATE INDEX Room_Room_Number
ON Room (Room_Number);

CREATE INDEX Payment_Bill_Amount
ON payments (Bill_Amount);


-- Triggers

CREATE TABLE ROOM_AUDIT_Insert(
New_ROOM_NUMBER INT,
New_Room_Availability varchar(100),
New_Room_EntryDate date,
New_Room_ExitDate date,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100));

CREATE TABLE ROOM_AUDIT_Update(
Old_ROOM_NUMBER INT,
Old_Room_Availability varchar(100),
Old_Room_EntryDate date,
Old_Room_ExitDate date,
New_ROOM_NUMBER INT,
New_Room_Availability varchar(100),
New_Room_EntryDate date,
New_Room_ExitDate date,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100)
);

CREATE TABLE ROOM_AUDIT_Delete(
old_ROOM_NUMBER INT,
old_Room_Availability varchar(100),
old_Room_EntryDate date,
old_Room_ExitDate date,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100)
);


CREATE TRIGGER AUTDITOFROOMUPDATE
After UPDATE ON ROOM
for each row
INSERT INTO ROOM_AUDIT_Update SELECT old.Room_Number,old.Room_Availability,old.Room_EntryDate,Old.Room_ExitDate,
NEW.ROOM_NUMBER,new.Room_Availability,new.Room_EntryDate,new.Room_ExitDate,'UPDATE', NOW(),user()
FROM ROOM;

CREATE TRIGGER AUTDITOFROOMInsert
After Insert 
ON ROOM
FOR EACH ROW
INSERT INTO ROOM_AUDIT_Insert SELECT NEW.ROOM_NUMBER,new.Room_Availability,new.Room_EntryDate,new.Room_ExitDate,'Insert',
NOW(), user() FROM ROOM;

CREATE TRIGGER AUTDITOFROOMDelete
After Delete 
ON ROOM
FOR EACH ROW
INSERT INTO ROOM_AUDIT_Delete SELECT old.ROOM_NUMBER,old.Room_Availability,old.Room_EntryDate,old.Room_ExitDate,'Delete',
NOW(), user() FROM ROOM;

CREATE TABLE ROOM_AUDIT_UPDATE(
ROOM_NUMBER INT,
ACTION VARCHAR(200),
Chage_time Timestamp,
new_data INT);

CREATE TABLE PAYMENTS_AUDIT_Insert(
New_PATIENT_ID INT,
New_RBILL_AMOUNT INT,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100));

CREATE TABLE PAYMENTS_AUDIT_Update(
Old_PATIENT_ID INT,
Old_RBILL_AMOUNT INT,
New_PATIENT_ID INT,
New_RBILL_AMOUNT INT,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100)
);

CREATE TABLE PAYMENTS_AUDIT_Delete(
Old_PATIENT_ID INT,
Old_RBILL_AMOUNT INT,
ACTION VARCHAR(200),
Chage_time Timestamp,
User VARCHAR(100)
);

CREATE TRIGGER AUTDITOFPAYMENTSUPDATE
After UPDATE ON ROOM
for each row
INSERT INTO PAYMENTS_AUDIT_Update SELECT Old.PATIENT_ID,Old.BILL_AMOUNT,new.PATIENT_ID,New.BILL_AMOUNT
'UPDATE', NOW(),user() FROM Payments;

CREATE TRIGGER AUTDITOFPAYMENTSInsert
After Insert 
ON PAYMENTS
FOR EACH ROW
INSERT INTO PAYMENTS_AUDIT_Insert SELECT NEW.PATIENT_ID,new.BILL_AMOUNT,'Insert',
NOW(), user() FROM PAYMENTS;

CREATE TRIGGER AUTDITOFPAYMENTSDelete
After Delete 
ON ROOM
FOR EACH ROW
INSERT INTO PAYMENTS_AUDIT_Delete SELECT Old.PATIENT_ID,Old.BILL_AMOUNT,'Delete',
NOW(), user() FROM payments;

-- user Authentation
CREATE USER 'local_user'@'localhost' IDENTIFIED BY 'password';
CREATE USER doctor_admin identified by 'doctor' default role 'EMR_role';
Grant SELECT,UPDATE,DELETE  on doctor_admin to doctor_admin;

-- Role creation

create role EMR_user;
Grant select,delete on EMR.doctor to EMR_user;
create role EMR_Patient;