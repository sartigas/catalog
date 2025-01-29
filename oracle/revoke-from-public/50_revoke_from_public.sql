-- ----------------------------------------------------------------
-- Script name: 50_revoke_from_public.sql
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

SPOOL script_005.sql APPEND

SELECT 'REVOKE '||PRIVILEGE||' ON /* '||TP.TYPE||' */ "'||TP.GRANTOR||'"."'||TP.TABLE_NAME||'" FROM PUBLIC;'
  FROM DBA_TAB_PRIVS TP
 WHERE TP.GRANTEE = 'PUBLIC'
   AND TP.TYPE != 'USER'
   AND TP.GRANTOR = :SourceSchema
ORDER BY TABLE_NAME
/

SPOOL OFF
