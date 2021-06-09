-- some queries to perform for testing

insert into mbaw.animals(popular_name, scientific_name) VALUES ( 'pinguim magalhaes', 'S. magellanicus' );


create or replace function mbaw.noop( msg TEXT )
returns TEXT
language 'plpgsql'
as $noop$
BEGIN
				select 'echo ' || msg;
END;
$noop$;

select noop('test')
