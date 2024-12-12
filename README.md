# catalog

-- Gather
sqlplus / as sysdba <<EOF
START 10_role_plus_grants.sql APEX_240100
START 10_role_plus_grants.sql ORDS_METADATA
QUIT
EOF

sqlplus / as sysdba <<EOF
START 20_create_synonyms.sql APEX_240100 APEX_REST_PUBLIC_USER
START 20_create_synonyms.sql ORDS_METADATA APEX_REST_PUBLIC_USER
START 20_create_synonyms.sql APEX_240100 DUMMY
START 20_create_synonyms.sql ORDS_METADATA DUMMY
QUIT
EOF

sqlplus / as sysdba <<EOF
START 40_drop_public_syns.sql APEX_240100
START 40_drop_public_syns.sql ORDS_METADATA
QUIT
EOF

sqlplus / as sysdba <<EOF
START 50_revoke_from_public.sql APEX_240100
START 50_revoke_from_public.sql ORDS_METADATA
QUIT
EOF



-- Deploy
sqlplus / as sysdba <<EOF
START script_001.sql
QUIT
EOF

GRANT APEX_240100_ROLE TO APEX_REST_PUBLIC_USER;
GRANT APEX_240100_ROLE TO DUMMY;
GRANT ORDS_METADATA_ROLE TO APEX_REST_PUBLIC_USER;
GRANT ORDS_METADATA_ROLE TO DUMMY;

sqlplus / as sysdba <<EOF
START script_002.sql
QUIT
EOF

sqlplus / as sysdba <<EOF
START script_004.sql
QUIT
EOF

sqlplus / as sysdba <<EOF
START script_005.sql
QUIT
EOF

sqlplus / as sysdba <<EOF
START 60_compile_invalid.sql
QUIT
EOF

sqlplus / as sysdba <<EOF
START script_006.sql
QUIT
EOF
