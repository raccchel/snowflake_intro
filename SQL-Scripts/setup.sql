--SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CALL_CENTER


--CREATE DATABASE MATERNAL_HEALTH
-- Age,SystolicBP,DiastolicBP,BS,BodyTemp,HeartRate,RiskLevel
CREATE TABLE MATERNAL (
    AGE varchar(50)
    ,systolicBP varchar(50)
    ,diastolicBP varchar(50)
    ,BS varchar(50)
    ,BodyTemp varchar(50)
    ,HeartRate varchar(50)
    ,RiskLevel varchar(50)
);

CREATE OR REPLACE STAGE my_azure_stage
  URL='azure://maternal.blob.core.windows.net/maternaldb/'
  CREDENTIALS=(AZURE_SAS_TOKEN='ADD SAS TOKEN HERE');

CREATE OR REPLACE STAGE my_azure_stage02
  URL='azure://adls2snowmelt.blob.core.windows.net/snowdemo'
  CREDENTIALS=(AZURE_SAS_TOKEN='ADD SAS TOKEN HERE');
 

list @my_azure_stage;


create or replace file format csv type='csv'
  compression = 'auto' field_delimiter = ',' record_delimiter = '\n'
  skip_header = 0 field_optionally_enclosed_by = '\042' trim_space = false
  error_on_column_count_mismatch = false escape = 'none' escape_unenclosed_field = '\134'
  date_format = 'auto' timestamp_format = 'auto' null_if = ('') comment = 'file format for ingesting data for zero to snowflake';


show file formats in database maternal_health;

copy into maternal from @my_azure_stage file_format=csv PATTERN = '.*csv.*' ;

--Create a Maternal_temp table addigna  new column IDENTITY
CREATE TABLE MATERNAL_TEMP AS
SELECT *, ROW_NUMBER() OVER (ORDER BY AGE) AS IDENTITY FROM MATERNAL;

--Rename IDENTITY Column to USER_ID
ALTER TABLE MATERNAL_TEMP RENAME COLUMN IDENTITY TO USER_ID;

--CREATE a new table maternal_dev using CLONE from maternal_temp
CREATE TABLE MATERNAL_DEV  CLONE maternal_temp;

--CREATE NEW DATABASE IF NOT EXISTS CHECK_DATE
CREATE DATABASE IF NOT EXISTS CHECK_DATE;



USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE CHECK_DATE;
USE Schema PUBLIC;



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

