import psycopg2

moviedb_connection = psycopg2.connect(
    user="postgres",
    password="suyashgaurav72",
    host="localhost",
    port="5432",
    database="moviedb"
)

cursor = moviedb_connection.cursor()
cursor.execute("begin;")

cursor.execute("select act_id from actor")
actor_id = cursor.fetchall()[-1][0]

n = int(input("Enter the number of movies: "))
roles = list()
for i in range(n):
    movie_id = input(f"Enter movie id of movie number {i+1}: ")
    role = input(f"Enter role of the actor in movie number {i+1}: ")
    roles.append((movie_id, role))

flag = 1

for i in range(len(roles)):
    cursor.execute(f"select * from movie where mov_id = {roles[i][0]}")
    result = cursor.fetchone()
    if not result:
        print(f"Movie number {roles[i][0]} is not present in the database. Database is not updated")
        # moviedb_connection.rollback()
        cursor.execute("ROLLBACK;")
        print("ROLLBACK")
        flag=0
        break

    try:
        cursor.execute("insert into movie_cast (act_id,mov_id,role) values (%s,%s,%s)", (actor_id,roles[i][0],roles[i][1]))
    except psycopg2.Error as e:
        print("Error!! This actor has already a role in this movie.")
        print(f"DETAIL:  Key (mov_id, act_id)=({roles[i][0]}, {actor_id}) already exists")
        print("ROLLBACK")
        # moviedb_connection.rollback()
        cursor.execute("ROLLBACK;")
        flag=0
        break

if flag:
    print("Database update successfull")
else:
    print("Database is not updated!")

cursor.execute("commit;")
moviedb_connection.commit()

cursor.close()
moviedb_connection.close()
    