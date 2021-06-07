-- Revert mbaw:add_photo_to_animal_files from pg

BEGIN;

	ALTER TABLE mbaw.animal_files
	DROP COLUMN "original_image",
	DROP COLUMN "small_img"; 

COMMIT;
