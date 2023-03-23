# Reset your Snowflake environment
Remember to clean up all the resources you created to avoid additional cost after this lab.

First, ensure you are using the ACCOUNTADMIN role in the worksheet:
```
use role accountadmin;
```

Then, run the following SQL commands to drop all the objects we created in the lab:
```
drop database if exists maternalhealth;

drop database if exists check_date;

drop warehouse if exists analytics_wh;
```
