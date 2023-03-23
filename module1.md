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
