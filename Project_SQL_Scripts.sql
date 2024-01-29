-- SQL Scripts


-- 1
Select * from Doctor;

-- 2
Select * from Nurse;

-- 3
Select * from Room;

-- 4 
Select * from Receptionist;

-- 5 
Select * from Patient;

-- 6
Select * from Visit;

-- 7
Select * from Insurance;

-- 8
Select * from InsuranceInfo;

-- 9
Select * from Cure;

-- 10
Select * from PatientAdmit;

-- 11
Select * from Patient where Doctor_id = '401';

-- 12
Select * from Patient where Nurse_id = '102' and doctor_id = '404';


-- 13 	Getting names of patient names and why they are in Emargency:
Select p.Patient_id,p.Patient_name,v.ReasonOfVisit from Patient p join Visit v
on p.patient_Id = v.Patient_id ;

-- 14 	Retriving informatin about all patients and their reason of visiting Emargency and doctor the assigned by joining 3 tables(Patient,Visit,Doctor)
Select p.Patient_name,v.ReasonOfVisit,d.doctor_Name from Patient p join Visit v
on p.patient_Id = v.Patient_id join doctor d 
on p.doctor_id = d.doctor_id;

-- 15 	Patient who visited Emergency on 25th March 2020
Select * from patient where patient_EntryDate = '2022-03-25';

-- 16 	Patients Visiting emergency between Mar 19th 2022 to Apr 13th 2022
Select * from patient where patient_EntryDate between '2022-03-19' and '2022-04-13';

-- 17 	Updating Patient “Andrew” Address from ‘6754 West Route Ave’ to ‘2390 JhonsonRoad’
update patient set Patient_Address = '2390 JhonsonRoad' where patient_Id = '3';

-- 18 	Male Patients visited to emergency
Select * from patient where patient_gender = ‘male’;

-- 19 	Patients who stay in room number 200:
select patient_id,patient_name from patient 
where patient_id in
		(select patient_id from patientAdmit where room_number = '200');

-- 20 	Patients who are not in any rooms in emergency:
select patient_id,patient_name from patient 
where patient_id not in
		(select patient_id from patientAdmit );
        
-- 21 	Which doctor available on April 13th 2022
Select * from doctor where dr_availabilityStatus = 'yes' and dr_availabilitydate = '2022-04-13';

-- 22 	Doctors who are Neurologists:
Select * from doctor where Doctor_Specialization = 'Neurologist';

-- 23 	List of Patients why they are in emergency and their symptoms, which doctor is handling
Select p.Patient_Name,v.Reasonofvisit,v.Symptoms,d.Doctor_specialization,d.Doctor_Name 
from patient p join visit v
on p.patient_id = v.patient_id join doctor d
on p.doctor_id = d.doctor_id;

-- 24 	Patient, their symptoms and cure they got 
Select p.Patient_Name,v.Reasonofvisit,v.Symptoms,c.cure_Action,c.Cure_Result 
from patient p join visit v
on p.patient_id = v.patient_id join cure c
on p.patient_id = c.patient_id;

-- 25 	Patients and their Insurance Provider:
select i.Patient_id,i.Insurance_Name,n.Insurance_Number,n.Insurance_Validity
from Insurance i join InsuranceInfo n
where i.Insurance_name = n.Insurance_name;

-- 26 	Patients whom doctors are not assigned waiting to get assign:
Select * from Patient where doctor_id is null;

-- 27 	Checking how many rooms are available:
Select Count(*) as Rooms_Available from room where room_Availability = 'Yes';

-- 28 	Checking how many room are booked:
Select Count(*) as Rooms_Available from room where room_Availability = 'No';

-- 29 	Patients who consulted Receptionist id 303:
select p.patient_Id,p.Patient_Name,r.Receptionist_id,r.receptionist_Name from patient p join receptionist r 
on p.Receptionist_id = r.Receptionist_id
where r.receptionist_id = '303';

-- 30 	Patient who approached receptionist 303(Sara) and their assigned doctors:
Select n.Patient_Name,n.Receptionist_Name,d.doctor_Name from (select p.patient_Id,p.Patient_Name,p.doctor_id,r.Receptionist_id,r.receptionist_Name 
from patient p join receptionist r 
on p.Receptionist_id = r.Receptionist_id
where r.receptionist_id = '303') n join doctor d on
d.doctor_id = n.doctor_id;

-- 31 	Patients with symptoms nauseous
Select p.Patient_id,p.patient_name,v.symptoms from patient p join visit v
on p.patient_id = v.patient_id
where symptoms = 'nauseous';

-- 32
Select * from patient where patient_id = '5';

-- 33.	
select max(Bill_Amount) from payments;

-- 34.	
select min(Bill_Amount) from payments;

-- 35.	
select sum(Bill_Amount) from payments;

-- 36.	
select Avg(Bill_Amount) from payments;

-- 37 	find out patient which are present in room (patientAdmit)
select a.Patient_id 
from patientAdmit a 
where a.patient_id  in (Select p.patient_id from patient p where p.patient_id is not null);

-- 38 Patient with bill amount greater than 500
select p.patient_id,p.patient_name,a.Bill_amount from patient p join payments a 
on p.patient_id = a.patient_id
where a.bill_amount > 500
order by a.bill_amount desc;

-- 39 	Addidng all bills paid by patients:

select p.patient_id,p.patient_name,sum(a.Bill_amount) as Total from patient p join payments a 
on p.patient_id = a.patient_id
group by p.patient_id,p.patient_name










