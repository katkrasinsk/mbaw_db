-- Revert mbaw:load_data from pg

BEGIN;

	DELETE FROM mbaw.animal_files
	WHERE internal_code_for_animal = 11 or internal_code_for_animal = 12;
	DELETE FROM mbaw.animals
	WHERE scientific_name = 'Thalaceus' or scientific_name = 'Sula Leucogaste';

COMMIT;
