-- ----------------------------------------------------------------
-- Script name: script1.sql
-- Author: Sergio Artigas
-- Created on: Nov 1, 2024
-- Purpose: Create RO and RW roles to access schema objects.
--          Grant those 2 roles to a new account.
-- Optional: Source schema can be locked out for security reasons.
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

VARIABLE SourceSchema VARCHAR2(15)
VARIABLE TargetSchema VARCHAR2(15)
BEGIN
 :SourceSchema := '&1';
 :TargetSchema := '&2';
END;
/

SPOOL file1.sql REPLACE

-- Create RO role
SELECT 'CREATE ROLE APPSMAN9_RO_ROLE;'
  FROM DUAL
/

-- Create RW role
SELECT 'CREATE ROLE APPSMAN9_RW_ROLE;'
  FROM DUAL
/

-- Select RO grants
SELECT 'GRANT SELECT ON /* '||OBJECT_TYPE||' */ '||OWNER||'.'||OBJECT_NAME||' TO '||:SourceSchema||'_RO_ROLE;'
  FROM DBA_OBJECTS
 WHERE OWNER = :SourceSchema
   AND OBJECT_TYPE IN ('TABLE','VIEW','SEQUENCE')
   AND OBJECT_NAME NOT IN ('AW_MONITOR_LOCKS','AW_RMI_SERVERS_VIEW')
ORDER BY OBJECT_NAME
/

-- Select RW grants
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON /* '||OBJECT_TYPE||' */ '||OWNER||'.'||OBJECT_NAME||' TO '||:SourceSchema||'_RW_ROLE;'
  FROM DBA_OBJECTS
 WHERE OWNER = :SourceSchema
   AND OBJECT_TYPE IN ('TABLE')
ORDER BY OBJECT_NAME
/

SELECT 'GRANT SELECT ON /* VIEW */ APPSMAN9.AW_MONITOR_LOCKS TO '||:SourceSchema||'_RO_ROLE;'
  FROM DUAL
/
SELECT 'GRANT SELECT ON /* VIEW */ APPSMAN9.AW_RMI_SERVERS_VIEW TO '||:SourceSchema||'_RO_ROLE;'
  FROM DUAL
/
SELECT 'GRANT SELECT ON /* VIEW */ APPSMAN9.AW_MONITOR_LOCKS TO '||:SourceSchema||'_RW_ROLE;'
  FROM DUAL
/
SELECT 'GRANT SELECT ON /* VIEW */ APPSMAN9.AW_RMI_SERVERS_VIEW TO '||:SourceSchema||'_RW_ROLE;'
  FROM DUAL
/

SELECT 'GRANT EXECUTE ON /* '||OBJECT_TYPE||' */ '||OWNER||'.'||OBJECT_NAME||' TO '||:SourceSchema||'_RW_ROLE;'
  FROM DBA_OBJECTS
 WHERE OWNER = :SourceSchema
   AND OBJECT_TYPE IN ('PACKAGE', 'PACKAGE BODY','FUNCTION', 'PROCEDURE')
ORDER BY OBJECT_NAME
/

SELECT 'ALTER TRIGGER /* '||OBJECT_TYPE||','||STATUS||' */ '||OWNER||'.'||OBJECT_NAME||' COMPILE;'
  FROM DBA_OBJECTS
 WHERE OWNER = :SourceSchema
   AND OBJECT_TYPE IN ('TRIGGER')
   AND STATUS!='VALID'
ORDER BY OBJECT_NAME
/

SELECT 'CREATE USER '||:TargetSchema||' DEFAULT TABLESPACE APPSMAN9 TEMPORARY TABLESPACE TEMP;'
  FROM DUAL
/

SELECT 'CREATE OR REPLACE EDITIONABLE SYNONYM "'||:TargetSchema||'"."V_$LOCK" FOR "SYS"."V_$LOCK";'
  FROM DUAL
/

SELECT 'CREATE OR REPLACE EDITIONABLE SYNONYM "'||:TargetSchema||'"."V_$SESSION" FOR "SYS"."V_$SESSION";'
  FROM DUAL
/

SELECT 'CREATE OR REPLACE EDITIONABLE SYNONYM "'||:TargetSchema||'"."V$LOCKED_OBJECT" FOR "SYS"."V_$LOCKED_OBJECT";'
 FROM DUAL
/

SELECT 'CREATE OR REPLACE EDITIONABLE SYNONYM /* '||OBJECT_TYPE||' */ '||:TargetSchema||'.'||OBJECT_NAME||' FOR '||OWNER||'.'||OBJECT_NAME||';'
  FROM DBA_OBJECTS
 WHERE OWNER = :SourceSchema
   AND OBJECT_TYPE IN ('TABLE','VIEW','FUNCTION','PROCEDURE','PACKAGE','SEQUENCE')
ORDER BY OBJECT_NAME
/

SELECT 'grant select on v_$session to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant select on v_$lock to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant select on v_$locked_object to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create view to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create procedure to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create trigger to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create table to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create database link to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant execute on dbms_sql to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant execute on dbms_pipe to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant execute on dbms_lock to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant execute on dbms_output to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant alter session to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant create synonym to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant select on v_$sqltext to '||:TargetSchema||';' FROM DUAL
/
SELECT 'grant select on v_$sqltext_with_newlines to '||:TargetSchema||';' FROM DUAL
/
SELECT 'GRANT APPSMAN9_RO_ROLE,APPSMAN9_RW_ROLE,connect,resource TO '||:TargetSchema||';' FROM DUAL
/

SELECT 'EXIT' FROM DUAL
/

SPOOL OFF

QUIT