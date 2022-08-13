How to run the code?
For the execution of code, these steps need to be f0llowed -
1) Opening MySQL, and running the script.sql file for the creation of the database and inserting the mandatory files for the input
2) Script.sql contains the queries commented that are executed using quiz.py 
3) Now, open quiz.py file and scroll to line 73. Here, change host, user and password according to your sql server.
4) if you make changes in the name of the database. Then, please change line 77 also i.e. database field.
5) Now, run quiz.py using python with the command
--> python quiz.py
before this step, it should be made sure that python 3.X.X, mysql.connector and numpy are installed.
