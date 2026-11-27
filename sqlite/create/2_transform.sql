/* transform.sql - transform the data.
 *
 * 1. trim birth place.
 * 2. create many-to-many join tables:
 *   2.a. t_person_field
 *   2.b. t_person_occupation
 */
update
    person
set
    birth_place = trim(birth_place);

create table occupation (
    pk_occupation integer primary key AUTOINCREMENT,
    name text,
    definition text,
    notes text
);

create table t_person_occupation (
    fk_person integer references person (pk_person),
    occupation varchar,
    fk_occupation integer references occupation (pk_occupation)
);

create table field (
    pk_field integer primary key AUTOINCREMENT,
    name text,
    definition text,
    notes text
);

create table t_person_field (
    fk_person integer references person (pk_person),
    field varchar,
    fk_field integer references field (pk_field)
);

insert into t_person_field with recursive splitter as (
    select
        p.pk_person,
        case when (instr (field, '/')) > 0 then
            substr(p.field, 1, instr (p.field, '/') - 1)
        else
            field
        end part,
        case when instr (field, '/') > 0 then
            substr(p.field, instr (p.field, '/') + 1)
        else
            ''
        end remainder
    from
        "person" p
    union all
    select
        pk_person,
        case when (instr (remainder, '/')) > 0 then
            substr(remainder, 1, instr (remainder, '/') - 1)
        else
            remainder
        end part,
        case when instr (remainder, '/') > 0 then
            substr(remainder, instr (remainder, '/') + 1)
        else
            ''
        end remainder
    from
        splitter
    where
        remainder != ''
)
select
    pk_person,
    trim(part) as field,
    0 as fk_field
from
    splitter
order by
    pk_person;

insert into t_person_occupation with recursive splitter as (
    select
        p.pk_person,
        case when (instr (occupation, '/')) > 0 then
            substr(p.occupation, 1, instr (p.occupation, '/') - 1)
        else
            occupation
        end part,
        case when instr (occupation, '/') > 0 then
            substr(p.occupation, instr (p.occupation, '/') + 1)
        else
            ''
        end remainder
    from
        "person" p
    union all
    select
        pk_person,
        case when (instr (remainder, '/')) > 0 then
            substr(remainder, 1, instr (remainder, '/') - 1)
        else
            remainder
        end part,
        case when instr (remainder, '/') > 0 then
            substr(remainder, instr (remainder, '/') + 1)
        else
            ''
        end remainder
    from
        splitter
    where
        remainder != ''
)
select
    pk_person as fk_person,
    trim(part) occupation,
    0 as fk_occupation
from
    splitter
order by
    pk_person;

insert into occupation (
    name)
select distinct
    occupation
from
    t_person_occupation;

alter table person
    drop column occupation;

alter table person
    drop column field;
