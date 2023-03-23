# Load data 
In this module, we will go through how to load data from Azure blob storage to Snowflake.

## Create a database and a table
First, let's create a database called ```MATERNALHEALTH``` to use for loading the structured data.

Ensure you are using the sysadmin role by selecting Switch Role > SYSADMIN.

Navigate to the Databases tab. Click Create, name the database ```MATERNALHEALTH```, then click CREATE.

![create database](image/1.1.png)

Select the following context settings:

Role: ```SYSADMIN``` Warehouse: ```COMPUTE_WH```

![create database](image/1.2.png)

Next, in the drop-down for the database, select the following context settings:

Database: ```CITIBIKE``` Schema = ```PUBLIC```

![create database](image/1.3.png)

To make working in the worksheet easier, let's rename it. In the top left corner, click the worksheet name, which is the timestamp when the worksheet was created, and change it to ```MATERNAL_ZERO_TO_SNOWFLAKE```.

Next we create a table called ```MATERNAL``` to use for loading the comma-delimited data. Instead of using the UI, we use the worksheet to run the DDL that creates the table. Copy the following SQL text into your worksheet:

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
```

Navigate to the Databases tab by clicking the HOME icon in the upper left corner of the worksheet. Then click Data > Databases. In the list of databases, click ```MATERNALHEALTH``` > ```PUBLIC``` > TABLES to see your newly created ```MATERNAL``` table. If you don't see any databases on the left, expand your browser because they may be hidden.

![create database](image/1.4.png)



## References
https://quickstarts.snowflake.com/guide/getting_started_with_snowflake/index.html#3
https://quickstarts.snowflake.com/guide/getting_started_with_snowflake/index.html#4
