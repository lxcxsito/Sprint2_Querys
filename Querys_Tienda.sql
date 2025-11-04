-- QUERYS --
-- TIENDA --


use tienda;


-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
Select producto.nombre from producto;


-- 2. Llista els noms i els preus de tots els productes de la taula producto.
Select p.nombre, p.precio from producto p;

-- 3. Llista totes les columnes de la taula producto.
select * from producto;

-- 4. Llista el nom dels productes, el preu en euros (precio_eur) i el preu en dòlars estatunidencs (precio_usd) amb un tipus de canvi de 1 € = 1 $.
select p.precio as precio_eur, p.precio as precio_usd from producto p;

-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (amb un tipus de canvi de 1 € = 1,1 $ i arrodonint el resultat a dues xifres decimals). 
-- Utilitza els següents àlies per a les columnes: nom del producte, euros, dòlars.

select p.nombre ,p.precio as euros, Round(p.precio * 1.1,2) as dòlars from producto p;






-- 6. Llista els noms (nombre) i els preus de tots els productes de la taula producto, convertint els noms a majúscula.




-- 7. Llista els noms (nombre) i els preus (precio) dels productes de la taula producto, convertint els noms a minúscula.
-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant (iniciales).
-- 9. Llista els noms i els preus dels productes, arrodonint el valor del preu (precio)
-- 10. Llista els noms i els preus de tots els productes (precio truncado) de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.