-- Creo el directorio --
CREATE DIRECTORY reportes AS '/tmp/curso_ora/reportes';

-- Doy permisos a HR --
GRANT READ ON DIRECTORY reportes TO HR; 
GRANT WRITE ON DIRECTORY reportes TO HR;
