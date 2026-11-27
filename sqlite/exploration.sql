--- Exploration
select
    g.name,
    g.pk_geoplace,
    g.long_lat
from
    person pn
    join geoplace g on g.pk_geoplace = pn.fk_birth_place
where
    g.long_lat is not null;

--- Exploration
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

-- premières lignes
select
    *
from
    "20170907_persovd" p
limit 30;


/*
 * Vérification des doublons
 * 
 * Apparemment il n'y en a pas, par contre de nombreux homonymes
 * 
 * Objets de la table: personnes (et non mentions de personnes)
 * 
 */
select
    Nom || ', ' || Prenom as appellation
from
    "20170907_persovd" p
limit 30;

-- vérifier s'il y a des doublons
with tw1 as (
    select
        Nom || ', ' || Prenom as appellation
    from
        "20170907_persovd" p
)
select
    appellation,
    count(*) as number
from
    tw1
group by
    appellation
having
    count(*) > 1;

select
    Nom || ', ' || Prenom as appellation,
    p.Date_naiss,
    p.Lieu_naiss,
    p.Dates_vie,
    p.Date_mort,
    p.Profession,
    p.Domaine
from
    "20170907_persovd" p
where
    Nom = 'Besson'
    and p.Prenom = 'Jacques'
order by
    Dates_vie;

select
    Nom || ', ' || Prenom as appellation,
    p.Date_naiss,
    p.Lieu_naiss,
    p.Dates_vie,
    p.Date_mort,
    p.Profession,
    p.Domaine
from
    "20170907_persovd" p
where
    Nom = 'Vallotton' --'André'
    and p.Prenom = 'Paul'
order by
    Dates_vie;


/*
 * Distribution des genres
 */
select
    p.Sexe,
    count(*) as number
from
    "20170907_persovd" p
group by
    p.Sexe;


/*
 * Distribution des années de naissance
 */
select
    p.Date_naiss,
    count(*) as number
from
    "20170907_persovd" p
group by
    p.Date_naiss;

select
    *
from
    "20170907_persovd" p
where
    Date_naiss = 902 -- 14
    select
        date_naiss,
        *
    from
        "20170907_persovd" p
    where
        Date_naiss > 750
        and Date_naiss < 2010
        select
            case when date_naiss > 750
                and Date_naiss < 1401 then
                'moyen-age'
            when date_naiss > 1400
                and Date_naiss < 1551 then
                'renaissance'
            when date_naiss > 1550
                and Date_naiss < 1771 then
                'ancien-regime'
            when date_naiss > 1770
                and Date_naiss < 1880 then
                '19-siecle'
            when date_naiss > 1881 then
                'epoque-contemporaine'
            end epoque
        from
            "20170907_persovd" p
        where
            Date_naiss > 750
            and Date_naiss < 2010;

-- query with order for periods
with epoque as (
    select
        case when date_naiss > 750
            and Date_naiss < 1401 then
            '01->moyen-age'
        when date_naiss > 1400
            and Date_naiss < 1551 then
            '02->renaissance'
        when date_naiss > 1550
            and Date_naiss < 1771 then
            '03->ancien-regime'
        when date_naiss > 1770
            and Date_naiss < 1881 then
            '04->19-siecle'
        when date_naiss > 1880
            and Date_naiss < 1951 then
            '05->20-siecle'
        when date_naiss > 1950 then
            '06->epoque-contemporaine'
        end epoque
    from
        "20170907_persovd" p
    where
        Date_naiss > 750
        and Date_naiss < 2010
)
select
    epoque,
    count(*) as number
from
    epoque
group by
    epoque;


/* Affichage regroupé sur la carte:
 * sélectionner la colonne avec la valeur WKT - point(long lat)
 * Recherche moteur de recherche indique que probablement il n 'y a pas
 * de possibilité d' afficher le diamètre de points en fonction de l 'effectîf
 * Un logiciel de GIS est nécessaire */
select
    *
from
    v_birth_place_number;
