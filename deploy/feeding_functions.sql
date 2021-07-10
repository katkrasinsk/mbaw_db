-- Deploy mbaw:feeding_functions to pg

BEGIN;


    /*
    *  Searches for entire animal feeding history, grouping
    *  feed details.
    *
    *  @Parameters: INTEGER: animal file id
    *
    *  @Returns: Array of JSON objects.
    *
    *  Example:
    *
    *  select * from mbaw.feeding_history(1):
    *   [
    *      {
    *         "animal_file_id" : 1,
    *         "interval" : "148 days 12:03:27.413328",
    *         "meal_details" : [
    *            {
    *               "food_name" : "banana",
    *               "offer_mode" : "descascada",
    *               "offered_qty" : 5
    *            },
    *            {
    *               "food_name" : "maça",
    *               "offer_mode" : "pedacao",
    *               "offered_qty" : 30
    *            }
    *         ],
    *         "observations" : "refeição para animal de id 1",
    *         "offered_at" : "2021-02-08T13:01:20",
    *         "offered_by" : 1,
    *         "total_rest" : 20
    *      },
    *      {
    *         "animal_file_id" : 1,
    *         "interval" : "179 days 12:03:27.413328",
    *         "meal_details" : [
    *            {
    *               "food_name" : "banana",
    *               "offer_mode" : "nanica",
    *               "offered_qty" : 3
    *            },
    *            {
    *               "food_name" : "fortress",
    *               "offer_mode" : "de qq jeito",
    *               "offered_qty" : 233
    *            }
    *         ],
    *         "observations" : "refeição para animal de id 1",
    *         "offered_at" : "2021-01-08T13:01:20",
    *         "offered_by" : 2,
    *         "total_rest" : 30
    *      }
    *   ]
    *
    */

    CREATE OR REPLACE FUNCTION mbaw.feeding_history(IN INT)
    RETURNS TABLE(history JSON) AS 
    $FUNC$
        SELECT json_agg(t) AS all_meals
        FROM (
            SELECT animal_file_id,
                   observations,
                   total_rest,
                   offered_at,
                   offered_by,
                   floor( extract(epoch from age(offered_at))/3600 ) AS interval_hours, -- in hours
                   meal_details
            FROM mbaw.animal_meals am JOIN mbaw.meals m ON (am.meal_id = m.id)
            CROSS JOIN LATERAL (
                SELECT json_agg(details) AS meal_details
                FROM (
                    SELECT offer_mode, offered_qty, name as food_name
                    FROM mbaw.meal_details JOIN mbaw.foods f
                         ON( food_id = f.id )
                    WHERE meal_id = am.meal_id
                ) details
            ) s
            WHERE animal_file_id = $1
        )t
        GROUP BY animal_file_id;
    $FUNC$
    LANGUAGE SQL;

    COMMENT ON FUNCTION mbaw.feeding_history(INT) IS
'Description: Returns all feeding events associated with animal file
@Paramenters: $1- mbaw.animal_files.id
@Returns: JSON';

    /*
    *
    * View related to all feed history to all animals file.
    *
    */
    CREATE OR REPLACE VIEW mbaw.animal_feed_history AS
    WITH animal_meal_details AS (
        SELECT animal_file_id, am.meal_id,
               json_agg(md) AS meal_details
        FROM mbaw.animal_meals am LEFT JOIN 
             ( SELECT f.name as food_name
                  , f.is_medication
                  , f.is_supplementation
                  , f.is_normal
                  , f.nutrients
                  , f.provider
                  , d.offer_mode
                  , d.offered_qty
                  , d.unit
                  , d.meal_id
            FROM mbaw.meal_details d JOIN mbaw.foods f ON (d.food_id = f.id) 
             ) md ON (md.meal_id = am.meal_id)
        GROUP BY animal_file_id, am.meal_id
    ) SELECT amd.animal_file_id
         , amd.meal_id, observations
         , total_rest
         , offered_at
         , floor(extract(epoch from age(offered_at))/3600) AS hours_ago
         , meal_details
    FROM animal_meal_details amd
         JOIN mbaw.meals m ON (amd.meal_id = m.id) 
         JOIN mbaw.animal_meals am ON( amd.meal_id = am.meal_id);

COMMIT;
