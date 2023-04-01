SELECT * 
FROM MATERNAL_HEALTH.PUBLIC.MATERNAL;


SELECT * FROM MATERNAL_HEALTH.PUBLIC.MATERNAL_TEMP;


SELECT * FROM MATERNAL_HEALTH.PUBLIC.MATERNAL_DEV;


SELECT * FROM CHECK_DATE.PUBLIC.JSON_DATE_DATA_VIEW;


select 
mat.user_id,
mat.age,
v.date
from maternal_health.public.maternal_temp as mat
left outer join check_date.public.json_date_data_view as v
on mat.user_id = v.user_id;