-- Deploy mbaw:insert_meal_procedure to pg

BEGIN;

	CREATE TYPE type_food_offer AS (
		name TEXT,
		offered_qty NUMERIC,
		measure_un TEXT,
		offer_mode TEXT
	);

	-- Function to insert or find a food in food table
	CREATE OR REPLACE FUNCTION mbaw.insert_or_find_food( food_name TEXT )
	RETURNS INT
	LANGUAGE 'plpgsql'
	AS $$
	DECLARE
		selected_row mbaw.foods%rowtype;
		food_id INT;
	BEGIN
		SELECT *
		INTO selected_row
		WHERE name = food_name LIMIT 1;

		IF NOT FOUND THEN
			INSERT INTO mbaw.foods(name) VALUES (food_name)
			RETURNING id INTO food_id;
			RETURN food_id;
		ELSE
			RETURN selected_row.id;
		END IF;

	END;
	$$;

	-- TODO:
	--   Measure unity for each food should be included in meal_details table
	CREATE OR REPLACE PROCEDURE mbaw.insert_feeding_for_animal(
		animal_file_id INT,
		food_array type_food_offer[],
		observations TEXT,
		carer_id INT,
		avaliation WELLNESS,
		total_rest_of_food NUMERIC
	)
	LANGUAGE 'plpgsql'
	AS $BODY$
	DECLARE
		animal_file mbaw.animal_files%rowtype;
		new_meal_id INT;
		food type_food_offer;
		f_id INT;
		total_qty NUMERIC;
		-- variables needed 
	BEGIN
		SELECT *
		INTO animal_file
		FROM mbaw.animal_files
		WHERE id = animal_file_id;

		IF NOT FOUND THEN
			RAISE NOTICE 'Animal file (id:%) could not be found', animal_file_id;
		END IF;

		-- Create a new meal without any extra attributes
		INSERT INTO mbaw.meals(observations, extra_attrs)
		VALUES (observations, NULL)
		RETURNING id
		INTO new_meal_id;

		FOREACH food IN ARRAY food_array LOOP
			-- insert/find and return id of food
			f_id = mbaw.insert_or_find_food(food.name);

			-- insert this food as meal_details for the new_meal
			INSERT INTO mbaw.meal_details(meal_id, food_id, offered_qty, assimilated_qty, offer_mode)
			VALUES
			-- TODO: assimilated_qty is hard-coded 1 because we do not have this info, since rest is for overall total
			(new_meal_id, f_id, food.offered_qty, 1, food.offer_mode);
			-- TODO: this completely disregards units: total should be normalized by unit
			total_qty := total_qty + food.offered_qty;
		END LOOP;

		-- save into animal_meals table
		INSERT INTO mbaw.animal_meals("animal_file_id", "meal_id", "acceptance_avaliation","offered_by")
		VALUES
		(animal_file_id, new_meal_id, avaliation, carer_id);

	END;
	$BODY$;

COMMIT;
