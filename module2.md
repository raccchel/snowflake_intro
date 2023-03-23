# Query data
In this module, we will use sql queries to explore and modify the dataset.

## Delete the column-name row
When you run ```select * from maternal```, you would find that the first row is the column name of the dataset. That's the row we want to delete. Run following query to delete it:
```
delete from maternal where age = 'Age';
```
