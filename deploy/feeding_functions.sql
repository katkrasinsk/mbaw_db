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

COMMIT;
