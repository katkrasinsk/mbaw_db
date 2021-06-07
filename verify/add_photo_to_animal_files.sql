-- Verify mbaw:add_photo_to_animal_files on pg

BEGIN;

	SELECT original_image, small_img
	FROM mbaw.animal_files
	WHERE FALSE;

ROLLBACK;
