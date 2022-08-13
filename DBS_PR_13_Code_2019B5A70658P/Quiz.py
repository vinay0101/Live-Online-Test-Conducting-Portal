import mysql.connector
import numpy

def start(mydb):
	a = input("what do you want to do? \n 1) Play game \n 2)Check Leaderboard")
	if a == '1':
		playgame(mydb)
	elif a == '2':
		leaderboard(mydb)
	else:
		print("Invalid Input \n Please enter something from 1 and 2")
		start(mydb)

def leaderboard(mydb):
	mycursor = mydb.cursor()
	query = "select student.Student_name, marks.score from marks INNER JOIN student on Student.ID=marks.ID order by marks.score DESC;"
	mycursor.execute(query)
	myresult = mycursor.fetchall()
	print("Leaderboard\n")
	for x, k in myresult:
	  print(x, k)
	print("\n")
	start(mydb)

def playgame(mydb):
	mycursor = mydb.cursor()
	name = input("What is your name?")
	a = numpy.arange(9)
	a = a[1:9]
	numpy.random.shuffle(a)
	a = a[:5]
	# Find
	mycursor.execute("SELECT max(id) from student")
	myresult = mycursor.fetchall()
	for x in myresult:
		if x[0] == None:
			stu_id = 1
			break
		stu_id = x[0] + 1
	sql = "INSERT INTO student(id, Student_Name) VALUES (%s, %s)"
	mycursor.execute(sql, (stu_id, name))
	mydb.commit()
	startgame(stu_id, mydb,a)
	
def startgame(stu_id, mydb,a):
	mycursor = mydb.cursor()
	sql = "INSERT INTO questionattempt (id, QuesID) VALUES (%s, %s)"
	for x in a:
		val = (stu_id, int(x))
		mycursor.execute(sql, val)
	mydb.commit()

	mycursor = mydb.cursor()
	mycursor.execute("SELECT student.Student_name, ques_bank.Question, ques_bank.ans from questionattempt INNER JOIN student on Student.ID=questionattempt.ID INNER JOIN ques_bank on ques_bank.QuesID=questionattempt.QuesID where student.id = (%s)", (stu_id, ))
	myresult = mycursor.fetchall()
	marks = 0
	for x,v,z in myresult:
		print("please answer the following questions", x, "\n Type Y or N (Yes/No)")
		a = input(str(v) + "\n")
		if a == str(z):
			marks += 4
	print(marks)
	sql = "INSERT INTO marks(id, score) VALUES (%s, %s)"
	mycursor.execute(sql, (stu_id, marks))
	mydb.commit()
	print("\n")
	leaderboard(mydb)
	print("\n")
	start(mydb)


			
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="TAN!sh1e4459308568a", 
  database="mydb"
)


start(mydb)




