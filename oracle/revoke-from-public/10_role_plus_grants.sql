-- ----------------------------------------------------------------
-- Script name: 10_role_plus_grants.sql
-- Author: Sergio Artigas
-- Created on: Nov 19, 2024
-- Purpose: Create role to access schema objects.
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
VARIABLE SourceSchema VARCHAR2(15)
BEGIN
 :SourceSchema := '&1';
END;
/

SPOOL script_001.sql APPEND

-- Create role
SELECT 'CREATE ROLE '||:SourceSchema||'_ROLE;'
  FROM DUAL
/

-- Select grants
SELECT 'GRANT '||PRIVILEGE||' ON /* '||TP.TYPE||' */ "'||TP.GRANTOR||'"."'||TP.TABLE_NAME||'" TO '||:SourceSchema||'_ROLE;'
  FROM DBA_TAB_PRIVS TP
 WHERE TP.GRANTEE = 'PUBLIC'
   AND TP.OWNER = :SourceSchema
ORDER BY TP.TABLE_NAME
/

SPOOL OFF
