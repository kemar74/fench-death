# Need "python -m pip install mysql-connector"
# Need "python -m pip install requests"

import mysql.connector
import glob
import requests
import os
import shutil

# Thanks to nonbeing (https://stackoverflow.com/a/19159041/9863298)


verbose = True
sqlURL = "./" + "mySQL.sql"
filepath_to_replace = "A:/Uni-Nantes/BDD evoluee/Projet/"
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
	if verbose:
		print("\n[INFO] Executing SQL script file: '%s'" % (sqlURL))
	statement = ""
	try:
		lines = open(sqlURL)
	except:
		lines = requests.get(url=sqlURL).text.split("\r\n")

	fullStatements = []
	if verbose : 
		print("Reading file...")
	for i,line in enumerate(lines):
		line = line.replace(filepath_to_replace, current_path).replace("\\", "/")
		if line.strip().startswith('--'):  # ignore sql comment lines
			continue
		if not line.strip().endswith(';'):  # keep appending lines that don't end in ';'
			statement = statement + " " + line
		else:  # when you get a line ending in ';' then exec statement and reset for next statement
			fullStatements.append(statement + " " + line)
			statement = ""
	
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
				print("\n[WARN] MySQLError during execute statement \n>\t", statement)
				input("Copy-paste this line in PhpMyAdmin to execute it directly, then press ENTER to continue the program")

	print("All done!")
except Exception as e:
	print("Error : ", e)