/* FIXME: fk_birth_place isn't created yet (no trace in git diff). */
/* FIXME: geoplace isn't populated yet (no trarce in git diff). */
create table geoplace (
    pk_geoplace integer primary key AUTOINCREMENT,
    name text,
    canton_region text,
    country text,
    continent text,
    notes text,
    class text,
    long_lat text -- valeur WKT: POINT(long lat), long lat étant des nombres avec '.' comme séparateur des décimales
);

alter table person
    add column fk_birth_place integer references geoplace (pk_geoplace);


/* FIXME: understand this */
update
    person
set
    fk_birth_place = -1
where
    birth_place like 'Frib%';

drop view if exists v_birth_place_number;

create view v_birth_place_number as
select
    g.name,
    g.canton_region,
    g.country,
    g.long_lat,
    count(*) as number
from
    person pn
    join geoplace g on g.pk_geoplace = pn.fk_birth_place
where
    g.long_lat is not null
group by
    g.name;

alter table person
    drop column birth_place;
