import csv
import psycopg2


conn = psycopg2.connect(database='hospitaldb',
                        host="localhost",
                        user="postgres",
                        password="suyashgaurav72",
                        port="5432") 
                        
mycursor = conn.cursor()

with open('createTable.sql', 'r') as file:
    sql_commands = file.read()
    mycursor.execute(sql_commands)

with open("users.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO users VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4] + "\');"
        mycursor.execute(line)

with open("doctor.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO doctor VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4] + "\',\'" + record[5] + "\',\'" + record[6] + "\');"
        mycursor.execute(line)

with open("receptionist.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO receptionist VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4]+ "\',\'" + record[5] + "\');"
        mycursor.execute(line)

with open("nurse.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO nurse VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4]+ "\',\'" + record[5] + "\');"
        mycursor.execute(line)


with open("janitor.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO janitor VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3] + "\');"
        mycursor.execute(line)

with open("room.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO room VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3] + "\');"
        mycursor.execute(line)

with open("patient.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO patient VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4] + "\',\'" + record[5]+ "\',\'" + record[6] + "\');"
        mycursor.execute(line)

with open("registration.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO registration VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4] + "\');"
        mycursor.execute(line)

with open("medical_record.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO medical_record VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4]+ "\',\'" + record[5] + "\');"
        mycursor.execute(line)

with open("pharmacy.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO pharmacy VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\',\'" + record[3]+ "\',\'" + record[4]+ "\',\'" + record[5] + "\');"
        mycursor.execute(line)

conn.commit()
mycursor.close()
conn.close()