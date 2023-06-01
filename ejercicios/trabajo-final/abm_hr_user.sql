-- Creo el usuario "ABM_HR"
CREATE USER ABM_HR
IDENTIFIED BY "oracle"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK;

-- Otorgar los roles y privilegios necesarios al usuario "ABM_HR"
GRANT CREATE SESSION TO ABM_HR;
GRANT CONNECT, RESOURCE TO ABM_HR;
GRANT SELECT_CATALOG_ROLE TO ABM_HR;