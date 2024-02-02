import psycopg2

moviedb_connection = psycopg2.connect(
    user="postgres",
    password="suyashgaurav72",
    host="localhost",
    port="5432",
    database="moviedb"
)

cursor = moviedb_connection.cursor()

act_id = int(input("Enter actor id: "))
act_fname = input("Eneter actor's first name: ")
act_lname = input("Enter actor's last name: ")
act_gender = input("Enter actor's gender: ")

cursor.execute("Select * from actor where act_id = %s", (act_id,))
result = cursor.fetchone()

if result:
    print("Actor ID already exists")
else:
    query = "insert into actor (act_id,act_fname,act_lname,act_gender) values (%s,%s,%s,%s)", (act_id,act_fname,act_lname,act_gender)
    cursor.execute(query)
    print("Actor details inserted into the actor table successfully")

moviedb_connection.commit()

cursor.close()
moviedb_connection.close()