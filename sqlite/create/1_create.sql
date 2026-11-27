/* create.sql - create the database and import source data. */
/* The CSV actually is a TSV, so we set TSV mode. (Equivalent to `.mode "\t"`.) */
.mode tabs
/* Import TSV file into a new temporary table, creating column names from header. */
.import "./source_data/20170907_persovd.csv" source_data
/* Create a table with English column names and specific datatypes. */
create table "person" (
    pk_person integer primary key autoincrement,
    last_name varchar(50),
    first_name varchar(50),
    other_last_name varchar(50),
    other_first_name varchar(50),
    gender varchar(50),
    life_dates nvarchar (50),
    birth_place varchar(50),
    birth_date integer,
    birth_date_complete nvarchar (50),
    death_date integer,
    death_date_complete nvarchar (50),
    alive boolean,
    occupation varchar(256),
    field varchar(256),
    valdensia1 varchar(50),
    valdensia2 nvarchar (50),
    creation_date nvarchar (50),
    modification_date nvarchar (50),
    signature varchar(50),
    wikipedia integer,
    archivebn integer
);


/* Insert data into our table with specified types and english names. */
insert into person (
    pk_person,
    last_name,
    first_name,
    other_last_name,
    other_first_name,
    gender,
    life_dates,
    birth_place,
    birth_date,
    birth_date_complete,
    death_date,
    death_date_complete,
    alive,
    occupation,
    field,
    valdensia1,
    valdensia2,
    creation_date,
    modification_date,
    signature,
    wikipedia,
    archivebn)
select
    Numero,
    Nom,
    Prenom,
    Autre_nom,
    Autre_prenom,
    Sexe,
    Dates_vie,
    Lieu_naiss,
    Date_naiss,
    Date_naiss_complete,
    Date_mort,
    Date_mort_complete,
    Vivant,
    Profession,
    Domaine,
    Valdensia1,
    Valdensia2,
    Date_creation,
    Date_modification,
    Signature,
    Wikipedia,
    ArchiveBN
from
    source_data;


/* remove the temporary table */
drop table source_data;
