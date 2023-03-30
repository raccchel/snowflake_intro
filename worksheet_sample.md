```
-- create a table
create table maternal(
    Age varchar(50),
    SystolicBP varchar(50),
    DiastolicBP varchar(50),
    BS varchar(50),
    BodyTemp varchar(50),
    HeartRate varchar(50),
    RiskLevel varchar(200)
);


-- create an external stage
--Method 1: Create integration object from external stage
/*
CREATE STORAGE INTEGRATION azure_int1
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'AZURE'
  ENA
  BLED = TRUE
  AZURE_TENANT_ID = '16b3c013-d300-468d-ac64-7eda0820b6d3'
  STORAGE_ALLOWED_LOCATIONS = ('azure://maternal.blob.core.windows.net/maternaldb/');

DESC STORAGE INTEGRATION azure_int1;
*/

--Method 2: Create an external stage through SAS Token
CREATE OR REPLACE STAGE my_azure_stage
  URL='azure://maternal.blob.core.windows.net/maternaldb/'
  CREDENTIALS=(AZURE_SAS_TOKEN='?sv=2021-12-02&ss=bfqt&srt=co&sp=rwdlacupiytfx&se=2023-03-24T16:05:41Z&st=2023-03-15T08:05:41Z&spr=https&sig=CaQjjx3bXbg9dNpDmPLRI97pesG607WwZAl2vW%2BaP5Q%3D');

list @my_azure_stage;


--create file format
create or replace file format csv type='csv'
  compression = 'auto' field_delimiter = ',' record_delimiter = '\n'
  skip_header = 0 field_optionally_enclosed_by = '\042' trim_space = false
  error_on_column_count_mismatch = false escape = 'none' escape_unenclosed_field = '\134'
  date_format = 'auto' timestamp_format = 'auto' null_if = ('') comment = 'file format for ingesting data for zero to snowflake';

--verify file format is created
show file formats in database maternalhealth;


-- load data
copy into maternal from @my_azure_stage file_format=csv PATTERN = '.*csv.*' ;


delete from maternal where age = 'Age';

drop table maternal_temp;
CREATE TABLE maternal_temp LIKE maternal;
ALTER TABLE maternal_temp ADD Column User_id int IDENTITY(1,1);

INSERT INTO maternal_temp 
(Age,
SystolicBP,
DiastolicBP,
BS,
BodyTemp,
HeartRate,
RiskLevel)
SELECT 
Age,
SystolicBP,
DiastolicBP,
BS,
BodyTemp,
HeartRate,
RiskLevel
FROM maternal;


-- query data
select * from maternal_temp limit 20;

select count(*) from maternal where age >= '18' and age <= '35';


-- clone a table 
create table maternal_dev clone maternal;


-- work with json data
use role accountadmin;
use warehouse compute_wh;
use database check_date;
use schema public;

drop table json_date_data;
create table json_date_data (v variant);

insert into json_date_data
select
parse_json(
'{
      "user_id":"2",
      "date":"2023/3/20",
}');

create or replace view json_date_data_view as
select
    v:user_id::int as user_id,
    v:date::string as date
from json_date_data;

select * from json_date_data_view;

select 
mat.user_id,
mat.age,
v.date
from maternalhealth.public.maternal_temp as mat
left outer join json_date_data_view as v
on mat.user_id = v.user_id;
```
