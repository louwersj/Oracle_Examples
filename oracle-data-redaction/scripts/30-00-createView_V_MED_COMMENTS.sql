-- create the V_MED_COMMENTS for the user C##USER1. This view is used to 
-- combined data from both the patient records as well as the medication
-- distribution list.

CREATE VIEW C##USER1.V_MED_COMMENTS
AS 
select
      dis.medicine_id,
      dis.comments,
      dis.patient_id,
      det.patient_firstname,
      det.patient_lastname,
      det.patient_gender
from
    medicine_distribution DIS,
    patient_details DET
where
     dis.patient_id = det.id;
