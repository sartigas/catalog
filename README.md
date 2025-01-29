<p>-- Gather<br />sqlplus / as sysdba &lt;&lt;EOF<br />START 10_role_plus_grants.sql APEX_230200<br />START 10_role_plus_grants.sql ORDS_METADATA<br />START 10_role_plus_grants.sql FLOWS_FILES<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 11_back_to_public.sql APEX_230200<br />START 11_back_to_public.sql ORDS_METADATA<br />START 11_back_to_public.sql FLOWS_FILES<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 20_create_synonyms.sql APEX_230200 APEX_REST_PUBLIC_USER<br />START 20_create_synonyms.sql ORDS_METADATA APEX_REST_PUBLIC_USER<br />START 20_create_synonyms.sql APEX_230200 DUMMY<br />START 20_create_synonyms.sql ORDS_METADATA DUMMY<br />START 20_create_synonyms.sql APEX_230200 APEX_LISTENER<br />START 20_create_synonyms.sql ORDS_METADATA APEX_LISTENER<br />START 20_create_synonyms.sql APEX_230200 ORDS_PUBLIC_USER<br />START 20_create_synonyms.sql ORDS_METADATA ORDS_PUBLIC_USER<br />START 20_create_synonyms.sql APEX_230200 APEX_PUBLIC_USER<br />START 20_create_synonyms.sql ORDS_METADATA APEX_PUBLIC_USER<br />START 20_create_synonyms.sql APEX_230200 FLOWS_FILES<br />START 20_create_synonyms.sql ORDS_METADATA FLOWS_FILES<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 40_drop_public_syns.sql APEX_230200<br />START 40_drop_public_syns.sql ORDS_METADATA<br />START 40_drop_public_syns.sql FLOWS_FILES<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 50_revoke_from_public.sql APEX_230200<br />START 50_revoke_from_public.sql ORDS_METADATA<br />START 50_revoke_from_public.sql FLOWS_FILES<br />QUIT<br />EOF</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>-- Deploy<br />sqlplus / as sysdba &lt;&lt;EOF<br />START script_001.sql<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />GRANT APEX_230200_ROLE TO APEX_REST_PUBLIC_USER;<br />GRANT APEX_230200_ROLE TO DUMMY;<br />GRANT APEX_230200_ROLE TO APEX_LISTENER;<br />GRANT APEX_230200_ROLE TO ORDS_PUBLIC_USER;<br />GRANT APEX_230200_ROLE TO APEX_PUBLIC_USER;<br />GRANT APEX_230200_ROLE TO FLOWS_FILES;<br />GRANT ORDS_METADATA_ROLE TO APEX_REST_PUBLIC_USER;<br />GRANT ORDS_METADATA_ROLE TO DUMMY;<br />GRANT ORDS_METADATA_ROLE TO APEX_LISTENER;<br />GRANT ORDS_METADATA_ROLE TO ORDS_PUBLIC_USER;<br />GRANT ORDS_METADATA_ROLE TO APEX_PUBLIC_USER;<br />GRANT ORDS_METADATA_ROLE TO FLOWS_FILES;<br />ALTER USER "DUMMY" DEFAULT ROLE "APEX_230200_ROLE", "ORDS_METADATA_ROLE";<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_004.sql<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_005.sql<br />QUIT<br />EOF</p>
<p>REVOKE EXECUTE ON /* PACKAGE */ "APEX_230200"."WWV_FLOW_DEBUG_API" FROM PUBLIC;<br />REVOKE EXECUTE ON /* PACKAGE */ "APEX_230200"."WWV_FLOW_PLUGIN_UTIL" FROM PUBLIC;</p>
<p>REVOKE EXECUTE ON /* PACKAGE */ "APEX_230200"."WWV_FLOW" FROM PUBLIC;<br />REVOKE EXECUTE ON /* TYPE */ "ORDS_METADATA"."T_ORDS_MODULE" FROM PUBLIC;</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_002.sql<br />CREATE OR REPLACE NONEDITIONABLE SYNONYM "FLOWS_FILES"."WWV_FLOW_FILE_API" FOR "APEX_240200"."WWV_FLOW_FILE_API";<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 60_compile_invalid.sql<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_006.sql<br />QUIT<br />EOF</p>
<p>&nbsp;</p>
<p>-- Make default roles those granted to workspace</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><br />-- ROLLBACK</p>
<p>mv $ORACLE_HOME/apex $ORACLE_HOME/apex23<br />unzip apex_24.2.zip "apex/*" -d $ORACLE_HOME</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START 10_drop_priv_syns.sql APEX_230200 28-JAN-25<br />QUIT<br />EOF</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_001.sql<br />QUIT<br />EOF</p>
<p>DROP ROLE APEX_230200_ROLE;<br />DROP ROLE ORDS_METADATA_ROLE;</p>
<p>-- Unlock APEX_PUBLIC_USER<br />ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;</p>
<p>CREATE OR REPLACE NONEDITIONABLE SYNONYM "FLOWS_FILES"."WWV_FLOW_FILE_API" FOR "APEX_240200"."WWV_FLOW_FILE_API";</p>
<p>sqlplus / as sysdba &lt;&lt;EOF<br />START script_011.sql<br />QUIT<br />EOF</p>
<p>-- Go to version 24<br />@apexins.sql APEX APEX_FILES TEMP /i/</p>
<p><br />-- Install latest patch<br />NLS_LANG=American_America.AL32UTF8<br />export NLS_LANG</p>
<p>sqlplus / as sysdba @catpatch.sql</p>
<p>&nbsp;</p>
<p>&nbsp;</p>