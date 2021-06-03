-- Deploy mbaw:load_data to pg

BEGIN;


	\COPY mbaw.animals FROM 'data/animals.csv' CSV;
	\COPY mbaw.carers FROM 'data/carers.csv' CSV;
	\COPY mbaw.enclosures FROM 'data/enclosures.csv' CSV;
	\COPY mbaw.foods FROM 'data/foods.csv' CSV;
	\COPY mbaw.animal_files FROM 'data/animal_files.csv' CSV;
	\COPY mbaw.hospitalizations FROM 'data/hospitalizations.csv' CSV;
	\COPY mbaw.meals FROM 'data/meals.csv' CSV;
	\COPY mbaw.meal_details FROM 'data/meal_details.csv' CSV;
	\COPY mbaw.animal_meals FROM 'data/animal_meals.csv' CSV;


COMMIT;
