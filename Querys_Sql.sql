-- QUERYS --
-- UNIVERSIDAD --
use universidad;

Select * from departamento;

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom

Select p.apellido1, p.apellido2, p.nombre from persona p
where p.tipo = 'alumno'
order by p.apellido1, p.apellido2,p.nombre ASC;


-- 2. Esbrina el nom i els dos cognoms dels alumnes 
-- que no han donat d'alta el seu número de telèfon en la base de dades. (nombre, apellido1, apellido2)

Select p.nombre , p.apellido1, p.apellido2 from persona p
Where p.telefono IS NULL AND p.tipo = 'alumno';

-- 3. Retorna el llistat dels alumnes que van néixer en 1999. (id, nombre, apellido1, apellido2, fecha_nacimiento)

Select p.id, p.nombre, p.apellido1, p.apellido2, p.fecha_nacimiento from persona p
Where p.tipo = 'alumno' AND YEAR( p.fecha_nacimiento ) = 1999;


-- 4. Retorna el llistat de professors/es que 
-- no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K. 
-- (nombre, apellido1, apellido2, nif)

SELECT p.nombre, p.apellido1, p.apellido2,p.nif from persona p
Where p.tipo = 'profesor' AND p.nif LIKE "%K";


-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, 
-- en el tercer curs del grau que té l'identificador 7. (id, nombre, cuatrimestre, curso, id_grado)
Select * from asignatura a 
where cuatrimestre = 1 AND a.id_grado = 7;


-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom. (apellido1, apellido2, nombre, departamento)

Select p.apellido1,p.apellido2,p.nombre,d.nombre from persona p
JOIN profesor pr on pr.id_profesor = p.id
JOIN departamento d on d.id = pr.id_departamento
ORDER BY p.apellido1, p.apellido2,p.nombre ASC;


-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M. (nombre, anyo_inicio, anyo_fin)

Select a.nombre, ce.anyo_inicio, ce.anyo_fin from persona p
JOIN alumno_se_matricula_asignatura ama on ama.id_alumno = p.id
JOIN curso_escolar ce on ce.id = ama.id_curso_escolar
JOIN asignatura a on a.id = ama.id_asignatura
where p.nif = '26902806M';



-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen
-- alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015). (nombre)

Select d.nombre from departamento d
JOIN profesor p on p.id_departamento = d.id
JOIN asignatura a on a.id_profesor = p.id_profesor
JOIN grado g on g.id = a.id_grado
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)' AND a.id_profesor IS NOT NULL;







