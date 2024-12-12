-- ----------------------------------------------------------------
-- Script name: 20_create_synonyms.sql
-- Author: Sergio Artigas
-- Created on: Nov 19, 2024
-- Purpose: Get create synonym statements
-- Execute as:
-- SQL>  sqlplus / as sysdba <<EOF
--       START 20_create_synonyms.sql APEX_240100 DUMMY
--       START 20_create_synonyms.sql APEX_240100 APEX_REST_PUBLIC_USER
--       START 20_create_synonyms.sql ORDS_METADATA DUMMY
--       START 20_create_synonyms.sql ORDS_METADATA APEX_REST_PUBLIC_USER
--       QUIT
--       EOF
-- Optional: Source schema can be locked down for security reasons.
-- ----------------------------------------------------------------
SET DEFINE ON
SET ECHO OFF
SET SQLBLANKLINES OFF
SET FEEDBACK OFF
SET HEADING OFF
SET VERIFY ON
SET WRAP OFF
SET TRIMSPOOL ON
SET TRIMOUT ON
SET PAGESIZE 0
SET LINESIZE 300

-- Increase SourceSchema variable size in case schema name is beyond 15 chars
VARIABLE SourceSchema VARCHAR2(25)
VARIABLE TargetSchema VARCHAR2(25)
BEGIN
 :SourceSchema := '&1';
 :TargetSchema := '&2';
END;
/

SPOOL script_002.sql APPEND

-- Select grants
SELECT 'CREATE OR REPLACE NONEDITIONABLE SYNONYM "'||:TargetSchema||'"."'||DS.SYNONYM_NAME||'" FOR "'||TP.OWNER||'"."'||TP.TABLE_NAME||'";'
  FROM DBA_TAB_PRIVS TP, DBA_SYNONYMS DS
 WHERE DS.TABLE_OWNER = TP.GRANTOR
   AND TP.GRANTEE = DS.OWNER
   AND DS.TABLE_NAME = TP.TABLE_NAME
   AND TP.GRANTEE = 'PUBLIC'
   -- AND TP.PRIVILEGE = 'EXECUTE'
   AND TP.OWNER = :SourceSchema
ORDER BY TP.TABLE_NAME
/

SPOOL OFF
