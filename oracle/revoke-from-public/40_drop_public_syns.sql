-- ----------------------------------------------------------------
-- Script name: 40_drop_public_syns.sql
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

SPOOL script_004.sql APPEND

-- Select grants
SELECT 'DROP PUBLIC SYNONYM "'||DS.SYNONYM_NAME||'";'
  FROM DBA_SYNONYMS DS
 WHERE DS.OWNER = 'PUBLIC'
   AND DS.TABLE_OWNER = :SourceSchema
ORDER BY DS.TABLE_NAME
/

SPOOL OFF
