import psycopg2

moviedb_connection = psycopg2.connect(
    user="postgres",
    password="suyashgaurav72",
    host="localhost",
    port="5432",
    database="moviedb"
)

cursor = moviedb_connection.cursor()
try:
    cursor.execute("ALTER TABLE movie_cast ADD PRIMARY KEY (mov_id, act_id)")
    print("Declared (mov id, act id) as the primary key")
except psycopg2.Error as e:
    print("Error! (mov id, act id) Already PRIMARY KEY for movie_cast")

moviedb_connection.commit()

cursor.close()
moviedb_connection.close()