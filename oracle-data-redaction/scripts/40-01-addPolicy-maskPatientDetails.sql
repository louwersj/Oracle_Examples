-- create redaction policy on PATIENT_DETAILS.PATIENT_SSN and PATIENT_DETAILS.PATIENT_EMAIL

BEGIN
 DBMS_REDACT.ADD_POLICY(
   object_schema           => 'C##USER1', 
   object_name             => 'PATIENT_DETAILS', 
   column_name             => 'PATIENT_SSN',
   policy_name             => 'maskPatientDetails', 
   function_type           => DBMS_REDACT.PARTIAL,
   function_parameters     => DBMS_REDACT.REDACT_US_SSN_L4,
   expression              => 'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''C##USER1'''
   );
END;

BEGIN
 DBMS_REDACT.alter_policy(
   object_schema           => 'C##USER1', 
   object_name             => 'PATIENT_DETAILS', 
   column_name             => 'PATIENT_EMAIL',
   policy_name             => 'maskPatientDetails', 
   function_type           => dbms_redact.regexp,
   regexp_pattern          => dbms_redact.re_pattern_email_address,
   regexp_replace_string   => dbms_redact.RE_REDACT_EMAIL_ENTIRE,
   regexp_position         => dbms_redact.re_beginning,
   regexp_occurrence       => dbms_redact.re_all,
   regexp_match_parameter  => 'i',
   expression              => 'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''C##USER1'''
   );
END;
