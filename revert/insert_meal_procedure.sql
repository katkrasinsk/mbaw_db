-- Revert mbaw:insert_meal_procedure from pg

BEGIN;

	DROP PROCEDURE mbaw.insert_feeding_for_animal;
	DROP FUNCTION mbaw.insert_or_find_food;
	DROP TYPE TYPE type_food_offer;

COMMIT;
