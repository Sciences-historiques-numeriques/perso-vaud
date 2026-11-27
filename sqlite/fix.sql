/*
 * Occupations
 */
select
    occupation,
    count(*) as number
from
    t_person_occupation
group by
    occupation
order by
    number desc;

select
    occupation,
    count(*) as number
from
    t_person_occupation
group by
    occupation
having
    occupation like '%criv%';

select
    occupation,
    count(*) as number
from
    t_person_occupation
group by
    occupation
order by
    number desc;

select
    occupation,
    count(*) as number
from
    t_person_occupation
group by
    occupation
having
    occupation like '%ensei%'
order by
    number desc;


/*
 * Ajouter les métiers
 * 
 * Métiers traités: écrivain, enseignant
 */
select
    Numero,
    Nom,
    occupation,
    fk_occupation
from
    t_person_occupation
where
    occupation like '%ensei%';

update
    t_person_occupation
set
    fk_occupation = 2 -- TODO: no hard-coded foreign key
where
    occupation like '%ensei%';


/*
 * Domaines
 */
select
    domain,
    count(*) as number
from
    t_person_domain
group by
    domain
having
    domain like 'Photo%';
