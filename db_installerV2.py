import csv
import mysql.connector
import os
import unicodedata
	
def strip_accents(text):
    return str(unicodedata.normalize('NFD', text).encode('ascii', 'ignore').decode("utf-8"))
	
def prepare_statement(keys, table):
	if "export" in table :
		table = "deaths"
	statement = "INSERT IGNORE INTO project_db." + table + "("
	values = "VALUES ("
	for i in range(len(keys)):
		key = ""
		if "deaths" in table:
			key = keys[i].replace(" de ", "_").replace(" du ", "_").replace("d'","").replace(" ", "_").lower()
		else :
			key = keys[i]
		if i == len(keys)-1:
			statement = statement + strip_accents(key) + ")"
			values = values + "%s)"
		else :
			statement = statement + strip_accents(key).replace('.','_') + ","
			values = values + "%s,"
	statement = statement + values
	return statement

def prepare_row(keys, row):
	rows = []
	for k in keys:
		rows.append(row[k])
	return [tuple(rows)]
	
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
			except:
				print('error')

def get_csv_files(path):
	files = []
	for r,d,f in os.walk(path):
		for file in f:
			if ".csv" in file:
				files.append(file)
	return files
				

verbose = True
sql1URL = "./" + "mySQL-1.sql"
sql2URL = "./" + "mySQL-2.sql"
db_name = "project_db"
current_path = os.getcwd() + "/"

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
	print("Create tables")
	execute_sql_file(mydb, prepare_sql_file(sql1URL))
	print("Import datas")
	files = get_csv_files(current_path)
	for i,file in enumerate(files):
		if verbose:
			print(round((i+1)/len(files)*100), "%")
		print("fill " + file.replace(".csv", "") + " table")
		with open('C:/Users/Moi/Documents/Cours/bdde/french-death/' + file, encoding='utf-8') as csvfile:
			reader = csv.DictReader(csvfile, delimiter = ',')
			sql_statement = prepare_statement(reader.fieldnames, file.replace(".csv", ""))
			for i,row in enumerate(reader):
				mycursor.executemany(sql_statement, prepare_row(reader.fieldnames, row))
				mydb.commit()
	#finish database
	print("Finish database")
	execute_sql_file(mydb,prepare_sql_file(sql2URL))

except Exception as e:	
	print("Error : ", e)

