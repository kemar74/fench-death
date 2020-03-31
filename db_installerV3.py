import csv
import mysql.connector
import os
import unicodedata
import requests

	
def prepare_sql_file(sqlURL):
	statement = ""
	try:
		lines = open(sqlURL)
	except:
		lines = requests.get(url=sqlURL).text.split("\r\n")
	fullStatements = []
	if verbose : 
		print("Reading file...")
	for line in lines:
		if line.strip().startswith('--'):  # ignore sql comment lines
			continue
		if not line.strip().endswith(';'):  # keep appending lines that don't end in ';'
			statement = statement + " " + line
		else:  # when you get a line ending in ';' then exec statement and reset for next statement
			fullStatements.append(statement + " " + line)
			statement = ""
	return fullStatements
	
def execute_sql_file(mydb, fullStatements):
	for i, statement in enumerate(fullStatements):
		if verbose:
			print(round((i+1)/len(fullStatements)*100), "%")
		try:
			mycursor.execute(statement)
		except:
			try:
				mydb.database = db_name
				mycursor = mydb.cursor()
				mycursor.execute(statement)
			except mysql.connector.Error as err:
				print(err)

def get_csv_files(path):
	files = []
	for r,d,f in os.walk(path):
		for file in f:
			if ".csv" in file:
				files.append(file)
	return files
				

verbose = True
sql1URL = "https://raw.githubusercontent.com/kemar74/french-death/master/" + "mySQL-1.sql"
sql2URL = "https://raw.githubusercontent.com/kemar74/french-death/master/" + "mySQL-2.sql"
db_name = "project_db"
current_path = os.getcwd() + "\\"
current_path = current_path.replace("\\","/")

try:
	print("Opening database...")
	login = open("db_login.txt", "r").readlines()
	if len(login) < 2:
		raise Exception("Il manque des données dans le fichier \"db_login.txt\"")
	host = login[0]
	usr = login[1]
	passwd = ""
	if len(login) > 2:
		passwd = login[2]
	print("User : ", usr)
	print("Connecting...")

	mydb = mysql.connector.connect(
		host=host,
		user=usr,
		passwd=passwd
	)
	if not mydb:
		raise Exception("Unable to connect to MySQL on {}@{}".format(usr, host))
	print("Connected!")
	mycursor = mydb.cursor()
	#create table
	print("Create tables...")
	execute_sql_file(mydb, prepare_sql_file(sql1URL))
	print("Import datas...")
	files = get_csv_files(current_path)
	for i,file in enumerate(files):
		table = "deaths" if file == "export.csv" else file.replace(".csv","")
		if verbose:
			print(round((i+1)/len(files)*100), "%")
		statement = "LOAD DATA LOCAL INFILE '"+ current_path+file +"' INTO TABLE project_db." + table + " FIELDS TERMINATED BY ','ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"
		mycursor.execute(statement)
	#finish database
	print("Finish database...")
	execute_sql_file(mydb,prepare_sql_file(sql2URL))
	print("All done!")
except Exception as e:	
	print("Error : ", e)

