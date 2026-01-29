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
where cuatrimestre = 1 AND a.id_grado = 7 AND a.curso = 3;


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
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor p ON p.id_departamento = d.id
JOIN asignatura a ON a.id_profesor = p.id_profesor
JOIN grado g ON g.id = a.id_grado
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';



-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019. (nombre, apellido1, apellido2)
select p.nombre,p.apellido1,p.apellido2 from persona p
JOIN alumno_se_matricula_asignatura ams on ams.id_alumno = p.id
JOIN curso_escolar ce on ce.id = ams.id_curso_escolar
WHERE ce.anyo_inicio = 2018 && ce.anyo_fin = 2019
GROUP BY  p.nombre,p.apellido1,p.apellido2;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 10. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a.
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. (departamento, apellido1, apellido2, nombre)
select d.nombre, p.apellido1, p.apellido2, p.nombre  from persona p
LEFT JOIN departamento d on p.id = d.id
WHERE p.tipo = 'profesor'
ORDER BY d.nombre, p.apellido1,p.apellido2,p.nombre ASC;



-- 11. Retorna un llistat amb els professors/es que no estan associats a un departament. (apellido1, apellido2, nombre)
SELECT ps.apellido1, ps.apellido2, ps.nombre
FROM profesor p
LEFT JOIN persona ps ON p.id = ps.id
WHERE p.id_departamento IS NULL;




-- 12. Retorna un llistat amb els departaments que no tenen professors/es associats. (nombre)
Select d.nombre from departamento d
LEFT JOIN profesor p on p.id_departamento = d.id
WHERE p.id_departamento is NULL;


-- 13. Retorna un llistat amb els professors/es que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
Select prs.apellido1,prs.apellido2,prs.nombre from profesor p
LEFT JOIN asignatura a on p.id_profesor = a.id_profesor
JOIN persona prs on prs.id = p.id_profesor
WHERE a.id_profesor IS NULL
GROUP BY prs.apellido1,prs.apellido2,prs.nombre;

	

-- 14. Retorna un llistat amb les assignatures que no tenen un professor/a assignat. (id, nombre)
Select a.id, a.nombre from asignatura a 
LEFT JOIN profesor p on p.id_profesor = a.id_profesor
where a.id_profesor is null;



-- 15. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar. (nombre)
select d.nombre from departamento d
left join profesor p on p.id_departamento = d.id
LEFT join asignatura a on a.id_profesor = p.id_profesor
WHERE a.curso is NULL
GROUP BY d.nombre;





-- 16. Retorna el nombre total d'alumnes que hi ha. (total)
Select Count(*) as total_alumnes from persona p
where p.tipo = 'alumno';


-- 17. Calcula quants alumnes van néixer en 1999. (total)
select Count(*) from persona p
where YEAR(p.fecha_nacimiento) = 1999;


-- 18. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament 
-- i una altra amb el nombre de professors/es que hi ha en aquest departament.
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es. (departamento, total)
SELECT d.nombre AS departamento,COUNT(p.id) AS total
FROM departamento d
JOIN profesor p ON p.id_departamento = d.id
GROUP BY d.nombre
ORDER BY total DESC;



-- 19. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. (departamento, total)
select d.nombre , COUNT(prs.nombre) as total from departamento d
LEFT join profesor p on p.id_departamento = d.id
LEFT JOIN persona prs on prs.id = p.id_profesor
group by d.nombre;






-- 20. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat.
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures. (grau, total)
select g.nombre,Count(a.id_grado) as total from grado g
LEFT JOIN asignatura a on a.id_grado = g.id
group by g.nombre
Order by total DESC;


-- 21. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, 
-- dels graus que tinguin més de 40 assignatures associades. (grau, total)
select g.nombre, Count(a.id_grado) as total from grado g
LEFT JOIN asignatura a on a.id_grado = g.id
group by g.nombre
HAVING total > 40;



-- 22. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
-- El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. (grau, tipus, total_creditos)

select g.nombre, a.tipo,SUM(a.creditos) as total_creditos from grado g
LEFT JOIN asignatura a on a.id_grado = g.id
group by g.nombre, a.tipo, a.creditos;


-- 23. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats. (anyo_inicio, total)

Select ce.anyo_inicio, COUNT(distinct ams.id_alumno) AS total from persona p 
LEFT JOIN alumno_se_matricula_asignatura ams on ams.id_alumno = p.id
LEFT JOIN curso_escolar ce on ce.id = ams.id_curso_escolar
group by ce.anyo_inicio;



-- 24. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
-- El resultat estarà ordenat de major a menor pel nombre d'assignatures. (id, nombre, apellido1, apellido2, total)
Select prs.id, prs.nombre,prs.apellido1, prs.apellido2, Count(a.id) as total from asignatura a 
LEFT JOIN profesor p on p.id_profesor = a.id_profesor
LEFT JOIN persona prs on prs.id = p.id_profesor
group by prs.id, prs.nombre,prs.apellido1, prs.apellido2
order by total DESC;

select * from persona;


-- 25. Retorna totes les dades de l'alumne/a més jove. (*)
SELECT * FROM persona p
ORDER BY p.fecha_nacimiento DESC
LIMIT 1;



-- 26. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
SELECT prs.apellido1, prs.apellido2, prs.nombre FROM profesor p 
JOIN persona prs on prs.id = p.id_profesor
JOIN departamento d on d.id = p.id_departamento
LEFT JOIN asignatura a on a.id_profesor = p.id_profesor
WHERE a.id_profesor is NULL




-- 






