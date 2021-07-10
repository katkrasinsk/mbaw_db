-- Revert mbaw:feeding_functions from pg

BEGIN;

    DROP FUNCTION IF EXISTS mbaw.feeding_history;
    DROP VIEW IF EXISTS mbaw.animal_feed_history;

COMMIT;
