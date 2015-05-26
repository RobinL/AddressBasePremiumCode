These files implement the instructions in the 
[getting started guide](https://www.ordnancesurvey.co.uk/docs/user-guides/addressbase-products-getting-started-guide.pdf) in SQL rather than having to follow through the instructions on pgAdmin.

You will need to update references to your database and the place on your disk where you're storing the .csvs

There is also some SQL for creating full single line address fields from the data.

Run in the following order:

1. Run AddressBasePremium_RecordSplitter.py (this is an unaltered copy of the script provided by OS)
2. Run AddressBasePremium delete final newline.py on your csvs to get rid of the final newline as advised in the getting started guide
3. Run PostgreSQL_AddressBase_Premium_CreateTable.sql.  You will need to update the file paths to the location of the csv files on your machine. 

If you want a useful table of all geographic (i.e. non delivery point) addresses, use create_useful_table.sql

If you want a useful table of all delivery point addresses, use create_delivery_point_useful_table.sql

If you want a table of all addresses e.g. for the purpose of address matching use create_all_addresses_table_and_frequencies.sql

Use at your own risk - I welcome any corrections. 

