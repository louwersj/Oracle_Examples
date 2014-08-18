-- add data redaction policy for all users that are NOT user C##USER1 on medicine_distribution.comments

BEGIN
 DBMS_REDACT.ADD_POLICY(
   object_schema       => 'C##USER1', 
   object_name         => 'medicine_distribution', 
   column_name         => 'comments',
   policy_name         => 'maskmedicinecomments', 
   function_type       => DBMS_REDACT.full,
   expression          => 'SYS_CONTEXT(''USERENV'',''SESSION_USER'') != ''C##USER1'''
   );
END;
