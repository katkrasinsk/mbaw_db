-- Deploy mbaw:load_data to pg

BEGIN;

	-- Atoba and a file for it
	WITH ins AS (
		INSERT INTO mbaw.animals
			(popular_name, scientific_name)
		VALUES
			('Atoba', 'Sula Leucogaste')
		RETURNING id 
	)
	INSERT INTO mbaw.animal_files
		(animal_id, internal_code_for_animal, observations)
	VALUES
		( ( SELECT id FROM ins ), 11, 'Inserido para teste' );

	-- Trinta reis and a file for it
	WITH ins2 AS (
		INSERT INTO mbaw.animals
			(popular_name, scientific_name)
		VALUES
			('Trinta reis', 'Thalaceus')
		RETURNING id
	)
	INSERT INTO  mbaw.animal_files
		(animal_id, internal_code_for_animal, observations )
	VALUES
		( ( SELECT id FROM ins2 ), 12, 'Inserido para teste' );

COMMIT;
