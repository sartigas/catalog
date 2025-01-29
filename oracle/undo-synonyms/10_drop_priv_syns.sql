-- ----------------------------------------------------------------
-- Script name: 10_drop_priv_syns.sql
-- Author: Sergio Artigas
-- Created on: Jan 27, 2025
-- Purpose: Drop private synonyms from Apex/ORDS schema objects.
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

-- Increase variableS size in case schema name is beyond 15 chars
VARIABLE SourceSchema VARCHAR2(15)
VARIABLE StartDate VARCHAR2(15)
BEGIN
 :SourceSchema := '&1';
 :StartDate := '&2';
END;
/

SPOOL script_001.sql APPEND

-- Select grants
SELECT 'DROP SYNONYM "'||O.OWNER||'"."'||O.OBJECT_NAME||'";'
  FROM DBA_ROLE_PRIVS G, DBA_OBJECTS O
WHERE G.GRANTEE = O.OWNER
  AND (O.CREATED > TO_DATE(:StartDate,'DD-MON-YY') AND O.CREATED < TO_DATE(:StartDate,'DD-MON-YY')+1)
  AND O.OBJECT_TYPE = 'SYNONYM'
  AND G.GRANTEE != 'SYS'
  AND G.GRANTED_ROLE = :SourceSchema||'_ROLE'
  AND G.GRANTEE NOT IN (SELECT ROLE FROM DBA_ROLES)
ORDER BY O.OWNER, O.OBJECT_NAME
/

SPOOL OFF
