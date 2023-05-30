declare
  	p_nom_archivo varchar2(200);
 	 p_ruta varchar2(200);
begin
 	 p_nom_archivo := 'empleados_';
 	p_ruta := 'REPORTES';
  	hr_pack.emp_report(p_nom_archivo => p_nom_archivo,p_ruta => p_ruta);
end;