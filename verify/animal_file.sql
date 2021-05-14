-- Verify mbaw:animal_file on pg

BEGIN;

	SELECT id, animal_id, external_code_for_animal, internal_code_for_animal, observations, 
	created_at, modified_at, archived_at, archived
	FROM mbaw.animal_files
	WHERE FALSE;

ROLLBACK;
